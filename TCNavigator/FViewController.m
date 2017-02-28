//
//  FViewController.m
//  TCNavigator
//
//  Created by xbwu on 17/2/28.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "FViewController.h"
#import "TCNavigator.h"

@interface FViewController ()

@end

@implementation FViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


- (void)responseToAction {
  [[TCNavigator navigator] openURLAction:[[TCURLAction actionWithURLPath:@"com.manga://tab3"] applyAnimated:YES]];
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
