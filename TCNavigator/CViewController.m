//
//  CViewController.m
//  TCNavigator
//
//  Created by xbwu on 17/2/28.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "CViewController.h"
#import "TCNavigator.h"

@interface CViewController ()

@end

@implementation CViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor colorWithRed:1.0 green:192/255.0 blue:203/255.0 alpha:1];
  
  [self.actionBtn setTitle:@"present->DViewController" forState:UIControlStateNormal];

  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)responseToAction {
  [[TCNavigator navigator] openURLAction:[[TCURLAction actionWithURLPath:@"com.manga://vc-d"] applyAnimated:YES]];
}

@end
