//
//  Alarm.m
//  Your Clock
//
//  Created by Yuwei Ba on 1/11/15.
//  Copyright (c) 2015 ___WATFAQ___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Alarm.h"

#define ALART_BODY @"ALART_BODY"

@implementation Alarm

+ (void) setUpAlarm:(NSDate *)date
{
    UILocalNotification *notify = [[UILocalNotification alloc] init];
    notify.fireDate = date;
    notify.timeZone = [NSTimeZone localTimeZone];
    notify.alertAction = @"A";
    notify.alertBody = ALART_BODY;

    notify.soundName = UILocalNotificationDefaultSoundName;
    notify.applicationIconBadgeNumber = 0;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:notify];
    NSLog(@"Alarm enabled");
}

+ (void) cancelAlarm
{
    NSArray *notifys = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
    for (UILocalNotification *notify in notifys) {
        if ([notify.alertBody isEqualToString:ALART_BODY]) {
            [[UIApplication sharedApplication] cancelLocalNotification:notify];
        }
    }
    NSLog(@"Alarm canceled");
}

@end