//
//  AppDelegate.m
//  testThree20
//
//  Created by Wei Ming Chao on 12/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstVC.h"
#import "SecondVC.h"
#import "ThirdVC.h"
#import "DCFbLoginManager.h"
#import "CustomizedStyleSheet.h"


#import <Three20Core/NSDataAdditions.h>



@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    
    [TTStyleSheet setGlobalStyleSheet:[[CustomizedStyleSheet alloc] init]];
    
    TTNavigator *navigator = [TTNavigator navigator];
    navigator.persistenceMode = TTNavigatorPersistenceModeAll;
    navigator.window = self.window;    

    TTURLMap *map = navigator.URLMap;
    
    [map from:@"*" toViewController:[TTWebController class]];
    [map from:@"my://FirstVC" toSharedViewController:[FirstVC class]];    
    [map from:@"my://SecondVC" toSharedViewController:[SecondVC class]];
    [map from:@"my://SecondVC/(initWithName:)" toSharedViewController:[SecondVC class]];
    [map from:@"my://ThirdVC/(initWithUId:)" toSharedViewController:[ThirdVC class]];
    
    [navigator openURLs:@"my://FirstVC", nil];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}



/*
 * call back by external application
 */
-(BOOL) application:(UIApplication *)application 
            openURL:(NSURL *)url 
  sourceApplication:(NSString *)sourceApplication 
         annotation:(id)annotation
{
    DCFbLoginManager *loginManager = [DCFbLoginManager sharedManager];

    return [loginManager.facebook handleOpenURL:url];
}
@end
