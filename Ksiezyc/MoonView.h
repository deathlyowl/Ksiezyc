//
//  MoonView.h
//  Ksiezyc
//
//  Created by Paweł Ksieniewicz on 16.05.2013.
//  Copyright (c) 2013 Paweł Ksieniewicz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShapeFactory.h"

@interface MoonView : UIView {
    float angle;
    
    CALayer *nearBackgroundLayer, *farBackgroundLayer;
    CALayer *moonLayer, *moonBGLayer, *nextMoonLayer, *nextMoonBGLayer;
    CAShapeLayer *shadowLayer, *nextShadowLayer;
    
    CATextLayer *nextMoonLabel;    
}

- (void) showMoon;
- (void) animateBackground;

- (void) setNextMoonText:(NSString *)string;

- (void) animateMoonToPercentage:(float)percentage;
- (void) animateNextMoonToPercentage:(float)percentage;

@end