//
//  MoonView.m
//  Ksiezyc
//
//  Created by Paweł Ksieniewicz on 16.05.2013.
//  Copyright (c) 2013 Paweł Ksieniewicz. All rights reserved.
//

#import "MoonView.h"
#import "UIBezierPath+UIGlobeBezierPath.h"
#import <tgmath.h>

#define MOON_RADIUS 130
#define NEXT_MOON_RADIUS 20

@implementation MoonView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayers];
    }
    return self;
}

- (void) setNextMoonText:(NSString *)string{
    [nextMoonLabel setString:string];
}

- (void) animateMoonToPercentage:(float)percentage{    
    float start = percentage >= .5;
    float end = fmod(percentage * 2, 1);
    [shadowLayer setPath:[UIBezierPath globeCurveWithRadius:MOON_RADIUS
                                                 startScale:start
                                                andEndScale:end].CGPath];
}

- (void) animateNextMoonToPercentage:(float)percentage{
    float start = !(percentage > .5);
    float end = fmod(percentage * 2, 1);
        
    [nextShadowLayer setPath:[UIBezierPath globeCurveWithRadius:NEXT_MOON_RADIUS
                                                     startScale:start
                                                    andEndScale:end].CGPath];
}

- (void) showMoon{
    [CATransaction setAnimationDuration:10];
    moonLayer.transform = CATransform3DConcat(CATransform3DMakeScale(1, 1, 1), CATransform3DMakeRotation(M_PI + .2, 0, 0, 1));
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
    
    
    moonLayer.transform = CATransform3DConcat(CATransform3DMakeScale(.33, .33, 1), CATransform3DMakeRotation(M_PI + .2, 0, 0, 1));
    moonBGLayer.transform = CATransform3DMakeScale(.33, .33, 1);

    nextMoonLayer.transform = CATransform3DMakeRotation(.2, 0, 0, 1);
    
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
