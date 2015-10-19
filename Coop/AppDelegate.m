//
//  AppDelegate.m
//  Coop
//
//  Created by Pankaj Verma on 09/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//



#import "AppDelegate.h"
#import "LeftMenuViewController.h"
#import "RightMenuViewController.h"
#import "MFSideMenu.h"
#import "NewsViewController.h"
#import "HomeViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    LeftMenuViewController *lmvc = [[LeftMenuViewController alloc ]initWithNibName:@"LeftMenuViewController" bundle:nil];
    RightMenuViewController *rmvc = [[RightMenuViewController alloc]initWithNibName:@"RightMenuViewController" bundle:nil];

    HomeViewController *hvc = [[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:hvc];
    //     nav.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"Menu" style:UIBarButtonItemStyleDone target:self action:@selector(openLeftMenu)];
   // UINavigationController *nav_cvc = [[UINavigationController alloc] initWithRootViewController:cvc];
    
    MFSideMenuContainerViewController *container = [MFSideMenuContainerViewController
                                                    containerWithCenterViewController:nav
                                                    leftMenuViewController:lmvc
                                                    rightMenuViewController:rmvc];
    
  //  UINavigationController *passcodeNavigationController = [[UINavigationController alloc] initWithRootViewController:[MFSideMenuContainerViewController containerWithCenterViewController:nvc                                                    leftMenuViewController:lmvc                                                    rightMenuViewController:rmvc]];
   // self.window.rootViewController = [MFSideMenuContainerViewController containerWithCenterViewController:cvc                                                    leftMenuViewController:lmvc
   
    
    self.window.rootViewController.edgesForExtendedLayout = UIRectEdgeAll;
//    NSArray *baritems = [NSArray arrayWithObjects:[UIImage imageNamed:@"crop"], nil];
//    passcodeNavigationController.toolbarItems = baritems;
//    passcodeNavigationController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"crop"] style:UIBarButtonSystemItemDone target:nil action:nil];
    
    self.window.rootViewController = container;

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
