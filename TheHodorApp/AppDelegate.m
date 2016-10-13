//
//  AppDelegate.m
//  TheHodorApp
//
//  Created by Abbin Varghese on 30/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "AppDelegate.h"
@import Firebase;
#import "IntroViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(void)changeRoot:(UIViewController*)newViewController{
    [UIView transitionWithView:self.window
                      duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{ self.window.rootViewController = newViewController; }
                    completion:nil];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [FIRApp configure];
    [FIRDatabase database].persistenceEnabled = YES;
    
//    NSError *error;
//    [[FIRAuth auth] signOut:&error];
//    if (!error) {
//        // Sign-out succeeded
//    }
    
    if ([FIRAuth auth].currentUser == nil) {
        [[FIRAuth auth]
         signInAnonymouslyWithCompletion:^(FIRUser *_Nullable user, NSError *_Nullable error) {
             if (!error) {
                 NSLog(@"User created");
             }
             else{
                 NSLog(@"User create failed with error %@", error.localizedDescription);
             }
         }];
    }
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"userName"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        IntroViewController *rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"IntroViewController"];
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.rootViewController = rootViewController;
        [self.window makeKeyAndVisible];
    }
    
    [[[[[FIRDatabase database] reference] child:@"userScore"] queryOrderedByChild:@"userScore"] observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        if (snapshot.value != [NSNull null]) {
            if (self.highScores == nil) {
                self.highScores = [NSMutableArray array];
            }
            NSLog(@"%@",snapshot.value);
            [self.highScores addObject:snapshot.value];
        }
    }];
    
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
