//
//  TCURLPattern.m
//  TCNavigator
//
//  Created by xbwu on 17/2/16.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "TCURLPattern.h"

@implementation TCURLPattern


- (id)init {
  self = [super init];
  if (self) {
    _path = [[NSMutableArray alloc] init];
  }
  return self;
}


- (void)compileURL {
  NSURL* URL = [NSURL URLWithString:_URL];
  _scheme = [URL.scheme copy];
  if (URL.host) {
    [self parsePathComponent:URL.host];
    
    if (URL.path) {
      for (NSString* name in URL.path.pathComponents) {
        if (![name isEqualToString:@"/"]) {
          [self parsePathComponent:name];
        }
      }
    }
  }
  
  if (URL.query) {
    NSDictionary* query = [URL.query queryContentsUsingEncoding:NSUTF8StringEncoding];
    for (NSString* name in [query keyEnumerator]) {
      NSString* value = [[query objectForKey:name] objectAtIndex:0];
      [self parseParameter:name value:value];
    }
  }
}


- (id<TTURLPatternText>)parseText:(NSString*)text {
  NSInteger len = text.length;
  if (len >= 2
      && [text characterAtIndex:0] == '('
      && [text characterAtIndex:len - 1] == ')') {
    NSInteger endRange = len > 3 && [text characterAtIndex:len - 2] == ':'
    ? len - 3
    : len - 2;
    
    NSString* name = len > 2 ? [text substringWithRange:NSMakeRange(1, endRange)] : nil;
    
    TTURLWildcard* wildcard = [[[TTURLWildcard alloc] init] autorelease];
    wildcard.name = name;
    
    ++_specificity;
    
    return wildcard;
    
  } else {
    TTURLLiteral* literal = [[[TTURLLiteral alloc] init] autorelease];
    literal.name = text;
    _specificity += 2;
    return literal;
  }
}


- (void)parsePathComponent:(NSString*)value {
  id<TTURLPatternText> component = [self parseText:value];
  [_path addObject:component];
}


- (void)parseParameter:(NSString*)name value:(NSString*)value {
  if (nil == _query) {
    _query = [[NSMutableDictionary alloc] init];
  }
  
  id<TTURLPatternText> component = [self parseText:value];
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
