//
//  RootViewController.m
//  Your Clock
//
//  Created by Yuwei Ba on 1/9/15.
//  Copyright (c) 2015 ___WATFAQ___. All rights reserved.
//

#import <math.h>
#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

-(void) moveViewWithGestureRecognizerLong:(UIPanGestureRecognizer *)panGestureRecognizer
{
    if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        self.lineLong.layer.anchorPoint = CGPointMake(0, 1);
        
        CGFloat centerX = self.clockBg.frame.size.width / 2;
        CGFloat centerY = self.clockBg.frame.size.height / 2;
        
        CGPoint touchPoint = [panGestureRecognizer locationInView:self.clockBg];
        
        CGFloat deltaX = touchPoint.x - centerX;
        CGFloat deltaY = touchPoint.y - centerY;
        
        CGFloat angle = atan2f(deltaY, deltaX);
        
        [UIView beginAnimations:@"hourHand_rotate" context:nil];
        [UIView setAnimationDuration:2];
        
        [UIView setAnimationDelegate:self];
        [UIView setAnimationRepeatCount:1];
        
        self.lineLong.layer.transform = CATransform3DMakeRotation(angle, 0, 0, 1);
        [UIView commitAnimations];
        
        _hour = fmodf(angle / M_2_PI * 24, 24);
        [self setTime];
        
        NSLog(@"Touch point: (%f, %f)", touchPoint.x, touchPoint.y);
        NSLog(@"Center Point: (%f, %f)", centerY, centerY);
        NSLog(@"Position: (%f, %f)", deltaX, deltaY);
        NSLog(@"Minute position: (%f, %f)", self.lineLong.center.x, self.lineLong.center.y);
    }
    
}

float degree2Radians(float degrees) { return degrees * M_PI / 180; }

- (void) viewWillAppear:(BOOL)animated
{
    _hour = 10;
    _minute = 10;

    [self setTime];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
