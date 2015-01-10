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

-(void)moveViewWithGestureRecognizerLong:(UIPanGestureRecognizer *)panGestureRecognizer{
    
    CGPoint touchLocation = [panGestureRecognizer locationInView:self.view];
    
    self.lineLong.center = touchLocation;
//    if (panGestureRecognizer.state == UIGestureRecognizerStateChanged) {
//        self.lineLong.layer.anchorPoint = CGPointMake(0.5, 0);
//        
//        CGPoint location = [panGestureRecognizer locationInView:self.lineLong];
//        
//        float deltaX = location.x - centerX;
//        float deltaY = location.y - centerY;
//        
//        float angle = atan2f(deltaX, deltaY);
//        
//        [self.lineLong setTransform:CGAffineTransformMakeRotation(degree2Radians(angle) * -1)];
//    }
    
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
