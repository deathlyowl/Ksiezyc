//
//  UIBezierPath+UIGlobeBezierPath.h
//  Ksiezyc
//
//  Created by Paweł Ksieniewicz on 17.05.2013.
//  Copyright (c) 2013 Paweł Ksieniewicz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (UIGlobeBezierPath)

+ (UIBezierPath *) globeCurveWithRadius:(float)radius
                             startScale:(float)startScale
                            andEndScale:(float)endScale;

@end
