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
        days = 0;
        moonView = [[MoonView alloc] init];
        moon = [Moon moonWithDate:[NSDate dateWithTimeIntervalSinceNow:0]];
        self.view = moonView;
    }
    [self setLabel];
    [moonView animateMoonToPercentage:[Moon percentageWithProgress:moon.progress]];
    [moonView animateNextMoonToPercentage:[Moon percentageWithProgress:moon.nextProgress]];


    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(backToBlack)
                                                 name:@"Active"
                                               object:nil];
    return self;
}

- (void) setLabel{
    int interval = (int)(moon.nextProgress-moon.progress);
    
    if (interval) {
        [moonView setNextMoonText:[NSString stringWithFormat:@"%@ za %i dni",
                                   [Moon phaseStringWithPhase:[Moon phaseWithProgress:moon.nextProgress]],
                                   (int)(moon.nextProgress-moon.progress)]];
    }
    else{
        [moonView setNextMoonText:[Moon phaseStringWithPhase:[Moon phaseWithProgress:moon.nextProgress]]];
    }
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [moonView showMoon];
    [moonView animateBackground];
    /*
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(tick)
                                   userInfo:nil
                                    repeats:YES];
     */
     
}

- (void) tick{
    moon = [Moon moonWithDate:[NSDate dateWithTimeIntervalSinceNow:24*60*60*++days*.5]];
    [moonView animateMoonToPercentage:[Moon percentageWithProgress:moon.progress]];
    [moonView animateNextMoonToPercentage:[Moon percentageWithProgress:moon.nextProgress]];
    [self setLabel];
}

- (void) backToBlack{
    [self tick];
    [moonView animateBackground];
}

@end