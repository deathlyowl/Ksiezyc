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
        day = 3;
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

#pragma mark -
#pragma mark Lifecycle
- (void) viewDidAppear:(BOOL)animated {
    [moonView showMoon];
    [moonView animateBackground];
}

- (void) reloadInputViews {
    [self setLabel];
    [moonView animateMoonToPercentage:[Moon percentageWithProgress:moon.progress]];
    [moonView animateNextMoonToPercentage:[Moon percentageWithProgress:moon.nextProgress]];
}

- (void) becomeActive {
    moon = [Moon moonWithDate:[NSDate dateWithTimeIntervalSinceNow:day*24*60*60]];
    [self reloadInputViews];
    [moonView animateBackground];
}

#pragma mark -
#pragma mark Helpers
- (void) setLabel {
    float interval = moon.nextProgress - moon.progress;
    if (interval < 0) interval += 30;
    
    // W punkt
    if (interval == 0) [moonView setNextMoonText:[Moon phaseStringWithPhase:[Moon phaseWithProgress:moon.nextProgress]]];
    
    // Godziny
    else if (interval < 1){
        int hours = interval * 24;
        [moonView setNextMoonText:
         [NSString stringWithFormat:NSLocalizedString(@"Hours", @""),
          [Moon phaseStringWithPhase:[Moon phaseWithProgress:moon.nextProgress]],
          hours]];
    }
    // Dni
    else {
        if (interval < 2) {
            [moonView setNextMoonText:
             [NSString stringWithFormat:NSLocalizedString(@"OneDay", @""),
              [Moon phaseStringWithPhase:[Moon phaseWithProgress:moon.nextProgress]],
              interval]];
        }
        else {
            [moonView setNextMoonText:
             [NSString stringWithFormat:NSLocalizedString(@"MoreThanOneDay", @""),
              [Moon phaseStringWithPhase:[Moon phaseWithProgress:moon.nextProgress]],
              interval]];
        }
    }
}

#pragma mark -
#pragma mark Actions
- (void) horizontalSwipe:(UISwipeGestureRecognizer *) sender {
    
    day += 1./24. * (UISwipeGestureRecognizerDirectionLeft == sender.direction) +
          -1./24. * (UISwipeGestureRecognizerDirectionRight == sender.direction);
    moon = [Moon moonWithDate:[NSDate dateWithTimeIntervalSinceNow:day*24*60*60]];
    [self reloadInputViews];
}

@end