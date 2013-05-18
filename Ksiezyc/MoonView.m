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

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        moon = [Moon moonWithDate:[NSDate date]];
        [self setupLayers];
        moonScale = nextMoonScale = -1;
        
        NSString *nextMoonText = [NSString stringWithFormat:@"%@ za %i dni",
                                  [Moon phaseStringWithPhase:[Moon phaseWithProgress:moon.nextProgress]],
                                  (int)(moon.nextProgress-moon.progress)];
        
        [nextMoonLabel setString:nextMoonText];
        scaleTimer = [NSTimer scheduledTimerWithTimeInterval:.0125
                                                      target:self
                                                    selector:@selector(scaler)
                                                    userInfo:nil
                                                     repeats:YES];
        
        nextScaleTimer = [NSTimer scheduledTimerWithTimeInterval:.0625
                                                          target:self
                                                        selector:@selector(nextScaler)
                                                        userInfo:nil
                                                         repeats:YES];
        
    }
    return self;
}

- (void) scaler {
    moonScale++;
    
    [shadowLayer setPath:[UIBezierPath globeCurveWithRadius:130
                                                 startScale:moonScale < 260
                                                andEndScale:1-(float)(moonScale%260)/260].CGPath];
    
    if (moonScale == (int)(520 * [Moon percentWithProgress:moon.progress])) [scaleTimer invalidate];
}

- (void) nextScaler {
    nextMoonScale++;
    
    if (nextMoonScale!=80) {
        [nextShadowLayer setPath:[UIBezierPath globeCurveWithRadius:20
                                                         startScale:nextMoonScale < 40
                                                        andEndScale:1-(float)(nextMoonScale%40)/40].CGPath];
    }
    else{
        [nextShadowLayer setPath:[UIBezierPath globeCurveWithRadius:20
                                                         startScale:0
                                                        andEndScale:0].CGPath];
        
    }
    
    if (nextMoonScale == (int)(80 * [Moon percentWithProgress:moon.nextProgress])) [nextScaleTimer invalidate];
}

- (void) showMoon{
    [CATransaction setAnimationDuration:10];
    moonLayer.transform = CATransform3DConcat(CATransform3DMakeScale(1, 1, 1), CATransform3DMakeRotation(-.125, 0, 0, 1));
    moonBGLayer.transform = CATransform3DMakeScale(1, 1, 1);
}


- (void) setupLayers{
    // Niezbędna wysokość urządzenia
    height = [UIScreen mainScreen].bounds.size.height;
    
    nextMoonLabel = [ShapeFactory labelWithBounds:CGRectMake(0, 0, 260, 40) andPosition:CGPointMake(160, height-55)];
    
    self.backgroundColor = [UIColor colorWithRed:.05 green:.1 blue:.13 alpha:1];
    
    moonBGLayer = [ShapeFactory moonBGWithSize:CGSizeMake(260, 260)
                                   andPosition:CGPointMake(160, 160)];
    
    moonLayer = [ShapeFactory moonWithRadius:130
                                 andPosition:CGPointMake(160, 160)];
    
    
    nextMoonBGLayer = [ShapeFactory moonBGWithSize:CGSizeMake(260, 40)
                                   andPosition:CGPointMake(160, height-60)];
    
    
    nextMoonLayer = [ShapeFactory moonWithRadius:20
                                 andPosition:CGPointMake(50, height-60)];
    
    
    moonLayer.transform = CATransform3DConcat(CATransform3DMakeScale(.33, .33, 1), CATransform3DMakeRotation(-.125, 0, 0, 1));
    moonBGLayer.transform = CATransform3DMakeScale(.33, .33, 1);

    shadowLayer = [ShapeFactory shadowWithRadius:130];
    nextShadowLayer = [ShapeFactory shadowWithRadius:20];
    
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = [NSNumber numberWithFloat:0];
    alphaAnimation.toValue = [NSNumber numberWithFloat:1];
    alphaAnimation.duration = 5;
    alphaAnimation.cumulative = YES;
    
    backgroundLayer = [ShapeFactory backgroundWithFrame:CGRectMake(0, 0, 320*2, height)];
    backgroundTwoLayer = [ShapeFactory backgroundTwoWithFrame:CGRectMake(0, 0, 320*2, height)];
    backgroundLayer.shouldRasterize = YES;
    
    [backgroundLayer addAnimation:alphaAnimation forKey:@"opacity"];
    [backgroundTwoLayer addAnimation:alphaAnimation forKey:@"opacity"];

    [moonLayer setMask:shadowLayer];
    [nextMoonLayer setMask:nextShadowLayer];
    
    [self.layer addSublayer:backgroundTwoLayer];
    [self.layer addSublayer:backgroundLayer];
    [self.layer addSublayer:moonBGLayer];
    [self.layer addSublayer:moonLayer];
    [self.layer addSublayer:nextMoonBGLayer];
    
    [self.layer addSublayer:nextMoonLayer];
    
    [self.layer addSublayer:nextMoonLabel];
}

- (void) animateBackground {
    CATransform3D transform = CATransform3DMakeRotation(1, 0, 0, 1.0);
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:transform];
    animation.duration = 10;
    animation.cumulative = YES;
    animation.repeatCount = 10000;
    
    CABasicAnimation* animationTwo = [CABasicAnimation animationWithKeyPath:@"transform"];
    animationTwo.toValue = [NSValue valueWithCATransform3D:transform];
    animationTwo.duration = 20;
    animationTwo.cumulative = YES;
    animationTwo.repeatCount = 10000;
    
    [backgroundLayer addAnimation:animation forKey:@"frame"];
    [backgroundTwoLayer addAnimation:animationTwo forKey:@"frame"];
}

@end
