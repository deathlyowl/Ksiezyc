//
//  ShapeFactory.m
//  Ksiezyc
//
//  Created by Paweł Ksieniewicz on 16.05.2013.
//  Copyright (c) 2013 Paweł Ksieniewicz. All rights reserved.
//

#import "ShapeFactory.h"

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
    [path addQuadCurveToPoint:CGPointMake(0, 130) controlPoint:CGPointMake(0, 260)];
    [path addQuadCurveToPoint:CGPointMake(130, 0) controlPoint:CGPointMake(0, 0)];
    [path closePath];
    
    [layer setPath:path.CGPath];
    [layer setFillColor:[UIColor colorWithWhite:.125 alpha:1].CGColor];
    
    return layer;
}


+ (CALayer *) moon{
    CALayer *layer = [self circleWithRadius:130 andPosition:CGPointMake(160, 160)];
    layer.cornerRadius = 130;
    layer.backgroundColor = [UIColor colorWithHue:.175 saturation:.3 brightness:.5 alpha:1].CGColor;
    layer.masksToBounds = YES;

    CALayer *craterOne = [self circleWithRadius:80 andPosition:CGPointMake(80, 240)];
    CALayer *craterTwo = [self circleWithRadius:45 andPosition:CGPointMake(30, 120)];
    CALayer *craterThree = [self circleWithRadius:30 andPosition:CGPointMake(110, 140)];
    CALayer *craterFour = [self circleWithRadius:35 andPosition:CGPointMake(100, 70)];
    CALayer *craterFive = [self circleWithRadius:30 andPosition:CGPointMake(155, 95)];
    CALayer *craterSix = [self circleWithRadius:15 andPosition:CGPointMake(170, 200)];
    CALayer *craterSeven = [self circleWithRadius:15 andPosition:CGPointMake(180, 130)];
    CALayer *craterEight = [self circleWithRadius:15 andPosition:CGPointMake(190, 80)];
    CALayer *craterNine = [self circleWithRadius:15 andPosition:CGPointMake(170, 50)];

    craterOne.backgroundColor = craterTwo.backgroundColor = craterThree.backgroundColor = craterFour.backgroundColor = craterFive.backgroundColor =
    craterSix.backgroundColor = craterSeven.backgroundColor = craterEight.backgroundColor = craterNine.backgroundColor = [UIColor colorWithHue:.175 saturation:.3 brightness:.4 alpha:1].CGColor;
    
    [layer addSublayer:craterOne];
    [layer addSublayer:craterTwo];
    [layer addSublayer:craterThree];
    [layer addSublayer:craterFour];
    [layer addSublayer:craterFive];
    [layer addSublayer:craterSix];
    [layer addSublayer:craterSeven];
    [layer addSublayer:craterEight];
    [layer addSublayer:craterNine];
    
    
    return layer;
}



@end
