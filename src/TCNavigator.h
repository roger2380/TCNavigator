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
  UIWindow         *_window;
}

@property (nonatomic, readonly) TCURLMap                *URLMap;
@property (nonatomic, weak)     id<TCNavigtorDelegate>   delegate;

+ (TCNavigator*)navigator;

- (UIViewController*)openURLAction:(TCURLAction*)URLAction;

@end
