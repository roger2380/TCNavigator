//
//  TCURLLiteral.h
//  TCNavigator
//
//  Created by xbwu on 17/2/16.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCURLPatternText.h"

@interface TCURLLiteral : NSObject <TCURLPatternText>

@property (nonatomic, copy) NSString* name;

@end
