//
//  UINavigationController+TCNavigator.m
//  TCNavigator
//
//  Created by xbwu on 17/2/24.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "UINavigationController+TCNavigator.h"

@implementation UINavigationController (TCNavigator)


- (BOOL)canContainControllers {
  return YES;
}


- (UIViewController*)topSubcontroller {
  return self.topViewController;
}


- (void)bringControllerToFront:(UIViewController*)controller animated:(BOOL)animated {
  if ([self.viewControllers indexOfObject:controller] != NSNotFound
      && controller != self.topViewController) {
    [self popToViewController:controller animated:animated];
  }
}


- (void)addSubcontroller:(UIViewController*)controller animated:(BOOL)animated {
  [self pushViewController:controller animated:animated];
}


@end
