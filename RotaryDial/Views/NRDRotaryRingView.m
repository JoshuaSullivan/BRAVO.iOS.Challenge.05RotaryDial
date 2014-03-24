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
const CGFloat kKnobArcAngle = (float)M_PI / 8.0f;

typedef NS_ENUM(NSInteger, RotaryRingTouchRegion) {

    /** The touch point is outside the ring and outside the knob. */
    RotaryRingTouchRegionOutside = 0,

    /** The touch point is inside the knob. */
    RotaryRingTouchRegionInsideKnob,

    /** The touch point is inside the ring, clockwise from the knob. */
    RotaryRingTouchRegionClockwiseFromKnob,

    /** The touch point is inside the ring, couterclockwise from the knob. */
    RotaryRingTouchRegionCounterclockwiseFromKnob
};

@interface NRDRotaryRingView () {
    /** The calculated outer radius of the ring and knob. */
    CGFloat _outerRadius;

    /** The calcualted inner radius of the ring and knob. */
    CGFloat _innerRadius;

    /** The center point from which the knob and ring are drawn. */
    CGPoint _centerPoint;

    /** The bounding box of the outer edge of the ring. */
    CGRect _outerBounds;

    /** The bonding box of the inner edge of the ring. */
    CGRect _innerBounds;
}

/** The fill color for the ring. */
@property (strong, nonatomic) UIColor *ringFillColor;

/** The fill color for the knob. */
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
    // We want the biggest circle that fits inside the bounds of this view.
    CGFloat shortSide = fminf(frame.size.width, frame.size.height);

    // Calculate the inner and outer radii
    _outerRadius = shortSide / 2.0f * kOuterRadiusMultiplier;
    _innerRadius = shortSide / 2.0f * kInnerRadiusMultiplier;

    // Store the center point of the rings
    _centerPoint = CGPointMake(frame.size.width / 2.0f, frame.size.height / 2.0f);

    // Calculate components needed to create the bounding frames for the inner and outer ring edges.
    CGFloat w0 = shortSide * kOuterRadiusMultiplier;
    CGFloat w1 = shortSide * kInnerRadiusMultiplier;
    CGFloat x0 = (frame.size.width - w0) / 2.0f;
    CGFloat y0 = (frame.size.height - w0) / 2.0f;
    CGFloat x1 = (frame.size.width - w1) / 2.0f;
    CGFloat y1 = (frame.size.height - w1) / 2.0f;
    _outerBounds = CGRectMake(x0, y0, w0, w0);
    _innerBounds = CGRectMake(x1, y1, w1, w1);

    // The initial postion of the knob is "North".
    self.currentAngle = (float)-M_PI_2;

    // Set the fill colors for the ring and knob.
    self.ringFillColor = [UIColor colorWithWhite:0.8f alpha:1.0f];
    self.knobFillColor = [UIColor colorWithWhite:0.4f alpha:1.0f];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSaveGState(c);
    
    // Clear the old drawing
    CGContextSetFillColorWithColor(c, [UIColor clearColor].CGColor);
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

#pragma mark - Touch helper methods

- (RotaryRingTouchRegion)calculateTouchRegionForPoint:(CGPoint)touchPoint
{
    CGPoint radialPoint = CGPointMake(touchPoint.x - _centerPoint.x, touchPoint.y - _centerPoint.y);
    CGFloat radius = sqrtf(powf(radialPoint.x, 2.0f) + powf(radialPoint.y, 2.0f));
    CGFloat angle = atan2f(radialPoint.y, radialPoint.x);
    return RotaryRingTouchRegionInsideKnob;
}

@end
