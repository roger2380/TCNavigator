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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.hidesBottomBarWhenPushed = YES;
  }
  return self;
}


- (void)dealloc {
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.tcTitle = @"ViewController";
  
  self.view.backgroundColor = [UIColor lightGrayColor];
  
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
  [self.view addSubview:btn];
  btn.frame = CGRectMake(100, 100, 100, 100);
  btn.backgroundColor = [UIColor redColor];
  [btn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)show {
  [[TCNavigator navigator] openURLAction:[[TCURLAction actionWithURLPath:@"com.manga://tab4"] applyAnimated:YES]];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
