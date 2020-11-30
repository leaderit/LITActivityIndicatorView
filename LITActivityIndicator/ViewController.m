//
//  ViewController.m
//  LITActivityIndicator
//
//  Created by vg on 11/30/20.
//

#import "ViewController.h"
#import "LITActivityIndicator.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet LITActivityIndicator *ac1;
@property (weak, nonatomic) IBOutlet LITActivityIndicator *ac2;
@property (weak, nonatomic) IBOutlet LITActivityIndicator *ac3;
@property (weak, nonatomic) IBOutlet LITActivityIndicator *ac4;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.ac1 startAnimating];
    [self.ac2 startAnimating];
    [self.ac3 startAnimating];
    [self.ac4 startAnimating];
}


@end
