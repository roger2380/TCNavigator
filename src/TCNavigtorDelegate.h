//
//  TCNavigtorDelegate.h
//  TCNavigator
//
//  Created by xbwu on 17/2/14.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#ifndef TCNavigtorDelegate_h
#define TCNavigtorDelegate_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TCNavigator;

@protocol TCNavigtorDelegate <NSObject>
@optional

//是否可以打开此URL
- (BOOL)navigator:(TCNavigator*)navigator shouldOpenURL:(NSURL*)URL;


- (NSURL*)navigator:(TCNavigator*)navigator URLToOpen:(NSURL*)URL;


//navigator即将打开此URL
- (void)navigator:(TCNavigator*)navigator willOpenURL:(NSURL*)URL
 inViewController:(UIViewController*)controller;

@end

#endif /* TCNavigtorDelegate_h */
