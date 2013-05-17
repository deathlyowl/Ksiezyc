//
//  MoonView.m
//  Ksiezyc
//
//  Created by Paweł Ksieniewicz on 16.05.2013.
//  Copyright (c) 2013 Paweł Ksieniewicz. All rights reserved.
//

#import "MoonView.h"
#import "UIBezierPath+UIGlobeBezierPath.h"

@implementation MoonView

// Replace initWithFrame with this
- (id)initWithFrame:(CGRect)frame
{
    NSLog(@"Init with frame");
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithRed:.05 green:.1 blue:.13 alpha:1];

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
        
        [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(showMoon) userInfo:nil repeats:NO];
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
    
    
    
    [shadowLayer setPath:[UIBezierPath globeCurveWithRadius:130
                                                 startScale:!mode
                                                andEndScale:1-(float)(moonScale%260)/260].CGPath];
    
    if (moonScale == scale){
        [scaleTimer invalidate];
    }
}

- (void) showMoon{
    [CATransaction setAnimationDuration:10];
    moonLayer.transform = CATransform3DConcat(CATransform3DMakeScale(1, 1, 1), CATransform3DMakeRotation(-.125, 0, 0, 1));
    moonBGLayer.transform = CATransform3DMakeScale(1, 1, 1);
}


- (void) setupLayers{
    // Niezbędna wysokość urządzenia
    height = [UIScreen mainScreen].bounds.size.height;
    
    moonBGLayer = [ShapeFactory moonBG];
    
    moonLayer = [ShapeFactory moon];
    moonLayer.transform = CATransform3DConcat(CATransform3DMakeScale(.33, .33, 1), CATransform3DMakeRotation(-.125, 0, 0, 1));
    moonBGLayer.transform = CATransform3DMakeScale(.33, .33, 1);

    shadowLayer = [ShapeFactory shadow];
    
    CATransform3D transform = CATransform3DMakeRotation(1, 0, 0, 1.0);
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:transform];
    
    animation.duration = 10;
    animation.cumulative = YES;
    animation.repeatCount = 10000;
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = [NSNumber numberWithFloat:0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:1];
    alphaAnimation.duration = 5;
    alphaAnimation.cumulative = YES;
    
    backgroundLayer = [ShapeFactory backgroundWithFrame:CGRectMake(0, 0, 320*2, height)];
    backgroundLayer.shouldRasterize = YES;
    
    [backgroundLayer addAnimation:animation forKey:@"frame"];
    [backgroundLayer addAnimation:alphaAnimation forKey:@"opacity"];

    [moonLayer setMask:shadowLayer];
    
    [self.layer addSublayer:backgroundLayer];
    [self.layer addSublayer:moonBGLayer];
    [self.layer addSublayer:moonLayer];
}

@end
