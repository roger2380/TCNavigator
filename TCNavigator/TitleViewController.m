//
//  TitleViewController.m
//  TCNavigator
//
//  Created by xbwu on 17/2/28.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "TitleViewController.h"

@interface TitleViewController ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TitleViewController

- (void)dealloc {
  NSLog(@"%@释放了", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.tcTitle = NSStringFromClass([self class]);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (UIButton *)actionBtn {
  if (_actionBtn == nil) {
    _actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_actionBtn];
    _actionBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    _actionBtn.backgroundColor = [UIColor orangeColor];
    [_actionBtn addTarget:self action:@selector(responseToAction) forControlEvents:UIControlEventTouchUpInside];
  }
  return _actionBtn;
}

- (UILabel *)titleLabel {
  if (_titleLabel == nil) {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.numberOfLines = 0;
    _titleLabel.textAlignment = 1;
    [self.view addSubview:_titleLabel];
    _titleLabel.textColor = [UIColor redColor];
  }
  return _titleLabel;
}

- (void)setTcTitle:(NSString *)tcTitle {
  self.titleLabel.text = tcTitle;
}

- (void)responseToAction {
  
}

- (void)viewDidLayoutSubviews {
  self.titleLabel.frame = CGRectMake(self.view.frame.size.width/2.0 - 200/2.0, 60, 200, 50);
  self.actionBtn.frame = CGRectMake(self.view.frame.size.width/2.0 - 200/2.0, 150, 200, 100);
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
