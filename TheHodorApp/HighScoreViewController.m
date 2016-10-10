//
//  HighScoreViewController.m
//  TheHodorApp
//
//  Created by Abbin Varghese on 01/10/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import "HighScoreViewController.h"
#import "HighTableViewCell.h"
#import "AppDelegate.h"

@import Firebase;

@interface HighScoreViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic, strong) AppDelegate *delegate;

@end

@implementation HighScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.table.estimatedRowHeight = 44;
    self.table.rowHeight = UITableViewAutomaticDimension;
    
    _delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _delegate.highScores.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HighTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HighTableViewCell"];
    NSDictionary *dict = [_delegate.highScores objectAtIndex:indexPath.row];
    cell.cellName.text = [dict objectForKey:@"userName"];
    
    NSTimeInterval theTimeInterval = [[dict objectForKey:@"userScore"] doubleValue];
    
    // Get the system calendar
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    
    // Create the NSDates
    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] initWithTimeInterval:theTimeInterval sinceDate:date1];
    
    // Get conversion to months, days, hours, minutes
    unsigned int unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *conversionInfo = [sysCalendar components:unitFlags fromDate:date1  toDate:date2  options:0];
    
    if ([conversionInfo hour]>0){
        cell.cellScore.text = [NSString stringWithFormat:@"%ld hrs %ld mins %ld sec",(long)[conversionInfo hour],(long)[conversionInfo minute],(long)[conversionInfo second]];
    }
    else{
        cell.cellScore.text = [NSString stringWithFormat:@"%ld mins %ld sec",(long)[conversionInfo minute],(long)[conversionInfo second]];
    }
    
    cell.cellCountry.text = [dict objectForKey:@"userCountry"];
    
    NSString * idnt = [dict objectForKey:@"userId"];
    
    if ([idnt isEqualToString:[FIRAuth auth].currentUser.uid]) {
        cell.cellName.textColor = [UIColor redColor];
    }else{
        cell.cellName.textColor = [UIColor blackColor];
    }
    
    return cell;
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
