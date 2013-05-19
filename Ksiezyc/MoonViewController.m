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
                                             selector:@selector(backToBlack)
                                                 name:@"Active"
                                            object:nil];
    
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(horizontalSwipe:)];
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(horizontalSwipe:)];
    
    [leftSwipe setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [rightSwipe setDirection:(UISwipeGestureRecognizerDirectionRight)];
    
    [moonView addGestureRecognizer:leftSwipe];
    [moonView addGestureRecognizer:rightSwipe];
    
    moon = [Moon moonWithDate:[NSDate dateWithTimeIntervalSinceNow:0]];
    
    [self reloadInputViews];
    
    return self;
}

- (void) reloadInputViews{
    [self setLabel];
    [moonView animateMoonToPercentage:[Moon percentageWithProgress:moon.progress]];
    [moonView animateNextMoonToPercentage:[Moon percentageWithProgress:moon.nextProgress]];
}

- (void) setLabel{
    int interval = (int)(moon.nextProgress-moon.progress);
    if (interval)
        [moonView setNextMoonText:
         [NSString stringWithFormat:@"%@ za %i dni",
          [Moon phaseStringWithPhase:[Moon phaseWithProgress:moon.nextProgress]],
          interval]];
    else [moonView setNextMoonText:[Moon phaseStringWithPhase:[Moon phaseWithProgress:moon.nextProgress]]];
}

-(void)viewDidAppear:(BOOL)animated{
    [moonView showMoon];
    [moonView animateBackground];
}

- (void) backToBlack{
    moon = [Moon moonWithDate:[NSDate date]];
    [self reloadInputViews];
}

- (void) tick {
    moon = [Moon moonWithDate:[NSDate dateWithTimeIntervalSinceNow:day++*24*60*60]];
    [moonView animateMoonToPercentage:[Moon percentageWithProgress:moon.progress]];
    [moonView animateNextMoonToPercentage:[Moon percentageWithProgress:moon.nextProgress]];
    [self setLabel];
}

- (void) horizontalSwipe:(UISwipeGestureRecognizer *) sender
{
    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            day++;
            break;
        case UISwipeGestureRecognizerDirectionRight:
            day--;
            break;
        default:
            break;
    }
    moon = [Moon moonWithDate:[NSDate dateWithTimeIntervalSinceNow:day*24*60*60]];
    [self reloadInputViews];
}

@end