//
//  ViewController.m
//  TheHodorApp
//
//  Created by Abbin Varghese on 30/09/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSTimer *stopWatchTimer; // Store the timer that fires after a certain time
@property (strong, nonatomic) NSDate *startDate; // Stores the date of the click on the start button *

@property (strong, nonatomic) IBOutlet UILabel *stopwatchLabel;

@property (assign, nonatomic) NSUInteger score;

@property (assign, nonatomic) NSUInteger microSeconds;

- (void)onStartPressed;
- (void)onStopPressed;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTimer
{
    _microSeconds++;
    
    if (_microSeconds>=100) {
        _score++;
        _microSeconds = 0;
    }
    
    NSLog(@"%lu",(unsigned long)_score);
    
    // Create date from the elapsed time
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.startDate];
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
    _score = 0;
    _microSeconds = 0;
}

-(void)updateScore{
    
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
