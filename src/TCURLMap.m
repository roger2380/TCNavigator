//
//  TCURLMap.m
//  TCNavigator
//
//  Created by xbwu on 17/2/14.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "TCURLMap.h"
#import "TCURLNavigatorPattern.h"


@implementation TCURLMap


- (void)registerScheme:(NSString*)scheme {
  if (nil != scheme) {
    if (nil == _schemes) {
      _schemes = [[NSMutableDictionary alloc] init];
    }
    [_schemes setObject:[NSNull null] forKey:scheme];
  }
}


- (BOOL)isSchemeSupported:(NSString*)scheme {
  return nil != scheme && !![_schemes objectForKey:scheme];
}


- (void)addObjectPattern:(TCURLNavigatorPattern*)pattern
                  forURL:(NSString*)URL {
  pattern.URL = URL;
  [pattern compile];
  [self registerScheme:pattern.scheme];

  if (_objectPatterns == nil) {
    _objectPatterns = [[NSMutableArray alloc] init];
  }
  [_objectPatterns addObject:pattern];
}


- (void)from:(NSString*)URL toViewController:(id)target {
  
}


- (void)from:(NSString*)URL toModalViewController:(id)target {
  
}


- (void)from:(NSString*)URL toSharedViewController:(id)target {
  
}


@end
