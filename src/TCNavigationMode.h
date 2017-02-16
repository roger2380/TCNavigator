//
//  TCNavigationMode.h
//  TCNavigator
//
//  Created by xbwu on 17/2/16.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#ifndef TCNavigationMode_h
#define TCNavigationMode_h

typedef enum {
  TCNavigationModeNone,
  TCNavigationModeCreate,            // a new view controller is created each time
  TCNavigationModeShare,             // a new view controller is created, cached and re-used
  TCNavigationModeModal,             // a new view controller is created and presented modally
  TCNavigationModePopover,           // a new view controller is created and presented in a popover
  TCNavigationModeExternal,          // an external app will be opened
} TCNavigationMode;

#endif /* TCNavigationMode_h */
