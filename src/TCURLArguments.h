//
//  TCURLArguments.h
//  TCNavigator
//
//  Created by xbwu on 17/2/16.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
  TCURLArgumentTypeNone,
  TCURLArgumentTypePointer,
  TCURLArgumentTypeBool,
  TCURLArgumentTypeInteger,
  TCURLArgumentTypeLongLong,
  TCURLArgumentTypeFloat,
  TCURLArgumentTypeDouble,
} TCURLArgumentType;


TCURLArgumentType TCConvertArgumentType(char argType);

