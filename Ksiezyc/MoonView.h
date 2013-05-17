//
//  MoonView.h
//  Ksiezyc
//
//  Created by Paweł Ksieniewicz on 16.05.2013.
//  Copyright (c) 2013 Paweł Ksieniewicz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ShapeFactory.h"
#import "Moon.h"

@interface MoonView : UIView {
    float height;
    Moon *moon;
    
    CALayer *backgroundLayer;
    CALayer *moonLayer, *moonBGLayer;
    CAShapeLayer *shadowLayer;
    
    int scale;
    int moonScale;
        
    NSTimer *scaleTimer;
}

@end
