//
//  HighTableViewCell.h
//  TheHodorApp
//
//  Created by Abbin Varghese on 01/10/16.
//  Copyright © 2016 ABN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellName;
@property (weak, nonatomic) IBOutlet UILabel *cellScore;
@property (weak, nonatomic) IBOutlet UILabel *cellCountry;

@end
