//
//  TCURLNavigatorPattern.h
//  TCNavigator
//
//  Created by xbwu on 17/2/14.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCURLNavigatorPattern : NSObject

@property (nonatomic, copy)     NSString *URL;
@property (nonatomic, readonly) NSString *scheme;

- (void)compile;

@end
