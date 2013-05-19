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

+ (CALayer *) moonWithRadius:(float)radius andPosition:(CGPoint) position;
+ (CALayer *) moonBackgroundWithSize:(CGSize)size andPosition:(CGPoint)position;
+ (CALayer *) background;
+ (CATextLayer *)labelWithBounds:(CGRect)bounds andPosition:(CGPoint)position;
+ (CATextLayer *)titleLabel;

@end