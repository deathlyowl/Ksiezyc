//
//  MoonViewController.m
//  Ksiezyc
//
//  Created by Paweł Ksieniewicz on 16.05.2013.
//  Copyright (c) 2013 Paweł Ksieniewicz. All rights reserved.
//

#import "MoonViewController.h"

@implementation MoonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        day = 0;
        moonView = [[MoonView alloc] init];
        self.view = moonView;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(becomeActive)
                                                 name:BECOME_ACTIVE_NOTIFICATION_NAME
                                            object:nil];
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(horizontalSwipe:)];
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(horizontalSwipe:)];
    
    [leftSwipe setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [rightSwipe setDirection:(UISwipeGestureRecognizerDirectionRight)];
    
    [moonView addGestureRecognizer:leftSwipe];
    [moonView addGestureRecognizer:rightSwipe];
    
    return self;
}

- (void) reloadInputViews {
    [self setLabel];
    [moonView animateMoonToPercentage:[Moon percentageWithProgress:moon.progress]];
    [moonView animateNextMoonToPercentage:[Moon percentageWithProgress:moon.nextProgress]];
}

- (void) setLabel {
    float interval = moon.nextProgress - moon.progress;
    if (interval < 0) interval += 30;
    if (interval)
        [moonView setNextMoonText:
         [NSString stringWithFormat:@"%@ za %.0f dni",
          [Moon phaseStringWithPhase:[Moon phaseWithProgress:moon.nextProgress]],
          interval]];
    else [moonView setNextMoonText:[Moon phaseStringWithPhase:[Moon phaseWithProgress:moon.nextProgress]]];
}

-(void)viewDidAppear:(BOOL)animated {
    [moonView showMoon];
    [moonView animateBackground];
}

- (void) becomeActive {
    moon = [Moon moonWithDate:[NSDate dateWithTimeIntervalSinceNow:day*24*60*60]];
    [self reloadInputViews];
    [moonView animateBackground];
}

- (void) horizontalSwipe:(UISwipeGestureRecognizer *) sender {
    day += .5 * (UISwipeGestureRecognizerDirectionLeft == sender.direction) +
          -.5 * (UISwipeGestureRecognizerDirectionRight == sender.direction);
    moon = [Moon moonWithDate:[NSDate dateWithTimeIntervalSinceNow:day*24*60*60]];
    [self reloadInputViews];
}

@end