//
//  LITActivityIndicator.h
//  Leader IT Extended Activity Indicator
//
//  Created by Valerii Grazhdankin on 11/28/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface LITActivityIndicatorView : UIActivityIndicatorView

@property (nonatomic, strong) IBInspectable UIImage * image;
@property (nonatomic, strong) IBInspectable UIImage * staticImage;
@property (nonatomic, assign) IBInspectable int steps;
@property (nonatomic, assign) IBInspectable double duration;

-(id)initWithImage:( UIImage* ) image;
-(id)initWithImages:( UIImage* ) image staticImage:( UIImage * _Nullable ) staticImage;

@end

NS_ASSUME_NONNULL_END
