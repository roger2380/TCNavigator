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

  self.view.backgroundColor = [UIColor brownColor];
  [self.actionBtn setTitle:@"present->DViewController" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)responseToAction {
  [[TCNavigator navigator] openURLAction:[[TCURLAction actionWithURLPath:@"com.manga://vc-e"] applyAnimated:YES]];
}


@end
