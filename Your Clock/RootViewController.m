//
//  RootViewController.m
//  Your Clock
//
//  Created by Yuwei Ba on 1/9/15.
//  Copyright (c) 2015 ___WATFAQ___. All rights reserved.
//

#import <math.h>
#import "RootViewController.h"

#define centerX 160
#define centerY 264

@interface RootViewController () {
    CGPoint prevPoint;
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    prevPoint = CGPointMake(-1, -1);
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
    if (prevPoint.x == -1) {
        prevPoint = [panGestureRecognizer locationInView:self.view];
    }
    if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
        if (prevPoint.x == -1) // no prev point, do nothing
            return;
        
        self.lineLong.layer.anchorPoint = CGPointMake(0, 1);
        
        CGPoint centerPoint = CGPointMake(centerX, centerY);
        CGPoint touchPoint = [panGestureRecognizer locationInView:self.view];
        CGFloat angle = angleBetweenLinesInDegrees(centerPoint, prevPoint, centerPoint, touchPoint);
        
        self.lineLong.layer.transform = CATransform3DMakeRotation(angle, 0, 0, 1);
    }
    
}

float degree2Radians(float degrees) { return degrees * M_PI / 180; }

CGFloat angleBetweenLinesInDegrees(CGPoint beginLineA,
                                   CGPoint endLineA,
                                   CGPoint beginLineB,
                                   CGPoint endLineB)
{
    CGFloat a = endLineA.x - beginLineA.x;
    CGFloat b = endLineA.y - beginLineA.y;
    CGFloat c = endLineB.x - beginLineB.x;
    CGFloat d = endLineB.y - beginLineB.y;
    
    CGFloat atanA = atan2(a, b);
    CGFloat atanB = atan2(c, d);
    
    // convert radiants to degrees
    return (atanA - atanB) * 180 / M_PI;
}

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
