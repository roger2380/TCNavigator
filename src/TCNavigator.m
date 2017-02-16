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
                                                      query:action.query
                                                    pattern:&pattern];
  
}


- (UIViewController*)viewControllerForURL:(NSString*)URL
                                    query:(NSDictionary*)query
                                  pattern:(TCURLNavigatorPattern**)pattern {
  
  id object = [_URLMap objectForURL:URL query:query pattern:pattern];
  if (object) {
    UIViewController *controller = object;
    controller.originalNavigatorURL = URL;
    
    if (_delayCount) {
      if (!_delayedControllers) {
        _delayedControllers = [[NSMutableArray alloc] initWithObjects:controller,nil];
        
      } else {
        [_delayedControllers addObject:controller];
      }
    }
    
    return controller;
    
  } else {
    return nil;
  }
}


@end
