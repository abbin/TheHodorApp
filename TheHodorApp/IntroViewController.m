//
//  IntroViewController.m
//  TheHodorApp
//
//  Created by Abbin Varghese on 01/10/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "IntroViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"
#import "ViewController.h"

@interface IntroViewController ()

@property (nonatomic, strong)AVAudioPlayer *player;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation IntroViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* Use this code to play an audio file */
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"IMG_0002"  ofType:@"m4a"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    
    [self.player play];
    
    self.label.alpha = 0;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:4 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.label.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.label.alpha = 0;
        } completion:^(BOOL finished) {
            self.label.text = @"Presents";
            [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                self.label.alpha = 1;
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                    self.label.alpha = 0;
                } completion:^(BOOL finished) {
                    self.label.text = @"HOLD THE DOOR";
                    [UIView animateWithDuration:3 delay:2 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                        self.label.alpha = 1;
                    } completion:^(BOOL finished) {
                        [UIView animateWithDuration:3 delay:4 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                            self.label.alpha = 0;
                        } completion:^(BOOL finished) {
                            [self performSelector:@selector(changeRoots) withObject:nil afterDelay:2];
                        }];
                    }];
                }];
            }];
        }];
    }];
}

-(void)changeRoots{
    ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    [delegate changeRoot:vc];
}
@end
