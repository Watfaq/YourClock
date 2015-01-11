//
//  RecordViewController.m
//  Your Clock
//
//  Created by Yuwei Ba on 1/11/15.
//  Copyright (c) 2015 ___WATFAQ___. All rights reserved.
//

#import "RecordViewController.h"
#import "RootViewController.h"

@interface RecordViewController ()

@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.recordDone setAction:@selector(backToMain)];
}
     
- (void) backToMain
{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame =  CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        [self.view setAlpha:0.0f];
    } completion:^(BOOL finished) {
        [self.view setHidden:YES];
    }];
    RootViewController *root = [[RootViewController alloc] init];
    [self presentViewController:root animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
