//
//  AppDelegate.m
//  TCNavigator
//
//  Created by xbwu on 17/2/14.
//  Copyright © 2017年 xbwu. All rights reserved.
//

#import "AppDelegate.h"
#import "TCURLMap.h"
#import "TCNavigator.h"
#import "ViewController.h"

#import "AViewController.h"
#import "BViewController.h"
#import "AViewController.h"

#import "Tab1ViewController.h"
#import "Tab2ViewController.h"
#import "Tab3ViewController.h"
#import "Tab4ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  [self.window makeKeyAndVisible];
  
  TCURLMap *map = [TCNavigator navigator].URLMap;
  
  
  [map from:@"com.manga://vc" toViewController:[ViewController class]];
  [map from:@"com.manga://vc-a" parent:@"com.manga://tab3" toModalViewController:[AViewController class] selector:NULL];
  [map from:@"com.manga://vc-b" toViewController:[BViewController class]];

  Tab1ViewController *tab1 = [[Tab1ViewController alloc] init];
  UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:tab1];
  nav1.tabBarItem.title = @"tab1";
  
  Tab2ViewController *tab2 = [[Tab2ViewController alloc] init];
  UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:tab2];
  nav2.tabBarItem.title = @"tab2";

  Tab3ViewController *tab3 = [[Tab3ViewController alloc] init];
  UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:tab3];
  nav3.tabBarItem.title = @"tab3";

  Tab4ViewController *tab4 = [[Tab4ViewController alloc] init];
  UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:tab4];
  nav4.tabBarItem.title = @"tab4";

  [map from:@"com.manga://tab1" toSharedViewController:nav1];
  [map from:@"com.manga://tab2" toSharedViewController:nav2];
  [map from:@"com.manga://tab3" toSharedViewController:nav3];
  [map from:@"com.manga://tab4" toSharedViewController:nav4];
  
  UITabBarController *tabVC = [[UITabBarController alloc] init];
  tabVC.viewControllers = [NSArray arrayWithObjects:nav1, nav2, nav3, nav4, nil];
  [map from:@"com.manga://tabvc" toSharedViewController:tabVC];

  [[TCNavigator navigator] openURLAction:[TCURLAction actionWithURLPath:@"com.manga://tabvc"]];
  return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
