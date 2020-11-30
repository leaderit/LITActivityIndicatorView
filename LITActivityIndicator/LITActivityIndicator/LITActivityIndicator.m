//
//  LITActivityIndicator.m
//  Leader IT Extended Activity Indicator
//
//  Created by Valerii Grazhdankin on 11/28/20.
//

#import "LITActivityIndicator.h"

@interface LITActivityIndicator()
{
    CGRect indicatorBounds;
}

@property (nonatomic, strong) UIImageView * staticView;
@property (nonatomic, strong) UIImageView * dynamicView;
@property (nonatomic, strong) CAKeyframeAnimation * animation;
@end

@implementation LITActivityIndicator

- (instancetype) init
{
    if (self = [super init]) [self configure];
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame
{
    if ( self = [super initWithFrame:frame]) [self configure];
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)coder
{
    if ( self = [super initWithCoder:coder] ) [self configure];
    return self;
}

-(instancetype)initWithImage:(UIImage*)image
{
    self = [self initWithImages:image staticImage:nil];
    return self;
}

-(id)initWithImages:(UIImage*) image staticImage:( UIImage  * _Nullable ) staticImage
{
    if( self = [self initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge] ) {
        self.image = image;
        self.staticImage = staticImage;
        [self configure];
    }
    return self;
}

-(void) setStaticImage:(UIImage *)staticImage
{
    _staticImage = [staticImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self configureAnimation];
}

-(void) setImage:(UIImage *)image
{
    _image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self configureAnimation];
}

-(void) setSteps:(int)steps
{
    _steps = steps;
    [self configureAnimation];
}

-(void) setDuration:(double)duration
{
    _duration = duration;
    [self configureAnimation];
}

-(void) configure
{
    self.steps = 8;
    self.duration = 1.0;
    indicatorBounds = self.subviews[0].bounds;
    [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    if ( self.image == nil ) self.image = [[UIImage imageNamed:@"ActivityIndicator"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.dynamicView = [[UIImageView alloc] initWithFrame:indicatorBounds];
    self.staticView = [[UIImageView alloc] initWithFrame:indicatorBounds];
    [self addSubview:self.dynamicView];
    [self addSubview:self.staticView];
    self.animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    self.animation.removedOnCompletion = NO;
    self.animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    self.animation.repeatCount = HUGE_VAL;
    [self configureAnimation];
}


-(void) configureAnimation
{
    CGFloat value_from = 0.0;
    CGFloat value_to = 2*M_PI;

    CAKeyframeAnimation *animation = self.animation;
    if ( self.steps >1 ) {
        animation.calculationMode = kCAAnimationDiscrete;
        CGFloat step = value_to / self.steps;
        CGFloat step_value = value_from;
        NSMutableArray <NSNumber *> *values = [[NSMutableArray alloc] initWithCapacity:self.steps];
        for (int i = 0; i < self.steps; i++ ) {
            values[i] = @(step_value);
            step_value += step;
        }
        animation.values = values;
    } else {
        animation.values = [NSArray arrayWithObjects:@(value_from), @(value_to), nil];;
        animation.calculationMode = kCAAnimationLinear;
    }
    animation.duration = self.duration;
    CGRect bounds = indicatorBounds;
    CGPoint center = CGPointMake(CGRectGetMidY(self.bounds), CGRectGetMidY(self.bounds));
    self.staticView.bounds = bounds;
    self.dynamicView.bounds = bounds;
    self.staticView.center = center;
    self.dynamicView.center = center;
    self.dynamicView.image = self.image;
    self.staticView.image = self.staticImage;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//
//}

-(void)startAnimating
{
    [super startAnimating];
    self.staticView.hidden = NO;
    self.dynamicView.hidden = NO;
    [self.dynamicView.layer addAnimation:self.animation forKey:@"indicatorAnimation"];
}

-(void)stopAnimating
{
    [super stopAnimating];
    if ( self.hidesWhenStopped ) {
        self.staticView.hidden = YES;
        self.dynamicView.hidden = YES;
    }
    [self.dynamicView.layer removeAllAnimations];
}

@end
