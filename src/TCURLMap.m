//
//  TCURLMap.m
//  TCNavigator
//
//  Created by xbwu on 17/2/14.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "TCURLMap.h"
#import "TCURLNavigatorPattern.h"

@interface  TCURLMap() {
  NSMutableDictionary *_objectMappings;
}

@end

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


- (TCURLNavigatorPattern*)matchObjectPattern:(NSURL*)URL {
//  if (_invalidPatterns) {
//    [_objectPatterns sortUsingSelector:@selector(compareSpecificity:)];
//    _invalidPatterns = NO;
//  }
  
  for (TCURLNavigatorPattern *pattern in _objectPatterns) {
    if ([pattern matchURL:URL]) {
      return pattern;
    }
  }
  return nil;
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
  TCURLNavigatorPattern *pattern = [[TCURLNavigatorPattern alloc] initWithTarget:target
                                                                            mode:TCNavigationModeCreate];
  [self addObjectPattern:pattern forURL:URL];
}


- (void)from:(NSString*)URL toViewController:(id)target selector:(SEL)selector {
  TCURLNavigatorPattern *pattern = [[TCURLNavigatorPattern alloc] initWithTarget:target
                                                                            mode:TCNavigationModeCreate];
  pattern.selector = selector;
  [self addObjectPattern:pattern forURL:URL];
}


- (void)from:(NSString*)URL parent:(NSString*)parentURL toViewController:(id)target selector:(SEL)selector {
  TCURLNavigatorPattern *pattern = [[TCURLNavigatorPattern alloc] initWithTarget:target
                                                                            mode:TCNavigationModeCreate];
  pattern.parentURL = parentURL;
  pattern.selector = selector;
  [self addObjectPattern:pattern forURL:URL];
}


- (void)from:(NSString*)URL toModalViewController:(id)target {
  TCURLNavigatorPattern *pattern = [[TCURLNavigatorPattern alloc] initWithTarget:target
                                                                            mode:TCNavigationModeModal];
  [self addObjectPattern:pattern forURL:URL];
}


- (void)from:(NSString*)URL toModalViewController:(id)target selector:(SEL)selector {
  TCURLNavigatorPattern *pattern = [[TCURLNavigatorPattern alloc] initWithTarget:target
                                                                            mode:TCNavigationModeModal];
  pattern.selector = selector;
  [self addObjectPattern:pattern forURL:URL];
}


- (void)from:(NSString*)URL parent:(NSString*)parentURL toModalViewController:(id)target selector:(SEL)selector {
  TCURLNavigatorPattern *pattern = [[TCURLNavigatorPattern alloc] initWithTarget:target
                                                                            mode:TCNavigationModeModal];
  pattern.selector = selector;
  pattern.parentURL = parentURL;
  [self addObjectPattern:pattern forURL:URL];
}


- (void)from:(NSString*)URL toSharedViewController:(id)target {
  TCURLNavigatorPattern *pattern = [[TCURLNavigatorPattern alloc] initWithTarget:target
                                                                            mode:TCNavigationModeShare];
  [self addObjectPattern:pattern forURL:URL];
}


- (void)from:(NSString*)URL toSharedViewController:(id)target selector:(SEL)selector {
  TCURLNavigatorPattern *pattern = [[TCURLNavigatorPattern alloc] initWithTarget:target
                                                                            mode:TCNavigationModeShare];
  pattern.selector = selector;
  [self addObjectPattern:pattern forURL:URL];
}


- (void)from:(NSString*)URL parent:(NSString*)parentURL toSharedViewController:(id)target selector:(SEL)selector {
  TCURLNavigatorPattern *pattern = [[TCURLNavigatorPattern alloc] initWithTarget:target
                                                                            mode:TCNavigationModeShare];
  pattern.selector = selector;
  pattern.parentURL = parentURL;
  [self addObjectPattern:pattern forURL:URL];
}


- (id)objectForURL:(NSString*)URL
           pattern:(TCURLNavigatorPattern**)outPattern {
  id object = nil;
  if (_objectMappings) {
    object = [_objectMappings objectForKey:URL];
    if (object && !outPattern) {
      return object;
    }
  }
  
  NSURL *theURL = [NSURL URLWithString:URL];
  TCURLNavigatorPattern *pattern = [self matchObjectPattern:theURL];
  if (pattern) {
    if (!object) {
      object = [pattern createObjectFromURL:theURL];
    }
    if (pattern.navigationMode == TCNavigationModeShare && object) {
      [self setObject:object forURL:URL];
    }
    if (outPattern) {
      *outPattern = pattern;
    }
    return object;
    
  } else {
    return nil;
  }
}


- (void)setObject:(id)object forURL:(NSString*)URL {
  if (nil == _objectMappings) {
//    _objectMappings = TTCreateNonRetainingDictionary();
    _objectMappings = [[NSMutableDictionary alloc] init];
  }
  // XXXjoe Normalize the URL first
  [_objectMappings setObject:object forKey:URL];
  
//  if ([object isKindOfClass:[UIViewController class]]) {
//    [UIViewController ttAddNavigatorController:object];
//  }
}


@end
