//
//  AppDelegate.m
//  XRNestedTableView
//
//  Created by Xinrui Gao on 22/08/12.
//  Copyright (c) 2012 Xinrui Gao. All rights reserved.
//

#import "AppDelegate.h"

#import "TestViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  
  TestViewController *superNav = [[TestViewController alloc] init];
    
  NSArray *dataLv301 = [NSArray arrayWithObjects:@"Lv3011", @"Lv3012", @"Lv3013", nil];
  NSArray *dataLv302 = [NSArray arrayWithObjects:@"Lv3021", @"Lv3022", @"Lv3023", nil];
  NSArray *dataLv303 = [NSArray arrayWithObjects:@"Lv3031", @"Lv3032", @"Lv3033", nil];
  NSArray *dataLv201 = [NSArray arrayWithObjects:dataLv301, dataLv302, dataLv303, nil];
  NSArray *dataLv202 = [NSArray arrayWithObjects:dataLv301, dataLv302, nil];
  NSArray *dataLv101 = [NSArray arrayWithObjects:dataLv201, dataLv202, dataLv201, dataLv202, dataLv201, dataLv202, nil];
  
  superNav.dataSource = dataLv101;
  
  self.window.rootViewController = superNav;
  
  [self.window makeKeyAndVisible];
  
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
