//
//  AppDelegate.h
//  TheHodorApp
//
//  Created by Abbin Varghese on 30/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NSMutableArray *highScores;

-(void)changeRoot:(UIViewController*)newViewController;

@end

