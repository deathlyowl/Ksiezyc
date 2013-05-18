//
//  ShapeFactory.h
//  Ksiezyc
//
//  Created by Paweł Ksieniewicz on 16.05.2013.
//  Copyright (c) 2013 Paweł Ksieniewicz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface ShapeFactory : NSObject


+ (CALayer *) moonWithRadius:(float)radius
                 andPosition:(CGPoint) position;
+ (CALayer *)moonBGWithSize:(CGSize)size
                andPosition:(CGPoint)position;
+ (CAShapeLayer *) shadowWithRadius:(float)radius;
+ (CALayer *)backgroundWithFrame:(CGRect)frame;
+ (CALayer *)backgroundTwoWithFrame:(CGRect)frame;
+ (CATextLayer *)labelWithBounds:(CGRect)bounds
                     andPosition:(CGPoint)position;
@end
