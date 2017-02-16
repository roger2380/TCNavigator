//
//  TCURLPattern.h
//  TCNavigator
//
//  Created by xbwu on 17/2/16.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCURLPattern : NSObject {
  NSMutableArray        *_path;
  NSMutableDictionary   *_query;
}

@property (nonatomic, readonly) NSString  *scheme;
@property (nonatomic, readonly) NSInteger specificity;
@property (nonatomic, copy)     NSString  *URL;
@property (nonatomic)           SEL       selector;
@property (nonatomic, readonly) Class     classForInvocation;

- (void)compileURL;

- (void)setSelectorWithNames:(NSArray*)names;
- (void)setSelectorIfPossible:(SEL)selector;

@end
