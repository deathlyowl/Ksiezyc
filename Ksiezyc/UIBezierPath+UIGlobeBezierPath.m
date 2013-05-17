//
//  UIBezierPath+UIGlobeBezierPath.m
//  Ksiezyc
//
//  Created by Paweł Ksieniewicz on 17.05.2013.
//  Copyright (c) 2013 Paweł Ksieniewicz. All rights reserved.
//

#import "UIBezierPath+UIGlobeBezierPath.h"
#import <math.h>

@implementation UIBezierPath (UIGlobeBezierPath)

+ (UIBezierPath *) globeCurveWithRadius:(float)radius
                             startScale:(float)startScale
                            andEndScale:(float)endScale
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    float startPoint = (2*radius) * startScale;
    float endPoint = (2*radius) * endScale;
        
    [path moveToPoint:CGPointMake(radius, 0)];

    [path addQuadCurveToPoint:CGPointMake(startPoint, radius) controlPoint:CGPointMake(startPoint, 0)];
    [path addQuadCurveToPoint:CGPointMake(radius, 2*radius) controlPoint:CGPointMake(startPoint, 2*radius)];
    
    [path addQuadCurveToPoint:CGPointMake(endPoint, radius) controlPoint:CGPointMake(endPoint, 2*radius)];
    [path addQuadCurveToPoint:CGPointMake(radius, 0) controlPoint:CGPointMake(endPoint, 0)];
    
    return path;
}

@end
