//
//  TCURLArguments.m
//  TCNavigator
//
//  Created by xbwu on 17/2/16.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "TCURLArguments.h"

TCURLArgumentType TCConvertArgumentType(char argType) {
  if (argType == 'c'
      || argType == 'i'
      || argType == 's'
      || argType == 'l'
      || argType == 'C'
      || argType == 'I'
      || argType == 'S'
      || argType == 'L') {
    return TCURLArgumentTypeInteger;
    
  } else if (argType == 'q' || argType == 'Q') {
    return TCURLArgumentTypeLongLong;
    
  } else if (argType == 'f') {
    return TCURLArgumentTypeFloat;
    
  } else if (argType == 'd') {
    return TCURLArgumentTypeDouble;
    
  } else if (argType == 'B') {
    return TCURLArgumentTypeBool;
    
  } else {
    return TCURLArgumentTypePointer;
  }
}
