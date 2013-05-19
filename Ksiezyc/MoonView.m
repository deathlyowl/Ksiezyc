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
#define INITIAL_SCALE .33

#pragma mark -

@implementation MoonView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self){
        angle = -15 * M_PI/180.;
        [self setupLayers];
        [self setBackgroundColor:BACKGROUND_COLOR];
    }
    return self;
}

- (void) setupLayers{    
    // Używając fabryki, tworzymy wszystkie warstwy
    nextMoonLabel = [ShapeFactory labelWithBounds:CGRectMake(0, 0, 260, 40) andPosition:CGPointMake(WIDTH/2, HEIGHT-55)];
    
    titleLabel = [ShapeFactory titleLabel];
    
    moonBGLayer = [ShapeFactory moonBackgroundWithSize:CGSizeMake(MOON_RADIUS*2, MOON_RADIUS*2) andPosition:CGPointMake(WIDTH/2, WIDTH/2)];
    nextMoonBGLayer = [ShapeFactory moonBackgroundWithSize:CGSizeMake(MOON_RADIUS*2, NEXT_MOON_RADIUS*2) andPosition:CGPointMake(WIDTH/2, HEIGHT-60)];
    moonLayer = [ShapeFactory moonWithRadius:MOON_RADIUS andPosition:CGPointMake(WIDTH/2, WIDTH/2)];
    nextMoonLayer = [ShapeFactory moonWithRadius:NEXT_MOON_RADIUS andPosition:CGPointMake(50, HEIGHT-60)];
    
    shadowLayer = [CAShapeLayer layer];
    nextShadowLayer = [CAShapeLayer layer];
    
    nearBackgroundLayer = [ShapeFactory background];
    farBackgroundLayer = [ShapeFactory background];
    [nearBackgroundLayer setBackgroundColor:NEAR_BACKGROUND_COLOR.CGColor];
    [farBackgroundLayer setBackgroundColor:FAR_BACKGROUND_COLOR.CGColor];
    
    moonLayer.transform = CATransform3DConcat(CATransform3DMakeScale(INITIAL_SCALE, INITIAL_SCALE, 1), CATransform3DMakeRotation(angle, 0, 0, 1));
    moonBGLayer.transform = CATransform3DMakeScale(INITIAL_SCALE, INITIAL_SCALE, 1);
    nextMoonLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1);
    
    
    // I tapetujemy
    // Splash
    //[self.layer addSublayer:titleLabel];

    // Tło
    [self.layer addSublayer:farBackgroundLayer];
    [self.layer addSublayer:nearBackgroundLayer];

    // Księżyc
    [moonLayer setMask:shadowLayer];
    [self.layer addSublayer:moonBGLayer];
    [self.layer addSublayer:moonLayer];
    
    // Dolna etykietka
    [nextMoonLayer setMask:nextShadowLayer];
    [self.layer addSublayer:nextMoonBGLayer];
    [self.layer addSublayer:nextMoonLayer];
    [self.layer addSublayer:nextMoonLabel];
}

#pragma mark -
#pragma mark Pozycjonowanie

- (void) setNextMoonText:(NSString *)string{
    [nextMoonLabel setString:string];
}

- (void) animateMoonToPercentage:(float)percentage{
    [self animateLayer:shadowLayer
            withRadius:MOON_RADIUS
          toPercentage:percentage];
}

- (void) animateNextMoonToPercentage:(float)percentage{
    [self animateLayer:nextShadowLayer
            withRadius:NEXT_MOON_RADIUS
          toPercentage:percentage];
}

- (void) animateLayer:(CAShapeLayer *)layer
           withRadius:(float)radius
         toPercentage:(float)percentage{
    [layer setPath:[UIBezierPath globeCurveWithRadius:radius
                                           startScale:percentage >= .5
                                          andEndScale:fmod(percentage * 2, 1)].CGPath];
}

#pragma mark -
#pragma mark Animacje

- (void) showMoon{
    [CATransaction setAnimationDuration:10];
    moonLayer.transform = CATransform3DConcat(CATransform3DMakeScale(1, 1, 1), CATransform3DMakeRotation(angle, 0, 0, 1));
    moonBGLayer.transform = CATransform3DMakeScale(1, 1, 1);
    
    CABasicAnimation *showSlowly = [CABasicAnimation animationWithKeyPath:@"opacity"];
    CABasicAnimation *showFast = [CABasicAnimation animationWithKeyPath:@"opacity"];
    CABasicAnimation *hideFast = [CABasicAnimation animationWithKeyPath:@"opacity"];
    
    showSlowly.fromValue = showFast.fromValue = hideFast.toValue = [NSNumber numberWithFloat:0];
    showSlowly.toValue = showFast.toValue = hideFast.fromValue = [NSNumber numberWithFloat:1];
    showSlowly.duration = 5;
    showFast.duration = hideFast.duration = 1;
    
    hideFast.removedOnCompletion = NO;
    hideFast.fillMode = kCAFillModeForwards;
    
    [nearBackgroundLayer addAnimation:showSlowly forKey:@"opacity"];
    [farBackgroundLayer addAnimation:showSlowly forKey:@"opacity"];
    
    [moonLayer addAnimation:showFast forKey:@"opacity"];
    [moonBGLayer addAnimation:showFast forKey:@"opacity"];
    [nextMoonLayer addAnimation:showFast forKey:@"opacity"];
    [nextMoonBGLayer addAnimation:showFast forKey:@"opacity"];
    
    [titleLabel addAnimation:hideFast forKey:@"opacity"];
}

- (void) animateBackground {
    // Zakręć tło
    CATransform3D transform = CATransform3DMakeRotation(1, 0, 0, 1.0);

    CABasicAnimation* animationNear = [CABasicAnimation animationWithKeyPath:@"transform"];
    CABasicAnimation* animationFar = [CABasicAnimation animationWithKeyPath:@"transform"];

    animationNear.toValue = animationFar.toValue = [NSValue valueWithCATransform3D:transform];
    animationNear.duration = 10;    // Efekt paralaksy uzyskany, dzięki różnej prędkości
    animationFar.duration = 20;     // kątowej obrotu jednego i drugiego tła.
    animationNear.cumulative = animationFar.cumulative = YES;
    animationNear.repeatCount = animationFar.repeatCount = 10000;
    
    [nearBackgroundLayer addAnimation:animationNear forKey:@"frame"];
    [farBackgroundLayer addAnimation:animationFar forKey:@"frame"];
}

@end