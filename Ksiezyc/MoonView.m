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
        [self setBackgroundColor:[UIColor colorWithWhite:.125 alpha:1.]];
        [self setupLayers];
        
        moon = [[Moon alloc] init];
        [moon setDate:[NSDate date]];
        
        NSLog(@"%@ [%f]", moon.phaseString, moon.percent);
        
        scale = 520 * moon.percent;
        
        
        [NSTimer scheduledTimerWithTimeInterval:0
                                         target:self
                                       selector:@selector(showMoon)
                                       userInfo:nil
                                        repeats:NO];
        
        
    }
    return self;
}

- (void) scaler {
    //scale++;
    scale %= 520;
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    BOOL mode = scale>=260;
    
    int longitude = scale%260;
    
        [path moveToPoint:CGPointMake(130, 0)];
        [path addQuadCurveToPoint:CGPointMake(260-longitude, 130) controlPoint:CGPointMake(260-longitude, 0)];
        [path addQuadCurveToPoint:CGPointMake(130, 260) controlPoint:CGPointMake(260-longitude, 260)];
        [path addQuadCurveToPoint:CGPointMake(260*mode, 130) controlPoint:CGPointMake(260*mode, 260)];
        [path addQuadCurveToPoint:CGPointMake(130, 0) controlPoint:CGPointMake(260*mode, 0)];
        [path closePath];
    
    [shadowLayer setPath:path.CGPath];
}

- (void) showMoon{
    [CATransaction setAnimationDuration:.75];
    
    moonLayer.transform = CATransform3DMakeScale(1, 1, 1);
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:.025
                                     target:self
                                   selector:@selector(scaler)
                                   userInfo:nil
                                    repeats:YES];
}

- (void) setupLayers{
    // Niezbędna wysokość urządzenia po odjęciu wysokości statusbara
    height = [UIScreen mainScreen].bounds.size.height - 20;
    
    moonLayer = [ShapeFactory moon];
    moonLayer.transform = CATransform3DMakeScale(0, 0, 1);
    
    shadowLayer = [ShapeFactory shadow];
    
    [moonLayer addSublayer:shadowLayer];
    
    [self.layer addSublayer:moonLayer];
}

@end
