//
//  AppDelegate.m
//  FQLockSDKDemo
//
//  Created by TKiOS on 2022/9/27.
//

#import "AppDelegate.h"
#import "FQLockGestureViewController.h"
#import <FQLockSDK/FQLockSDK.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self localLockBecomeActive];
}

- (void)localLockBecomeActive {
    if (![self.window.rootViewController isKindOfClass:[FQLockGestureViewController class]] && ![self.window.rootViewController.presentedViewController isKindOfClass:[FQLockGestureViewController class]]) {
            if ([FQLockHelper isLocalGestureEnableForUserId:@"1"] || [FQLockHelper isBiometryAuthEnableForUserId:@"1"]) {
                __weak typeof(self) weakSelf = self;
                FQLockGestureViewController *lockVC = [[FQLockGestureViewController alloc] init];
                lockVC.lockType = FQGestureLockTypeLogin;
                lockVC.userID = @"1";
                lockVC.localLockBlock = ^(BOOL complete) {
                    if (complete) {
                        [weakSelf.window.rootViewController dismissViewControllerAnimated:NO completion:^{
                            
                        }];
                    }
                };
                lockVC.modalPresentationStyle = UIModalPresentationFullScreen;

                [self.window.rootViewController presentViewController:lockVC animated:NO completion:^{
                    
                }];
                
            }
    }
    
}

@end
