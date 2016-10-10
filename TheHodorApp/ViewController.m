//
//  ViewController.m
//  TheHodorApp
//
//  Created by Abbin Varghese on 30/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "ViewController.h"
#import "AlertController.h"
#import "HighScoreViewController.h"

@import Firebase;

NSString *const scoreKey = @"userScore";
NSString *const nameKey = @"userName";
NSString *const idKey = @"userId";

@interface ViewController ()

@property (strong, nonatomic) NSTimer *stopWatchTimer; // Store the timer that fires after a certain time
@property (strong, nonatomic) NSDate *startDate; // Stores the date of the click on the start button *

@property (strong, nonatomic) IBOutlet UILabel *stopwatchLabel;
@property (weak, nonatomic) IBOutlet UILabel *hekp;

@property (assign, nonatomic) NSTimeInterval currentScore;

- (void)onStartPressed;
- (void)onStopPressed;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * namestring = [[NSUserDefaults standardUserDefaults] objectForKey:nameKey];
    if (namestring) {
        self.hekp.hidden = YES;
    }
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)showList:(id)sender {
    HighScoreViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"HighScoreViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    AlertController *vc = segue.destinationViewController;
    [vc withCompletionHandler:^(NSString *name) {
        
        NSString *userName = name;
        
        if (userName == nil) {
            userName = @"Anonymous";
        }
        
        [[NSUserDefaults standardUserDefaults] setDouble:_currentScore forKey:scoreKey];
        [[NSUserDefaults standardUserDefaults] setObject:userName forKey:nameKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        FIRDatabaseReference *ref = [[FIRDatabase database] reference];
        
        NSLocale *locale = [NSLocale currentLocale];
        NSString *countryCode = [locale objectForKey: NSLocaleCountryCode];
        NSString *country = [locale displayNameForKey: NSLocaleCountryCode value: countryCode];
        
        NSString *key = [FIRAuth auth].currentUser.uid;
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithDouble:_currentScore] forKey:scoreKey];
        [dict setObject:userName forKey:nameKey];
        [dict setObject:[FIRAuth auth].currentUser.uid forKey:idKey];
        [dict setObject:country forKey:@"userCountry"];
        
        NSDictionary *childUpdates = @{[@"/userScore/" stringByAppendingString:key]: dict};
        
        [ref updateChildValues:childUpdates];
        
        _currentScore = 0;

    }];
}

- (void)updateTimer
{
    // Create date from the elapsed time
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.startDate];
    _currentScore = timeInterval;
    
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss:SS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    self.stopwatchLabel.text = timeString;
    
}

- (void)onStartPressed{
    if (!self.hekp.hidden) {
        self.hekp.hidden = YES;
    }
    self.startDate = [NSDate date];
    
    // Create the stop watch timer that fires every 10 ms
    self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/100.0
                                                           target:self
                                                         selector:@selector(updateTimer)
                                                         userInfo:nil
                                                          repeats:YES];
}

- (void)onStopPressed{
    [self.stopWatchTimer invalidate];
    self.stopWatchTimer = nil;
    [self updateTimer];
    [self updateScore];

}

-(void)updateScore{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:nameKey]) {
        NSTimeInterval saveScore = [[NSUserDefaults standardUserDefaults] doubleForKey:scoreKey];
        
        if (_currentScore > saveScore) {
            [[NSUserDefaults standardUserDefaults] setDouble:_currentScore forKey:scoreKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            FIRDatabaseReference *ref = [[FIRDatabase database] reference];
            
            NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:nameKey];
            
            NSString *key = [FIRAuth auth].currentUser.uid;
            
            NSLocale *locale = [NSLocale currentLocale];
            NSString *countryCode = [locale objectForKey: NSLocaleCountryCode];
            NSString *country = [locale displayNameForKey: NSLocaleCountryCode value: countryCode];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setObject:[NSNumber numberWithDouble:_currentScore] forKey:scoreKey];
            [dict setObject:userName forKey:nameKey];
            [dict setObject:[FIRAuth auth].currentUser.uid forKey:idKey];
            [dict setObject:country forKey:@"userCountry"];
            
            NSDictionary *childUpdates = @{[@"/userScore/" stringByAppendingString:key]: dict};
            
            [ref updateChildValues:childUpdates];
            
        }
        _currentScore = 0;
    }
    else{
        [self performSegueWithIdentifier:@"AlertController" sender:self];
    }
    
}

- (IBAction)touchDown:(id)sender {
    [self onStartPressed];
}

- (IBAction)touchUpInside:(id)sender {
    [self onStopPressed];
}

- (IBAction)touchUpOutSide:(id)sender {
    [self onStopPressed];
}

- (IBAction)touchCanceled:(id)sender {
    [self onStopPressed];
}

@end
