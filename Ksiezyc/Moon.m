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
    
    dayAndMonth = remainder + day + month + .5*(hour>12);
    if (year>2000) dayAndMonth -= 8;
}

- (short) phase {
    if (dayAndMonth==0)return MOON_PHASE_NEW;
    if (dayAndMonth==7.5) return MOON_PHASE_FIRST;
    if (dayAndMonth==15) return MOON_PHASE_FULL;
    if (dayAndMonth==22.5) return MOON_PHASE_THIRD;
    if (dayAndMonth<15 && dayAndMonth>0) return MOON_PHASE_GROWING;
    return MOON_PHASE_WITCHERING;
}

+ (float) percentWithPhase:(short)phase {
    return dayAndMonth/30;
}

+ (NSString*) phaseStringWithPhase:(short) phase {
    switch (phase) {
        case MOON_PHASE_FIRST: return @"Faza Pierwsza";
        case MOON_PHASE_NEW: return @"Nów";
        case MOON_PHASE_THIRD: return @"Faza Trzecia";
        case MOON_PHASE_FULL: return @"Pełnia";
        case MOON_PHASE_GROWING: return @"Księżyc rośnie";
        case MOON_PHASE_WITCHERING: return @"Księżyc maleje";
    }
    return nil;
}

@end