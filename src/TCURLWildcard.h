//
//  TCURLWildcard.h
//  TCNavigator
//
//  Created by xbwu on 17/2/16.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCURLPatternText.h"
#import "TCURLArguments.h"

@interface TCURLWildcard : NSObject <TCURLPatternText>

@property (nonatomic)       NSInteger         argIndex;
@property (nonatomic)       TCURLArgumentType argType;
@property (nonatomic, copy) NSString          *name;

@end
