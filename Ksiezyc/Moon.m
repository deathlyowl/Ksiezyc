//
//  Moon.m
//  Moon
//
//  Created by Małgorzata Bogdańska on 16.05.2013.
//  Copyright (c) 2013 Małgorzata Bogdańska. All rights reserved.
//

#import "Moon.h"

@implementation Moon

- (id) initWithDate:(NSDate*) _date {
    self=[super init];
    if (self) {
        self->date = _date;
        [self calculate];
    }
    return self;
}

+ (Moon *)moonWithDate:(NSDate *)date {
    Moon *moon=[[Moon alloc] initWithDate:date];
    return moon;
}

- (void) calculate {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit
                                                                   fromDate:date];
    long int year = components.year;
    long int month = components.month;
    long int day = components.day;
    long int hour = components.hour;
    
    int remainder = (year%100)%19;
    if (remainder>9) remainder -= 19;
    
    remainder *= 11;
    remainder %= 30;
    
    progress = remainder + day + month + ((float)hour / 24);
    NSLog(@"Progress: %.2f", progress);
    
    if (year>2000) progress -= 8;
    if (progress<0) progress += 30;
}

- (float) nextProgress {
    if (!fmod(progress, 7.5)) return fmod(progress,30);
    
    int tmp = progress/7.5;
    tmp ++;
    float nextProgress = tmp*7.5;
    return fmod(nextProgress,30);
}

- (float) progress {
    return progress;
}

+ (short) phaseWithProgress:(float) progress {
    if (progress==0)return MOON_PHASE_NEW;
    if (progress==7.5) return MOON_PHASE_FIRST;
    if (progress==15) return MOON_PHASE_FULL;
    if (progress==22.5) return MOON_PHASE_THIRD;
    if (progress<15 && progress>0) return MOON_PHASE_GROWING;
    return MOON_PHASE_WITCHERING;
}

+ (float) percentageWithProgress:(float)progress{
    return progress/30;
}

+ (NSString*) phaseStringWithPhase:(short) phase {
    switch (phase) {
        case MOON_PHASE_FIRST: return NSLocalizedString(@"FirstQuarter", @"");
        case MOON_PHASE_NEW: return NSLocalizedString(@"NewMoon", @"");
        case MOON_PHASE_THIRD: return NSLocalizedString(@"ThirdQuarter", @"");
        case MOON_PHASE_FULL: return NSLocalizedString(@"FullMoon", @"");
        case MOON_PHASE_GROWING: return @"księżyc rośnie";
        case MOON_PHASE_WITCHERING: return @"księżyc maleje";
    }
    return nil;
}

@end