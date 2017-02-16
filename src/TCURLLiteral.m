//
//  TCURLLiteral.m
//  TCNavigator
//
//  Created by xbwu on 17/2/16.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "TCURLLiteral.h"

@implementation TCURLLiteral


- (BOOL)match:(NSString*)text {
  return [text isEqualToString:_name];
}


@end
