//
//  NRDRotaryInterfaceViewController.m
//  RotaryDial
//
//  Created by Joshua Sullivan on 3/24/14.
//  Copyright (c) 2014 The Nerdery. All rights reserved.
//

#import "NRDRotaryInterfaceViewController.h"
#import "NRDRotaryRingView.h"

@interface NRDRotaryInterfaceViewController () <RotaryRingViewDelegate>

@property (weak, nonatomic) IBOutlet NRDRotaryRingView *ringView;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end

@implementation NRDRotaryInterfaceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - RotaryRingViewDelegate

- (void)rotaryRingView:(NRDRotaryRingView *)rotaryRingView didSetAngle:(CGFloat)angle
{
    CGFloat factor = angle / (float)(2.0 * M_PI);
    CGFloat value = factor * 60.0f;
    self.valueLabel.text = [NSString stringWithFormat:@"%0d", (int)floorf(value)];
}

@end
