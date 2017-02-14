//
//  TCNavigator.m
//  TCNavigator
//
//  Created by xbwu on 17/2/14.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "TCNavigator.h"
#import "TCNavigtorDelegate.h"

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

  
}

@end
