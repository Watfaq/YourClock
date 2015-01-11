//
//  RootViewController.m
//  Your Clock
//
//  Created by Yuwei Ba on 1/9/15.
//  Copyright (c) 2015 ___WATFAQ___. All rights reserved.
//

#import <math.h>
#import "Alarm.h"
#import "RootViewController.h"
#import "RecordViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // slide down guesture register
    UISwipeGestureRecognizer *swipeDownGuesture;
    swipeDownGuesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDown)];
    swipeDownGuesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDownGuesture];
    
    // slide up guesture register
    UISwipeGestureRecognizer *swipUpGuesture;
    swipUpGuesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUp)];
    swipUpGuesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipUpGuesture];
    
    // hour hand guesture register
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGestureRecognizerLong:)];
    [self.lineLong addGestureRecognizer:panGestureRecognizer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setTime {
    self.textHour.text = [@(_hour) stringValue];
    self.textMinute.text = [@(_minute) stringValue];
}

- (void) handleSwipeDown
{

    _enabled = !_enabled;
    NSString *switchText = @"ALARM ";
    if (_enabled) {
        switchText = [switchText stringByAppendingString:@"ON"];
        [Alarm setUpAlarm:[NSDate date]];
    }
    else {
        switchText = [switchText stringByAppendingString:@"OFF"];
        [Alarm cancelAlarm];
    }
    self.switchLabel.text = switchText;
}

- (void) handleSwipeUp
{
    RecordViewController *record = [[RecordViewController alloc] init];
    [self presentViewController:record animated:YES completion:nil];
}

- (void) moveViewWithGestureRecognizerLong:(UIPanGestureRecognizer *)panGestureRecognizer
{
    if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        
        CGFloat centerX = self.clockBg.frame.size.width / 2 + 1;  // border width?
        CGFloat centerY = self.clockBg.frame.size.height / 2 - 1;
        
        CGPoint touchPoint = [panGestureRecognizer locationInView:self.clockBg];
        
        CGFloat deltaX = touchPoint.x - centerX;
        CGFloat deltaY = touchPoint.y - centerY;
        
        CGFloat angle = atan2f(deltaY, deltaX);
        
        [UIView beginAnimations:@"hourHand_rotate" context:nil];
        [UIView setAnimationDuration:0];
        
        [UIView setAnimationDelegate:self];
        [UIView setAnimationRepeatCount:1];
        
//        self.lineLong.layer.transform = CATransform3DMakeRotation(angle, 0, 0, 1);
        self.lineLong.transform = CGAffineTransformMakeRotation(angle);
        [UIView commitAnimations];
        
        if (angle < 0)
            angle = M_PI * 2 + angle;
        angle = radians2Degree(angle);
        _minute = angle / 360 * 60;
        _minute += 15;
        _minute = fmod(_minute, 60);
        [self setTime];
        
        NSLog(@"Touch point: (%f, %f)", touchPoint.x, touchPoint.y);
        NSLog(@"Center Point: (%f, %f)", centerY, centerY);
        NSLog(@"Position: (%f, %f)", deltaX, deltaY);
        NSLog(@"Minute position: (%f, %f)", self.lineLong.center.x, self.lineLong.center.y);
    }
    
}

float degree2Radians(float degrees) { return degrees * M_PI / 180; }
float radians2Degree(float radians) { return radians * 180 / M_PI; }

- (void) viewWillAppear:(BOOL)animated
{
    _hour = 10;
    _minute = 10;

    [self setUpClockLayout];
    [self setTime];
}

- (void) setUpClockLayout
{
    
    CALayer *containLayer = self.containLayer.layer;
    CGPoint center = CGPointMake(containLayer.frame.size.width / 2, containLayer.frame.size.height / 2);
    CGRect lineLongFrame = CGRectMake(center.x, center.y, self.lineLong.frame.size.width, self.lineLong.frame.size.height);
    self.lineLong.frame = lineLongFrame;
    self.lineLong.center = CGPointMake(0, 0);
    self.lineLong.layer.anchorPoint = CGPointMake(0, 1);
}

@end
