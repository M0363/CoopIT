//
//  CropPricesTableViewCell.h
//  Coop
//
//  Created by Pankaj Verma on 10/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CropPricesTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *crop_name;
@property (weak, nonatomic) IBOutlet UILabel *crop_date;

@property (weak, nonatomic) IBOutlet UILabel *crop_price;
@property (weak, nonatomic) IBOutlet UILabel *crop_note;
@end
