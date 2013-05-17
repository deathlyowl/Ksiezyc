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

+ (CALayer *) moon;
+ (CALayer *)moonBG;
+ (CAShapeLayer *) shadow;
+ (CALayer *)backgroundWithFrame:(CGRect)frame;

@end
