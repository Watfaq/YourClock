//
//  Alarm.h
//  Your Clock
//
//  Created by Yuwei Ba on 1/11/15.
//  Copyright (c) 2015 ___WATFAQ___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Alarm : NSObject

+ (void) setUpAlarm: (NSDate *) date;
+ (void) cancelAlarm;

@end
