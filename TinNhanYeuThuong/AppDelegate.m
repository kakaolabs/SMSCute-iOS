//
//  AppDelegate.m
//  TinNhanYeuThuong
//
//  Created by Kien Nguyen on 1/24/14.
//  Copyright (c) 2014 kakaolabs. All rights reserved.
//

#import "GAI.h"
#import "JASidePanelController.h"

#import "AppDelegate.h"
#import "DBEngine.h"
#import "LeftMenuViewController.h"
#import "MainViewController.h"

@implementation AppDelegate

- (void) setUpRootViewController
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.viewController = [[JASidePanelController alloc] init];
    self.viewController.panningLimitedToTopViewController = NO;
    
    MainViewController *mainVC = [[MainViewController alloc] init];
    mainVC.viewController = self.viewController;
    
    LeftMenuViewController *leftMenuVC = [[LeftMenuViewController alloc] init];
    leftMenuVC.mainVC = mainVC;
    leftMenuVC.viewController = self.viewController;
    
    self.viewController.leftPanel = leftMenuVC;
    self.viewController.centerPanel = mainVC;
    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
}

- (void) setUpDatabase
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *txtPath = [documentsDirectory stringByAppendingPathComponent:@"UserDatabase.sqlite"];
    
    if ([fileManager fileExistsAtPath:txtPath] == NO) {
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"UserDatabase" ofType:@"sqlite"];
        [fileManager copyItemAtPath:resourcePath toPath:txtPath error:&error];
    }
}

- (void) setUpGoogleAnalytics
{
    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    // Initialize tracker.
    [[GAI sharedInstance] trackerWithTrackingId:GA_ID];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setUpDatabase];
    [self setUpGoogleAnalytics];
    [self setUpRootViewController];
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
    DBEngine *database = [DBEngine sharedEngine];
    [database close];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    DBEngine *database = [DBEngine sharedEngine];
    [database open];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    DBEngine *database = [DBEngine sharedEngine];
    [database open];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    DBEngine *database = [DBEngine sharedEngine];
    [database close];
}

@end
