//
//  RootViewController.h
//  Your Clock
//
//  Created by Yuwei Ba on 1/9/15.
//  Copyright (c) 2015 ___WATFAQ___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController {
    NSInteger _hour;
    NSInteger _minute;
    NSInteger _enabled;
}

@property (weak, nonatomic) IBOutlet UILabel *switchLabel;

@property (weak, nonatomic) IBOutlet UIView *containLayer;

@property (weak, nonatomic) IBOutlet UIImageView *clockBg;

@property (weak, nonatomic) IBOutlet UIImageView *lineShort;

@property (weak, nonatomic) IBOutlet UIImageView *lineLong;

@property (weak, nonatomic) IBOutlet UILabel *textHour;

@property (weak, nonatomic) IBOutlet UILabel *textMinute;

-(void)moveViewWithGestureRecognizerLong:(UIPanGestureRecognizer *)panGestureRecognizer;

//-(void)moveViewWithGestureRecognizerShort:(UIPanGestureRecognizer *)panGestureRecognizer;

@end
