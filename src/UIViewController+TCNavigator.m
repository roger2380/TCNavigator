//
//  UIViewController+TCNavigator.m
//  TCNavigator
//
//  Created by xbwu on 17/2/24.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "UIViewController+TCNavigator.h"

@implementation UIViewController (TCNavigator)


- (BOOL)canContainControllers {
  return NO;
}


- (UIViewController*)topSubcontroller {
  return nil;
}


//当前controller的containing controller，比如navgation controller或者 tabbar controller
- (UIViewController*)superController {
  //TODO这里可能要改下
  UIViewController *parent = self.parentViewController;
  if (nil != parent) {
    return parent;
    
  }
  return nil;
//  else {
//    NSString *key = [NSString stringWithFormat:@"%d", self.hash];
//    return [gSuperControllers objectForKey:key];
//  }
}


- (void)bringControllerToFront:(UIViewController*)controller animated:(BOOL)animated {
  
}


- (void)addSubcontroller:(UIViewController*)controller animated:(BOOL)animated {
  if (self.navigationController) {
    [self.navigationController addSubcontroller:controller animated:animated];
  }
}


@end
