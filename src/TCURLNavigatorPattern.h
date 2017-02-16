//
//  TCURLNavigatorPattern.h
//  TCNavigator
//
//  Created by xbwu on 17/2/14.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCNavigationMode.h"
#import "TCURLPattern.h"

@interface TCURLNavigatorPattern : TCURLPattern

@property (nonatomic, weak)      Class             targetClass;
@property (nonatomic, weak)      id                targetObject;
@property (nonatomic, readonly)  TCNavigationMode  navigationMode;
@property (nonatomic, copy)      NSString          *parentURL;

- (id)initWithTarget:(id)target;
- (id)initWithTarget:(id)target mode:(TCNavigationMode)navigationMode;

- (void)compile;

- (BOOL)matchURL:(NSURL*)URL;

- (id)createObjectFromURL:(NSURL*)URL;

@end
