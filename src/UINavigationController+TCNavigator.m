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


@end
