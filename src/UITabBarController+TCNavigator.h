//
//  UITabBarController+TCNavigator.h
//  TCNavigator
//
//  Created by xbwu on 17/2/24.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarController (TCNavigator)

- (BOOL)canContainControllers;

- (UIViewController*)topSubcontroller;

- (void)bringControllerToFront:(UIViewController*)controller animated:(BOOL)animated;

- (void)addSubcontroller:(UIViewController*)controller animated:(BOOL)animated;

@end
