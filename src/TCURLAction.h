//
//  TCURLAction.h
//  TCNavigator
//
//  Created by xbwu on 17/2/14.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TCURLAction : NSObject

@property (nonatomic, copy)   NSString  *urlPath;
@property (nonatomic, copy)   NSString  *parentURLPath;
@property (nonatomic, assign) BOOL       animated;

+ (id)actionWithURLPath:(NSString*)urlPath;

- (TCURLAction*)applyParentURLPath:(NSString*)parentURLPath;

- (TCURLAction*)applyAnimated:(BOOL)animated;

@end
