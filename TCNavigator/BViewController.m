//
//  BViewController.m
//  TCNavigator
//
//  Created by xbwu on 17/2/28.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "BViewController.h"
#import "TCNavigator.h"

@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tcTitle = @"BViewController";
  self.view.backgroundColor = [UIColor brownColor];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)responseToAction {
  [[TCNavigator navigator] openURLAction:[[TCURLAction actionWithURLPath:@"com.manga://vc-d"] applyAnimated:YES]];
}


@end
