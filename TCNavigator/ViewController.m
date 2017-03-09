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
  
  self.view.backgroundColor = [UIColor lightGrayColor];
  
//  UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//  [btn setTitle:@"To:Tab4" forState:UIControlStateNormal];
//  [self.view addSubview:btn];
//  btn.frame = CGRectMake(self.view.frame.size.width/2 - 100, 300, 200, 100);
//  btn.backgroundColor = [UIColor redColor];
//  [btn addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)responseToAction {
   [[TCNavigator navigator] openURLAction:[[TCURLAction actionWithURLPath:@"com.manga://vc-b"] applyAnimated:YES]];
}

- (void)show {
  [[TCNavigator navigator] openURLAction:[[TCURLAction actionWithURLPath:@"com.manga://vc-b"] applyAnimated:YES]];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
