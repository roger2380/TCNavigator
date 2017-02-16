//
//  TCURLPattern.m
//  TCNavigator
//
//  Created by xbwu on 17/2/16.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "TCURLPattern.h"

#import "TCURLLiteral.h"
#import "TCURLWildcard.h"

#import <objc/runtime.h>

@interface TCURLPattern() {

}

@end

@implementation TCURLPattern


- (id)init {
  self = [super init];
  if (self) {
    _path = [[NSMutableArray alloc] init];
  }
  return self;
}


- (void)compileURL {
  NSURL *URL = [NSURL URLWithString:_URL];
  _scheme = [URL.scheme copy];
  if (URL.host) {
    [self parsePathComponent:URL.host];
    
    //解析path，数组存放
    if (URL.path) {
      for (NSString *name in URL.path.pathComponents) {
        if (![name isEqualToString:@"/"]) {
          [self parsePathComponent:name];
        }
      }
    }
  }
  
  //解析query,字典
  if (URL.query) {
    NSDictionary *query = [URL.query queryContentsUsingEncoding:NSUTF8StringEncoding];
    for (NSString *name in [query keyEnumerator]) {
      NSString *value = [[query objectForKey:name] objectAtIndex:0];
      [self parseParameter:name value:value];
    }
  }
}

//如果是以()扩起来的，转换成TCURLWildcard，否则转换成TCURLLiteral
- (id<TCURLPatternText>)parseText:(NSString*)text {
  NSInteger len = text.length;
  if (len >= 2
      && [text characterAtIndex:0] == '('
      && [text characterAtIndex:len - 1] == ')') {
    NSInteger endRange = len > 3 && [text characterAtIndex:len - 2] == ':'
    ? len - 3
    : len - 2;
    
    NSString* name = len > 2 ? [text substringWithRange:NSMakeRange(1, endRange)] : nil;
    
    TCURLWildcard* wildcard = [[TCURLWildcard alloc] init];
    wildcard.name = name;
    
    ++_specificity;
    
    return wildcard;
    
  } else {
    TCURLLiteral *literal = [[TCURLLiteral alloc] init];
    literal.name = text;
    _specificity += 2;
    return literal;
  }
}


- (void)parsePathComponent:(NSString*)value {
  id<TCURLPatternText> component = [self parseText:value];
  [_path addObject:component];
}


- (void)parseParameter:(NSString*)name value:(NSString*)value {
  if (nil == _query) {
    _query = [[NSMutableDictionary alloc] init];
  }
  
  id<TCURLPatternText> component = [self parseText:value];
  [_query setObject:component forKey:name];
}


- (void)setSelectorWithNames:(NSArray*)names {
  NSString* selectorName = [[names componentsJoinedByString:@":"] stringByAppendingString:@":"];
  SEL selector = NSSelectorFromString(selectorName);
  [self setSelectorIfPossible:selector];
}


- (void)setSelectorIfPossible:(SEL)selector {
  Class cls = [self classForInvocation];
  if (nil == cls
      || class_respondsToSelector(cls, selector)
      || class_getClassMethod(cls, selector)) {
    _selector = selector;
  }
}


- (Class)classForInvocation {
  return nil;
}

@end
