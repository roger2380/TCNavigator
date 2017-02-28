//
//  Tab4ViewController.m
//  TCNavigator
//
//  Created by xbwu on 17/2/28.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "Tab4ViewController.h"
#import "TCNavigator.h"

@interface Tab4ViewController ()

@end

@implementation Tab4ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tcTitle = @"tab4";
  self.view.backgroundColor = [UIColor purpleColor];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (void)responseToAction {
  [[TCNavigator navigator] openURLAction:[[TCURLAction actionWithURLPath:@"com.manga://vc-a"] applyAnimated:YES]];
}

@end
