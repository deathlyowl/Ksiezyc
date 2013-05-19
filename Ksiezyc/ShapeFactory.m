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

+ (CATextLayer *)labelWithBounds:(CGRect)bounds
                     andPosition:(CGPoint)position
{
    CATextLayer *label = [[CATextLayer alloc] init];
    
    [label setFont:@"AvenirNextCondensed-Italic"];
    
    [label setFontSize:20];
    [label setAnchorPoint:CGPointMake(.5, .5)];
    [label setBounds:bounds];
    [label setPosition:position];
    [label setAlignmentMode:kCAAlignmentCenter];
    [label setForegroundColor:[UIColor colorWithHue:0.11f saturation:0.04f brightness:0.82f alpha:1.00f].CGColor];

    return label;
}

+ (CAShapeLayer *) shadowWithRadius:(float)radius{
    CAShapeLayer *layer = [CAShapeLayer layer];
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(radius, 0)];
    [path addQuadCurveToPoint:CGPointMake(radius*2, radius) controlPoint:CGPointMake(radius*2, 0)];
    [path addQuadCurveToPoint:CGPointMake(radius, radius*2) controlPoint:CGPointMake(radius*2, radius*2)];
    [path addQuadCurveToPoint:CGPointMake(radius*2, radius) controlPoint:CGPointMake(radius*2, radius*2)];
    [path addQuadCurveToPoint:CGPointMake(radius, 0) controlPoint:CGPointMake(radius*2, 0)];
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



+ (CALayer *)backgroundTwoWithFrame:(CGRect)frame{
    CALayer *layer = [self rectWithBounds:frame
                              anchorPoint:CGPointMake(.5, .5)
                              andPosition:CGPointMake(frame.size.width/4, frame.size.height/2)];
    [layer setBounds:frame];
    
    layer.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backgroundTwo"]].CGColor;
    
    return layer;
}

+ (CALayer *)moonBGWithSize:(CGSize)size
                andPosition:(CGPoint)position{
    CALayer *layer = [self rectWithBounds:CGRectMake(0, 0, size.width, size.height)
                              anchorPoint:CGPointMake(.5, .5)
                              andPosition:position];
    layer.cornerRadius = size.height/2;
    layer.backgroundColor = [UIColor colorWithRed:.06 green:.11 blue:.14 alpha:1].CGColor;
    return layer;
}


+ (CALayer *) moonWithRadius:(float)radius andPosition:(CGPoint) position{
    CALayer *layer = [self circleWithRadius:radius
                                andPosition:position];
    layer.cornerRadius = radius;
    layer.backgroundColor = [UIColor colorWithHue:0.11f saturation:0.04f brightness:0.82f alpha:1.00f].CGColor;
    return layer;
}

@end
