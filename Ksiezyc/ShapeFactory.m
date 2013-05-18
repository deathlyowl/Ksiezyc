//
//  ShapeFactory.m
//  Ksiezyc
//
//  Created by Paweł Ksieniewicz on 16.05.2013.
//  Copyright (c) 2013 Paweł Ksieniewicz. All rights reserved.
//

#import "ShapeFactory.h"
#import "UIBezierPath+UIGlobeBezierPath.h"

@implementation ShapeFactory

+ (CALayer *) rectWithBounds:(CGRect)bounds
                 anchorPoint:(CGPoint)anchorPoint
                 andPosition:(CGPoint)position
{
    CALayer *layer = [CALayer layer];
    layer.bounds = bounds;
    layer.anchorPoint = anchorPoint;
    layer.position = position;
    return layer;
}

+ (CALayer *) circleWithRadius:(float)radius
                   andPosition:(CGPoint)position
{
    CALayer *layer = [self rectWithBounds:CGRectMake(0, 0, 2 * radius, 2 * radius)
                              anchorPoint:CGPointMake(.5, .5)
                              andPosition:position];
    layer.cornerRadius = radius;
    return layer;
}

+ (CAShapeLayer *) shadow{
    CAShapeLayer *layer = [CAShapeLayer layer];
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(130, 0)];
    [path addQuadCurveToPoint:CGPointMake(260, 130) controlPoint:CGPointMake(260, 0)];
    [path addQuadCurveToPoint:CGPointMake(130, 260) controlPoint:CGPointMake(260, 260)];
    [path addQuadCurveToPoint:CGPointMake(260, 130) controlPoint:CGPointMake(260, 260)];
    [path addQuadCurveToPoint:CGPointMake(130, 0) controlPoint:CGPointMake(260, 0)];
    [path closePath];
    
    [layer setPath:path.CGPath];
    [layer setFillColor:[UIColor colorWithWhite:.125 alpha:1].CGColor];
    
    return layer;
}

+ (CALayer *)backgroundWithFrame:(CGRect)frame{
    CALayer *layer = [self rectWithBounds:frame
                              anchorPoint:CGPointMake(.5, .5)
                              andPosition:CGPointMake(frame.size.width/4, frame.size.height/2)];
    [layer setBounds:frame];
    
    layer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]].CGColor;

    return layer;
}

+ (CALayer *)moonBG{
    CALayer *layer = [self circleWithRadius:130 andPosition:CGPointMake(160, 160)];
    layer.cornerRadius = 130;
    layer.backgroundColor = [UIColor colorWithRed:.06 green:.11 blue:.14 alpha:1].CGColor;
    return layer;
}

+ (CALayer *) moon{
    CALayer *layer = [self circleWithRadius:130 andPosition:CGPointMake(160, 160)];
    layer.cornerRadius = 130;
    layer.backgroundColor = [UIColor colorWithHue:0.11f saturation:0.04f brightness:0.82f alpha:1.00f].CGColor;
    return layer;
}

@end
