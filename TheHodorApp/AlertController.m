//
//  AlertController.m
//  TheHodorApp
//
//  Created by Abbin Varghese on 30/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "AlertController.h"

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_IPAD_PRO (IS_IPAD && SCREEN_MAX_LENGTH == 1366.0)

@interface AlertController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verticalConstrain;

@property (nonatomic, strong) void(^completionHandler)(NSString *name);

@end

@implementation AlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)withCompletionHandler:(void(^)(NSString *name))handler{
    _completionHandler = handler;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 1;
    }];
    
    [self layOutViewForDevice];
    
    [self.nameTextField becomeFirstResponder];
}

-(void)layOutViewForDevice{
    
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    
    if (IS_IPHONE_4_OR_LESS) {
        switch (orientation) {
            case UIDeviceOrientationPortrait:
            case UIDeviceOrientationPortraitUpsideDown:
                self.verticalConstrain.constant = -100;
                break;
            case UIDeviceOrientationLandscapeLeft:
            case UIDeviceOrientationLandscapeRight:
                self.verticalConstrain.constant = -100;
                break;
            default:
                break;
        }
    }
    else if (IS_IPHONE_5){
        switch (orientation) {
            case UIDeviceOrientationPortrait:
            case UIDeviceOrientationPortraitUpsideDown:
                self.verticalConstrain.constant = -100;
                break;
            case UIDeviceOrientationLandscapeLeft:
            case UIDeviceOrientationLandscapeRight:
                self.verticalConstrain.constant = -125;
                break;
                
            default:
                break;
        }
    }
    else if (IS_IPHONE_6){
        switch (orientation) {
            case UIDeviceOrientationPortrait:
            case UIDeviceOrientationPortraitUpsideDown:
                self.verticalConstrain.constant = -100;
                break;
            case UIDeviceOrientationLandscapeLeft:
            case UIDeviceOrientationLandscapeRight:
                self.verticalConstrain.constant = -100;
                break;
                
            default:
                break;
        }
    }
    else if (IS_IPHONE_6P){
        switch (orientation) {
            case UIDeviceOrientationPortrait:
            case UIDeviceOrientationPortraitUpsideDown:
                self.verticalConstrain.constant = -100;
                break;
            case UIDeviceOrientationLandscapeLeft:
            case UIDeviceOrientationLandscapeRight:
                self.verticalConstrain.constant = -100;
                break;
                
            default:
                break;
        }
    }
    else if (IS_IPAD){
        switch (orientation) {
            case UIDeviceOrientationPortrait:
            case UIDeviceOrientationPortraitUpsideDown:
                self.verticalConstrain.constant = -100;
                break;
            case UIDeviceOrientationLandscapeLeft:
            case UIDeviceOrientationLandscapeRight:
                self.verticalConstrain.constant = -150;
                break;
                
            default:
                break;
        }
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (IBAction)upload:(id)sender {
    if (self.nameTextField.text.length>0) {
        _completionHandler(self.nameTextField.text);
        [self.nameTextField resignFirstResponder];
        [UIView animateWithDuration:0.3 animations:^{
            self.view.alpha = 0;
        } completion:^(BOOL finished) {
            [self dismissViewControllerAnimated:NO completion:nil];
        }];
    }
}

- (IBAction)cancel:(id)sender {
    [self.nameTextField resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.view.alpha = 0;
    } completion:^(BOOL finished) {
        _completionHandler(nil);
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        if (IS_IPHONE_4_OR_LESS) {
            switch (orientation) {
                case UIDeviceOrientationPortrait:
                case UIDeviceOrientationPortraitUpsideDown:
                    self.verticalConstrain.constant = -100;
                    break;
                case UIDeviceOrientationLandscapeLeft:
                case UIDeviceOrientationLandscapeRight:
                    self.verticalConstrain.constant = -100;
                    break;
                    
                default:
                    break;
            }
        }
        else if (IS_IPHONE_5){
            UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
            switch (orientation) {
                case UIDeviceOrientationPortrait:
                case UIDeviceOrientationPortraitUpsideDown:
                    self.verticalConstrain.constant = -100;
                    break;
                case UIDeviceOrientationLandscapeLeft:
                case UIDeviceOrientationLandscapeRight:
                    self.verticalConstrain.constant = -125;
                    break;
                    
                default:
                    break;
            }
        }
        else if (IS_IPHONE_6){
            UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
            switch (orientation) {
                case UIDeviceOrientationPortrait:
                case UIDeviceOrientationPortraitUpsideDown:
                    self.verticalConstrain.constant = -100;
                    break;
                case UIDeviceOrientationLandscapeLeft:
                case UIDeviceOrientationLandscapeRight:
                    self.verticalConstrain.constant = -100;
                    break;
                    
                default:
                    break;
            }
        }
        else if (IS_IPHONE_6P){
            UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
            switch (orientation) {
                case UIDeviceOrientationPortrait:
                case UIDeviceOrientationPortraitUpsideDown:
                    self.verticalConstrain.constant = -100;
                    break;
                case UIDeviceOrientationLandscapeLeft:
                case UIDeviceOrientationLandscapeRight:
                    self.verticalConstrain.constant = -100;
                    break;
                    
                default:
                    break;
            }
        }
        else if (IS_IPAD){
            UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
            switch (orientation) {
                case UIDeviceOrientationPortrait:
                case UIDeviceOrientationPortraitUpsideDown:
                    self.verticalConstrain.constant = -100;
                    break;
                case UIDeviceOrientationLandscapeLeft:
                case UIDeviceOrientationLandscapeRight:
                    self.verticalConstrain.constant = -150;
                    break;
                    
                default:
                    break;
            }
        }
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    }];
}

@end
