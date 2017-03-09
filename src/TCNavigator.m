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


+ (TCNavigator*)navigator {
  TCNavigator *navigator = [TCNavigator globalNavigator];
  if (nil == navigator) {
    navigator = [[TCNavigator alloc] init];
    [self setGlobalNavigator:navigator];
  }
  return navigator;
}


+ (void)setGlobalNavigator:(TCNavigator*)navigator {
  if (gNavigator != navigator) {
    gNavigator = navigator;
  }
}


+ (TCNavigator*)globalNavigator {
  return gNavigator;
}


- (void)setRootViewController:(UIViewController*)controller {
  if (controller != _rootViewController) {
    _rootViewController = controller;
    [self.window setRootViewController:_rootViewController];
  }
}


- (UIWindow*)window {
  if (nil == _window) {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (nil != keyWindow) {
      _window = keyWindow;
    }
  }
  return _window;
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


- (BOOL)presentController:(UIViewController*)controller
            parentURLPath:(NSString*)parentURLPath
              withPattern:(TCURLNavigatorPattern*)pattern
                   action:(TCURLAction*)action {
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
                           mode:TCNavigationModeNone
                         action:[TCURLAction actionWithURLPath:nil]];
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
      [self setRootViewController:[[[self navigationControllerClass] alloc] init]];
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


- (BOOL)presentController:(UIViewController*)controller
         parentController:(UIViewController*)parentController
                     mode:(TCNavigationMode)mode
                   action:(TCURLAction*)action {
  BOOL didPresentNewController = YES;
  
  if (nil == _rootViewController) {
    [self setRootViewController:controller];
    
  } else {
    UIViewController *previousSuper = controller.superController;
    //如果controller有contain controller ，比如navgation controller 或者 tabbar controller
    if (nil != previousSuper) {
      if (previousSuper != parentController) {
        //如果这个控制器已经存在在栈中
        for (UIViewController *superController = previousSuper; controller; ) {
          if (superController.presentedViewController) {
            [superController dismissViewControllerAnimated:YES completion:NULL];
          }
          UIViewController *nextSuper = superController.superController;
          [superController bringControllerToFront:controller
                                         animated:!nextSuper];
          controller = superController;
          superController = nextSuper;
        }
      }
      didPresentNewController = NO;
      
    } else if (nil != parentController) {
      [self presentDependantController:controller
                      parentController:parentController
                                  mode:mode
                                action:action];
    }
  }
  
  return didPresentNewController;
}


- (void)presentDependantController:(UIViewController*)controller
                  parentController:(UIViewController*)parentController
                              mode:(TCNavigationMode)mode
                            action:(TCURLAction*)action {
  
  if (mode == TCNavigationModeModal) {
    [self presentModalController:controller
                parentController:parentController
                        animated:action.animated];
    
  } else if (mode == TCNavigationModePopover) {
   //暂时不支持
    
  } else {
    [parentController addSubcontroller:controller
                              animated:action.animated];
  }
}


- (void)presentModalController:(UIViewController*)controller
              parentController:(UIViewController*)parentController
                      animated:(BOOL)animated {
  if ([controller isKindOfClass:[UINavigationController class]]) {
    [parentController presentViewController:controller animated:animated completion:NULL];
    
  } else {
    UINavigationController *navController = [[[self navigationControllerClass] alloc] init];
//    navController.modalTransitionStyle = transition;
    navController.modalPresentationStyle = controller.modalPresentationStyle;
    [navController pushViewController: controller
                             animated: NO];
    [parentController presentViewController:navController animated:animated completion:NULL];
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


- (Class)navigationControllerClass {
  return [UINavigationController class];
}


@end
