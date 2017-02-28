//
//  DViewController.m
//  TCNavigator
//
//  Created by xbwu on 17/2/28.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "DViewController.h"
#import "TCNavigator.h"

@interface DViewController ()

@end

@implementation DViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tcTitle = @"DViewController";
  self.view.backgroundColor = [UIColor purpleColor];
  
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.view addSubview:btn];
  btn.frame = CGRectMake(100, 300, 100, 100);
  btn.backgroundColor = [UIColor blueColor];
  [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
  // Do any additional setup after loading the view.
}

- (void)back {
  [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)responseToAction {
  [[TCNavigator navigator] openURLAction:[[TCURLAction actionWithURLPath:@"com.manga://vc-c"] applyAnimated:YES]];
}

@end
