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


#pragma mark -
#pragma mark Shapes

+ (CALayer *) moonWithRadius:(float)radius andPosition:(CGPoint) position{
    CALayer *layer = [self circleWithRadius:radius
                                andPosition:position];
    layer.cornerRadius = radius;
    layer.backgroundColor = MOON_COLOR.CGColor;
    return layer;
}

+ (CALayer *)moonBackgroundWithSize:(CGSize)size
                        andPosition:(CGPoint)position{
    CALayer *layer = [self rectWithBounds:CGRectMake(0, 0, size.width, size.height)
                              anchorPoint:CGPointMake(.5, .5)
                              andPosition:position];
    layer.cornerRadius = size.height/2;
    layer.backgroundColor = DARK_SIDE_OF_THE_MOON_COLOR.CGColor;
    return layer;
}

+ (CALayer *) background{
    CALayer *layer = [self rectWithBounds:CGRectMake(0, 0, ROTATIONAL_BACKGROUND_SIZE, ROTATIONAL_BACKGROUND_SIZE)
                              anchorPoint:CGPointMake(.5, .5)
                              andPosition:CGPointMake(WIDTH/2, HEIGHT/2)];
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
    [label setForegroundColor:MOON_COLOR.CGColor];
    return label;
}

+ (CATextLayer *)titleLabel{
    CATextLayer *label = [[CATextLayer alloc] init];
    [label setFont:@"AvenirNextCondensed-DemiBoldItalic"];
    [label setFontSize:40];
    [label setAnchorPoint:CGPointMake(0, 0)];
    [label setBounds:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [label setPosition:CGPointMake(0, HEIGHT/2 - 40)];
    [label setAlignmentMode:kCAAlignmentCenter];
    [label setForegroundColor:MOON_COLOR.CGColor];
    [label setString:@"Księżyc"];
    return label;
}

@end