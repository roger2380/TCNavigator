//
//  ViewController.m
//  TCNavigator
//
//  Created by xbwu on 17/2/14.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "ViewController.h"
#import "TCNavigator.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor greenColor];
  
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.view addSubview:btn];
  btn.frame = CGRectMake(0, 0, 100, 100);
  btn.backgroundColor = [UIColor redColor];
  [btn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)show {
  [[TCNavigator navigator] openURLAction:[[TCURLAction actionWithURLPath:@"com.manga://hello"] applyAnimated:YES]];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
