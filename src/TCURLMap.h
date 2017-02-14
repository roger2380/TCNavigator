//
//  TCURLMap.h
//  TCNavigator
//
//  Created by xbwu on 17/2/14.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCURLMap : NSObject {
  NSMutableArray      *_objectPatterns;
  
  NSMutableDictionary *_schemes;
}

- (void)from:(NSString*)URL toSharedViewController:(id)target;
- (void)from:(NSString*)URL toModalViewController:(id)target;
- (void)from:(NSString*)URL toViewController:(id)target;

@end
