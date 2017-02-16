//
//  TCURLNavigatorPattern.m
//  TCNavigator
//
//  Created by xbwu on 17/2/14.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "TCURLNavigatorPattern.h"
#import "TCURLPatternText.h"
#import "TCURLWildcard.h"

@interface TCURLNavigatorPattern () {
  NSInteger _argumentCount;
}

@end

@implementation TCURLNavigatorPattern


- (id)init {
  self = [self initWithTarget:nil];
  if (self) {
  }
  return self;
}


- (id)initWithTarget:(id)target {
  self = [self initWithTarget:target mode:TCNavigationModeNone];
  if (self) {
  }
  return self;
}


- (id)initWithTarget:(id)target
                mode:(TCNavigationMode)navigationMode {
  self = [super init];
  if (self) {
    _navigationMode = navigationMode;
    
    if ([target class] == target && navigationMode) {
      _targetClass = target;
      
    } else {
      _targetObject = target;
    }
  }
  
  return self;
}


- (BOOL)instantiatesClass {
  return nil != _targetClass && TCNavigationModeNone != _navigationMode;
}


- (id)invoke:(id)target withURL:(NSURL*)URL {
  id returnValue = nil;
  
  NSMethodSignature *sig = [target methodSignatureForSelector:self.selector];
  if (sig) {
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:sig];
    [invocation setTarget:target];
    [invocation setSelector:self.selector];
    [self setArgumentsFromURL:URL forInvocation:invocation];
    [invocation invoke];
    
    if (sig.methodReturnLength) {
      [invocation getReturnValue:&returnValue];
    }
  }
  
  return returnValue;
}


- (void)setArgumentsFromURL:(NSURL*)URL
              forInvocation:(NSInvocation*)invocation {
  
//  NSInteger remainingArgs = _argumentCount;
  
  NSArray* pathComponents = URL.path.pathComponents;
  for (NSInteger i = 0; i < _path.count; ++i) {
    id<TCURLPatternText> patternText = [_path objectAtIndex:i];
    NSString* text = i == 0 ? URL.host : [pathComponents objectAtIndex:i];
    if ([self setArgument:text pattern:patternText forInvocation:invocation]) {
//      --remainingArgs;
    }
  }
  
  NSDictionary* URLQuery = [URL.query queryContentsUsingEncoding:NSUTF8StringEncoding];
  if (URLQuery.count) {
    for (NSString* name in [URLQuery keyEnumerator]) {
      id<TCURLPatternText> patternText = [_query objectForKey:name];
      NSString* text = [[URLQuery objectForKey:name] objectAtIndex:0];
      if (patternText) {
        if ([self setArgument:text pattern:patternText forInvocation:invocation]) {
//          --remainingArgs;
        }
        
      } else {
//        if (!unmatchedArgs) {
//          unmatchedArgs = [NSMutableDictionary dictionary];
//        }
//        [unmatchedArgs setObject:text forKey:name];
      }
    }
  }
  
//  if (remainingArgs && unmatchedArgs.count) {
//    // If there are unmatched arguments, and the method signature has extra arguments,
//    // then pass the dictionary of unmatched arguments as the last argument
//    [invocation setArgument:&unmatchedArgs atIndex:_argumentCount+1];
//  }
//  
//  if (URL.fragment && _fragment) {
//    [self setArgument:URL.fragment pattern:_fragment forInvocation:invocation];
//  }
}


- (BOOL)setArgument:(NSString*)text
            pattern:(id<TCURLPatternText>)patternText
      forInvocation:(NSInvocation*)invocation {
  
  if ([patternText isKindOfClass:[TCURLWildcard class]]) {
    TCURLWildcard* wildcard = (TCURLWildcard*)patternText;
    NSInteger argIndex = wildcard.argIndex;
    if (argIndex != NSNotFound && argIndex < _argumentCount) {
      switch (wildcard.argType) {
        case TCURLArgumentTypeNone: {
          break;
        }
        case TCURLArgumentTypeInteger: {
          int val = [text intValue];
          [invocation setArgument:&val atIndex:argIndex+2];
          break;
        }
        case TCURLArgumentTypeLongLong: {
          long long val = [text longLongValue];
          [invocation setArgument:&val atIndex:argIndex+2];
          break;
        }
        case TCURLArgumentTypeFloat: {
          float val = [text floatValue];
          [invocation setArgument:&val atIndex:argIndex+2];
          break;
        }
        case TCURLArgumentTypeDouble: {
          double val = [text doubleValue];
          [invocation setArgument:&val atIndex:argIndex+2];
          break;
        }
        case TCURLArgumentTypeBool: {
          BOOL val = [text boolValue];
          [invocation setArgument:&val atIndex:argIndex+2];
          break;
        }
        default: {
          [invocation setArgument:&text atIndex:argIndex+2];
          break;
        }
      }
      return YES;
    }
  }
  return NO;
}


//匹配规则:只要path的count一致，并且每一个path要吻合，
//_path第一个元素是host
- (BOOL)matchURL:(NSURL*)URL {
  if (!URL.scheme || !URL.host || ![self.scheme isEqualToString:URL.scheme]) {
    return NO;
  }
  
  NSArray* pathComponents = URL.path.pathComponents;
  NSInteger componentCount = URL.path.length ? pathComponents.count : (URL.host ? 1 : 0);
  if (componentCount != _path.count) {
    return NO;
  }
  
  if (_path.count && URL.host) {
    id<TCURLPatternText>hostPattern = [_path objectAtIndex:0];
    if (![hostPattern match:URL.host]) {
      return NO;
    }
  }
  
  for (NSInteger i = 1; i < _path.count; ++i) {
    id<TCURLPatternText>pathPattern = [_path objectAtIndex:i];
    NSString* pathText = [pathComponents objectAtIndex:i];
    if (![pathPattern match:pathText]) {
      return NO;
    }
  }
  
  return YES;
}


- (id)createObjectFromURL:(NSURL*)URL {
  id returnValue = nil;
  
  if (self.instantiatesClass) {
    //suppress static analyzer warning for this part
    // - invoke:withURL:query actually calls an - init method
    // which returns either a new object with retain count of +1
    // or returnValue (which already has +1 retain count)
#ifndef __clang_analyzer__
    returnValue = [_targetClass alloc];
    if (self.selector) {
      returnValue = [self invoke:returnValue withURL:URL];
      
    } else {
      returnValue = [returnValue init];
    }
#endif
    
  } else {
    id target = _targetObject;
    if (self.selector) {
      returnValue = [self invoke:target withURL:URL];
      
    } else {
      NSLog(@"No object created from URL:'%@' URL", URL);
    }
  }
  return returnValue;
}


- (void)compile {
  [self compileURL];
  
  if (!self.selector) {
    [self deduceSelector];
  }
  if (self.selector) {
    [self analyzeMethod];
  }
}


- (Class)classForInvocation {
  return _targetClass ? _targetClass : [_targetObject class];
}


@end
