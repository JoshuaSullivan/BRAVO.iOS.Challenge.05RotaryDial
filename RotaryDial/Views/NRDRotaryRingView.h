//
//  NRDRotaryRingView.h
//  RotaryDial
//
//  Created by Joshua Sullivan on 3/24/14.
//  Copyright (c) 2014 The Nerdery. All rights reserved.
//

@import UIKit;

#define M_2PI (2.0 * M_PI)

@protocol RotaryRingViewDelegate;

@interface NRDRotaryRingView : UIView

/**
 *  Get the current angle of the knob or set it, which will redraw the shape.
 */
@property (assign, nonatomic) double currentAngle;

@property (weak, nonatomic) IBOutlet id <RotaryRingViewDelegate> delegate;

@end

@protocol RotaryRingViewDelegate <NSObject>

- (void)rotaryRingView:(NRDRotaryRingView *)rotaryRingView didSetAngle:(double)angle;

@end
