//
//  TCNavigator.m
//  TCNavigator
//
//  Created by xbwu on 17/2/14.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "TCNavigator.h"
#import "TCNavigtorDelegate.h"
#import "TCURLNavigatorPattern.h"

#import "UIViewController+TCNavigator.h"
#import "UINavigationController+TCNavigator.h"
#import "UITabBarController+TCNavigator.h"

static TCNavigator *gNavigator = nil;


@implementation TCNavigator


- (id)init {
  self = [super init];
  if (self) {
    _URLMap = [[TCURLMap alloc] init];
  }
  return self;
}


+ (TCNavigator*)globalNavigator {
  return gNavigator;
}


- (UIViewController*)openURLAction:(TCURLAction*)action {
  if (nil == action || nil == action.urlPath) {
    return nil;
  }
  
  NSString *urlPath = action.urlPath;
  NSURL *theURL = [NSURL URLWithString:urlPath];
  
  //是否允许打开此URL
  if ([_delegate respondsToSelector:@selector(navigator:shouldOpenURL:)]) {
    if (![_delegate navigator:self shouldOpenURL:theURL]) {
      return nil;
    }
  }
  
  //是否允许修改此URL
  if ([_delegate respondsToSelector:@selector(navigator:URLToOpen:)]) {
    NSURL *newURL = [_delegate navigator:self URLToOpen:theURL];
    if (!newURL) {
      return nil;
      
    } else {
      theURL = newURL;
      urlPath = newURL.absoluteString;
    }
  }

  TCURLNavigatorPattern *pattern = nil;
  UIViewController *controller = [self viewControllerForURL:urlPath
                                                    pattern:&pattern];
  BOOL wasNew = [self presentController:controller
                          parentURLPath:action.parentURLPath
                            withPattern:pattern
                                 action:action];

  //TODO跳转
  return controller;
}


- (UIViewController*)viewControllerForURL:(NSString*)URL
                                  pattern:(TCURLNavigatorPattern**)pattern {
  
  id object = [_URLMap objectForURL:URL pattern:pattern];
  if (object) {
    UIViewController *controller = object;
    return controller;
  } else {
    return nil;
  }
}


- (BOOL)presentController: (UIViewController*)controller
            parentURLPath: (NSString*)parentURLPath
              withPattern: (TCURLNavigatorPattern*)pattern
                   action: (TCURLAction*)action {
  BOOL didPresentNewController = NO;
  
  if (nil != controller) {
    UIViewController *topViewController = self.topViewController;
    
    if (controller != topViewController) {
      UIViewController *parentController = [self parentForController:controller
                                                         isContainer:[controller
                                                                      canContainControllers]
                                                       parentURLPath:parentURLPath
                                                                      ? parentURLPath
                                                                      : pattern.parentURL];
      
      if (nil != parentController && parentController != topViewController) {
        [self presentController:parentController
               parentController:nil
                           mode:TTNavigationModeNone
                         action:[TTURLAction actionWithURLPath:nil]];
      }
      
      didPresentNewController = [self presentController:controller
                                       parentController:parentController
                                                   mode:pattern.navigationMode
                                                 action:action];
    }
  }
  return didPresentNewController;
}


- (UIViewController*)parentForController:(UIViewController*)controller
                             isContainer:(BOOL)isContainer
                           parentURLPath:(NSString*)parentURLPath {
  if (controller == _rootViewController) {
    return nil;
    
  } else {
    // If this is the first controller, and it is not a "container", forcibly put
    // a navigation controller at the root of the controller hierarchy.
    if (nil == _rootViewController && !isContainer) {
      [self setRootViewController:[[[[self navigationControllerClass] alloc] init] autorelease]];
    }
    
    if (nil != parentURLPath) {
      return [self openURLAction:[TCURLAction actionWithURLPath:parentURLPath]];
      
    } else {
      UIViewController *parent = self.topViewController;
      if (parent != controller) {
        return parent;
        
      } else {
        return nil;
      }
    }
  }
}


- (UIViewController*)topViewController {
  UIViewController *controller = _rootViewController;
  while (controller) {
    UIViewController *child = controller.presentedViewController;
    if (!child) {
      child = controller.topSubcontroller;
    }
    if (child) {
      if (child == _rootViewController) {
        return child;
        
      } else {
        controller = child;
      }
      
    } else {
      return controller;
    }
  }
  return nil;
}



@end
