//
//  TCURLAction.m
//  TCNavigator
//
//  Created by xbwu on 17/2/14.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "TCURLAction.h"

@implementation TCURLAction


+ (id)actionWithURLPath:(NSString*)urlPath {
  return [[self alloc] initWithURLPath:urlPath];
}


- (id)initWithURLPath:(NSString*)urlPath {
  self = [super init];
  if (self) {
    self.urlPath = urlPath;
  }
  return self;
}


- (TCURLAction*)applyParentURLPath:(NSString*)parentURLPath {
  self.parentURLPath = parentURLPath;
  return self;
}


@end
