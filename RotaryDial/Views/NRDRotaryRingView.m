//
//  NRDRotaryRingView.m
//  RotaryDial
//
//  Created by Joshua Sullivan on 3/24/14.
//  Copyright (c) 2014 The Nerdery. All rights reserved.
//

@import QuartzCore;
#import "NRDRotaryRingView.h"

const CGFloat kOuterRadiusMultiplier = 1.0f;
const CGFloat kInnerRadiusMultiplier = 0.6f;
const CGFloat kKnobArcAngle = M_PI / 8.0f;


@interface NRDRotaryRingView () {
    CGFloat _outerRadius;
    CGFloat _innerRadius;
    CGPoint _centerPoint;
    CGRect _outerBounds;
    CGRect _innerBounds;
}

@property (strong, nonatomic) UIColor *ringFillColor;
@property (strong, nonatomic) UIColor *knobFillColor;

@end

@implementation NRDRotaryRingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitWithFrame:frame];
    }
    return self;
}

- (void)awakeFromNib
{
    [self commonInitWithFrame:self.frame];
}

- (void)commonInitWithFrame:(CGRect)frame
{
    CGFloat shortSide = fminf(frame.size.width, frame.size.height);
    _outerRadius = shortSide / 2.0f * kOuterRadiusMultiplier;
    _innerRadius = shortSide / 2.0f * kInnerRadiusMultiplier;
    _centerPoint = CGPointMake(frame.size.width / 2.0f, frame.size.height / 2.0f);
    CGFloat w0 = shortSide * kOuterRadiusMultiplier;
    CGFloat w1 = shortSide * kInnerRadiusMultiplier;
    CGFloat x0 = (frame.size.width - w0) / 2.0f;
    CGFloat y0 = (frame.size.height - w0) / 2.0f;
    CGFloat x1 = (frame.size.width - w1) / 2.0f;
    CGFloat y1 = (frame.size.height - w1) / 2.0f;
    _outerBounds = CGRectMake(x0, y0, w0, w0);
    _innerBounds = CGRectMake(x1, y1, w1, w1);
    self.currentAngle = -M_PI_2;
    self.ringFillColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
    self.knobFillColor = [UIColor colorWithWhite:0.4f alpha:1.0f];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSaveGState(c);
    
    // Clear the old drawing
    CGContextClearRect(c, _outerBounds);
    
    // Draw the ring
    CGContextBeginPath(c);
    CGContextAddEllipseInRect(c, _outerBounds);
    CGContextAddEllipseInRect(c, _innerBounds);
    CGContextSetFillColorWithColor(c, self.ringFillColor.CGColor);
    CGContextClosePath(c);
    CGContextEOFillPath(c);
    
    // Calculate values for drawing the knob
    CGFloat a0 = _currentAngle - kKnobArcAngle;
    CGFloat a1 = _currentAngle + kKnobArcAngle;
    CGFloat x0 = cosf(a0) * _outerRadius + _centerPoint.x;
    CGFloat y0 = sinf(a0) * _outerRadius + _centerPoint.y;
    
    // Draw the knob
    CGContextBeginPath(c);
    CGContextMoveToPoint(c, x0, y0);
    CGContextAddArc(c, _centerPoint.x, _centerPoint.y, _outerRadius, a0, a1, 0);
    CGContextAddArc(c, _centerPoint.x, _centerPoint.y, _innerRadius, a1, a0, 1);
    CGContextClosePath(c);
    CGContextSetFillColorWithColor(c, self.knobFillColor.CGColor);
    CGContextFillPath(c);
    CGContextRestoreGState(c);
}

- (void)setCurrentAngle:(CGFloat)currentAngle
{
    if (currentAngle != _currentAngle) {
        _currentAngle = currentAngle;
        [self setNeedsDisplay];
    }
}

@end
