//
//  MoonView.m
//  Ksiezyc
//
//  Created by Paweł Ksieniewicz on 16.05.2013.
//  Copyright (c) 2013 Paweł Ksieniewicz. All rights reserved.
//

#import "MoonView.h"

@implementation MoonView

// Replace initWithFrame with this
- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"Init with frame");
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithWhite:.12 alpha:1.]];
        [self setupLayers];
        
        moon = [[Moon alloc] init];
        [moon setDate:[NSDate date]];
        
        NSLog(@"%@ [%f]", moon.phaseString, moon.percent);
        
        scale = 520 * moon.percent;
        moonScale = -1;
        
        scaleTimer = [NSTimer scheduledTimerWithTimeInterval:.0125
                                                      target:self
                                                    selector:@selector(scaler)
                                                    userInfo:nil
                                                     repeats:YES];
    }
    return self;
}

- (void) scaler {
    moonScale++;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    BOOL mode = moonScale>=260;
    
    int longitude = moonScale%260;
    
        [path moveToPoint:CGPointMake(130, 0)];
        [path addQuadCurveToPoint:CGPointMake(260-longitude, 130) controlPoint:CGPointMake(260-longitude, 0)];
        [path addQuadCurveToPoint:CGPointMake(130, 260) controlPoint:CGPointMake(260-longitude, 260)];
        [path addQuadCurveToPoint:CGPointMake(260*!mode, 130) controlPoint:CGPointMake(260*!mode, 260)];
        [path addQuadCurveToPoint:CGPointMake(130, 0) controlPoint:CGPointMake(260*!mode, 0)];
        [path closePath];
    
    [shadowLayer setPath:path.CGPath];
    
    if (moonScale == scale){
        [scaleTimer invalidate];
        [self showMoon];
    }
}

- (void) showMoon{
    [CATransaction setAnimationDuration:.5];
    moonLayer.transform = CATransform3DMakeScale(1, 1, 1);
}

- (void) setupLayers{
    // Niezbędna wysokość urządzenia po odjęciu wysokości statusbara
    height = [UIScreen mainScreen].bounds.size.height - 20;
    
    moonLayer = [ShapeFactory moon];
    moonLayer.transform = CATransform3DMakeScale(.33, .33, 1);
    
    shadowLayer = [ShapeFactory shadow];
    
    
    [moonLayer setMask:shadowLayer];
    
    [self.layer addSublayer:moonLayer];
}

@end
