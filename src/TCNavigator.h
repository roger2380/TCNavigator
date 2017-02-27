//
//  TCNavigator.h
//  TCNavigator
//
//  Created by xbwu on 17/2/14.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCURLMap.h"
#import "TCURLAction.h"
#import <UIKit/UIKit.h>

@protocol TCNavigtorDelegate;

@interface TCNavigator : NSObject {
  UIViewController *_rootViewController;
}

@property (nonatomic, readonly) TCURLMap                *URLMap;
@property (nonatomic, weak)     id<TCNavigtorDelegate>  delegate;
@property (nonatomic, strong) UIWindow                  *window;

+ (TCNavigator*)navigator;

- (UIViewController*)openURLAction:(TCURLAction*)URLAction;

@end
