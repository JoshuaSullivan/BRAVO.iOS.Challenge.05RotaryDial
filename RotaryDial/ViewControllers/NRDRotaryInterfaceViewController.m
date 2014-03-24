//
//  NRDRotaryInterfaceViewController.m
//  RotaryDial
//
//  Created by Joshua Sullivan on 3/24/14.
//  Copyright (c) 2014 The Nerdery. All rights reserved.
//

#import "NRDRotaryInterfaceViewController.h"
#import "NRDRotaryRingView.h"

@interface NRDRotaryInterfaceViewController ()

@property (weak, nonatomic) IBOutlet NRDRotaryRingView *ringView;

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
