//
//  AppDelegate.m
//  BlueCapUI
//
//  Created by Troy Stribling on 8/13/13.
//  Copyright (c) 2013 gnos.us. All rights reserved.
//

#import <BlueCap/BlueCap.h>
#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [TISensorTagServiceProfile create];
    [BLESIGGATTProfiles create];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application {
    BlueCapCentralManager* central = [BlueCapCentralManager sharedInstance];
    [central stopScanning];
    [central disconnectAllPeripherals];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
