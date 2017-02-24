//
//  UIViewController+TCNavigator.h
//  TCNavigator
//
//  Created by xbwu on 17/2/24.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TCNavigator)

- (BOOL)canContainControllers;

- (UIViewController*)topSubcontroller;

@end
