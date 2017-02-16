//
//  TCURLPatternText.h
//  TCNavigator
//
//  Created by xbwu on 17/2/16.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#ifndef TCURLPatternText_h
#define TCURLPatternText_h

#import <Foundation/Foundation.h>

@protocol TCURLPatternText <NSObject>
@required

- (BOOL)match:(NSString*)text;

@end

#endif /* TCURLPatternText_h */
