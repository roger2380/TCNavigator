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

  self.view.backgroundColor = [UIColor purpleColor];
  
  [self.actionBtn setTitle:@"ToShare->CViewController" forState:UIControlStateNormal];

  
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
  [btn setTitle:@"dissmiss" forState:UIControlStateNormal];
  [self.view addSubview:btn];
  btn.frame = CGRectMake(100, 300, 100, 100);
  btn.backgroundColor = [UIColor blueColor];
  [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
  // Do any additional setup after loading the view.
}

- (void)back {
  NSLog(@"%@", self.parentViewController.parentViewController);
  NSLog(@"%@",self.presentingViewController);
//  [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)responseToAction {
  [[TCNavigator navigator] openURLAction:[[TCURLAction actionWithURLPath:@"com.manga://tab4"] applyAnimated:YES]];
}

@end
