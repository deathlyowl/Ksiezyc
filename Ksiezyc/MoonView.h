//
//  MoonView.h
//  Ksiezyc
//
//  Created by Paweł Ksieniewicz on 16.05.2013.
//  Copyright (c) 2013 Paweł Ksieniewicz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShapeFactory.h"
#import "Moon.h"

@interface MoonView : UIView {
    float height;
    Moon *moon;
    
    CALayer *backgroundLayer, *backgroundTwoLayer;
    CALayer *moonLayer, *moonBGLayer, *nextMoonLayer, *nextMoonBGLayer;
    CAShapeLayer *shadowLayer, *nextShadowLayer;
    
    CATextLayer *nextMoonLabel;
    
    int moonScale, nextMoonScale;
        
    NSTimer *scaleTimer, *nextScaleTimer;
}

- (void) showMoon;
- (void) animateBackground;

@end
