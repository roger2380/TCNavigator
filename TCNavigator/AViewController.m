//
//  AViewController.m
//  TCNavigator
//
//  Created by xbwu on 17/2/28.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "AViewController.h"
#import "TCNavigator.h"

@interface AViewController ()

@end

@implementation AViewController

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tcTitle = @"AViewController";
  self.view.backgroundColor = [UIColor lightGrayColor];
  
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.view addSubview:btn];
  btn.frame = CGRectMake(100, 300, 100, 100);
  btn.backgroundColor = [UIColor blueColor];
  [btn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
}

- (void)responseToAction {
  [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)tap {
  [[TCNavigator navigator] openURLAction:[[TCURLAction actionWithURLPath:@"com.manga://vc-c"] applyAnimated:YES]];
}

@end
