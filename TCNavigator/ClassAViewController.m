//
//  ClassAViewController.m
//  TCNavigator
//
//  Created by xbwu on 17/2/27.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "ClassAViewController.h"

@interface ClassAViewController ()

@end

@implementation ClassAViewController

- (void)dealloc {
  NSLog(@"释放了");
}

- (instancetype)initWithText:(NSString *)text {
  self = [super init];
  if (self) {
    NSLog(@"%@", text);
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.navigationController.navigationBarHidden = NO;
  
  self.view.backgroundColor = [UIColor blueColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
