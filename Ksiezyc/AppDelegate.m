//
//  AppDelegate.m
//  Ksiezyc
//
//  Created by Paweł Ksieniewicz on 16.05.2013.
//  Copyright (c) 2013 Paweł Ksieniewicz. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[MoonViewController alloc] init];
    self.window.layer.cornerRadius = 20;
    self.window.clipsToBounds = YES;
    [self.window makeKeyAndVisible];
    return YES;
}

@end