//
//  UITabBarController+TCNavigator.m
//  TCNavigator
//
//  Created by xbwu on 17/2/24.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "UITabBarController+TCNavigator.h"

@implementation UITabBarController (TCNavigator)


- (BOOL)canContainControllers {
  return YES;
}


- (UIViewController*)topSubcontroller {
  return self.selectedViewController;
}


- (void)bringControllerToFront:(UIViewController*)controller animated:(BOOL)animated {
  self.selectedViewController = controller;
}


- (void)addSubcontroller:(UIViewController*)controller animated:(BOOL)animated {
  self.selectedViewController = controller;
}


@end
