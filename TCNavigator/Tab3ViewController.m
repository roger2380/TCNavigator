//
//  Tab3ViewController.m
//  TCNavigator
//
//  Created by xbwu on 17/2/28.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "Tab3ViewController.h"
#import "TCNavigator.h"

@interface Tab3ViewController ()

@end

@implementation Tab3ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tcTitle = @"tab3";
  self.view.backgroundColor = [UIColor blueColor];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)responseToAction {
  [[TCNavigator navigator] openURLAction:[TCURLAction actionWithURLPath:@""]];
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
