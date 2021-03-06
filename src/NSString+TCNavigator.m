//
//  NSString+TCNavigator.m
//  TCNavigator
//
//  Created by xbwu on 17/2/27.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "NSString+TCNavigator.h"

@implementation NSString (TCNavigator)


- (NSDictionary*)queryContentsUsingEncoding:(NSStringEncoding)encoding {
  NSCharacterSet *delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
  NSMutableDictionary *pairs = [NSMutableDictionary dictionary];
  NSScanner *scanner = [[NSScanner alloc] initWithString:self];
  while (![scanner isAtEnd]) {
    NSString* pairString = nil;
    [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
    [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
    NSArray *kvPair = [pairString componentsSeparatedByString:@"="];
    if (kvPair.count == 1 || kvPair.count == 2) {
      NSString *key = [[kvPair objectAtIndex:0]
                       stringByReplacingPercentEscapesUsingEncoding:encoding];
      NSMutableArray *values = [pairs objectForKey:key];
      if (nil == values) {
        values = [NSMutableArray array];
        [pairs setObject:values forKey:key];
      }
      if (kvPair.count == 1) {
        [values addObject:[NSNull null]];
        
      } else if (kvPair.count == 2) {
        NSString *value = [[kvPair objectAtIndex:1]
                           stringByReplacingPercentEscapesUsingEncoding:encoding];
        [values addObject:value];
      }
    }
  }
  return [NSDictionary dictionaryWithDictionary:pairs];
}


@end
