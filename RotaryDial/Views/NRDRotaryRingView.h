//
//  NRDRotaryRingView.h
//  RotaryDial
//
//  Created by Joshua Sullivan on 3/24/14.
//  Copyright (c) 2014 The Nerdery. All rights reserved.
//

@import UIKit;

@protocol RotaryRingViewDelegate;

@interface NRDRotaryRingView : UIView

/**
 *  Get the current angle of the knob or set it, which will redraw the shape.
 */
@property (assign, nonatomic) CGFloat currentAngle;

@property (weak, nonatomic) IBOutlet id <RotaryRingViewDelegate> delegate;

@end

@protocol RotaryRingViewDelegate <NSObject>

- (void)rotaryRingView:(NRDRotaryRingView *)rotaryRingView didSetAngle:(CGFloat)angle;

@end
