//
//  AlertController.h
//  TheHodorApp
//
//  Created by Abbin Varghese on 30/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertController : UIViewController


-(void)withCompletionHandler:(void(^)(NSString *name))handler;

@end
