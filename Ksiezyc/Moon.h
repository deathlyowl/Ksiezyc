//
//  Moon.h
//  Moon
//
//  Created by Małgorzata Bogdańska on 16.05.2013.
//  Copyright (c) 2013 Małgorzata Bogdańska. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MOON_PHASE_NEW 0
#define MOON_PHASE_FIRST 1
#define MOON_PHASE_GROWING 2
#define MOON_PHASE_FULL 3
#define MOON_PHASE_WITCHERING 4
#define MOON_PHASE_THIRD 5

@interface Moon : NSObject
- (short) phase;
- (NSString*) phaseString;
- (float) percent;

@property (nonatomic, retain) NSDate *date;
@end
