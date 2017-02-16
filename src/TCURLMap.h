//
//  TCURLMap.h
//  TCNavigator
//
//  Created by xbwu on 17/2/14.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCURLNavigatorPattern.h"

@interface TCURLMap : NSObject {
  NSMutableArray      *_objectPatterns;
  
  NSMutableDictionary *_schemes;
}


- (void)from:(NSString*)URL toViewController:(id)target;
- (void)from:(NSString*)URL toViewController:(id)target selector:(SEL)selector;
- (void)from:(NSString*)URL parent:(NSString*)parentURL toViewController:(id)target selector:(SEL)selector;


- (void)from:(NSString*)URL toModalViewController:(id)target;
- (void)from:(NSString*)URL toModalViewController:(id)target selector:(SEL)selector;
- (void)from:(NSString*)URL parent:(NSString*)parentURL toModalViewController:(id)target selector:(SEL)selector;


- (void)from:(NSString*)URL toSharedViewController:(id)target;
- (void)from:(NSString*)URL toSharedViewController:(id)target selector:(SEL)selector;
- (void)from:(NSString*)URL parent:(NSString*)parentURL toSharedViewController:(id)target selector:(SEL)selector;


- (id)objectForURL:(NSString*)URL
             query:(NSDictionary*)query
           pattern:(TCURLNavigatorPattern**)outPattern;

@end
