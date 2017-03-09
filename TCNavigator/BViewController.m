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

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"To:Tab4" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(self.view.frame.size.width/2 - 100, 300, 200, 100);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
  
  self.view.backgroundColor = [UIColor brownColor];
  [self.actionBtn setTitle:@"present->DViewController" forState:UIControlStateNormal];
}

- (void)show {
  NSLog(@"%@", self.parentViewController);
  NSLog(@"%@", self.parentViewController.parentViewController);
//  [[TCNavigator navigator] openURLAction:[[TCURLAction actionWithURLPath:@"com.manga://vc-f"] applyAnimated:YES]];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)responseToAction {
  [[TCNavigator navigator] openURLAction:[[TCURLAction actionWithURLPath:@"com.manga://vc-c"] applyAnimated:YES]];
}


@end
