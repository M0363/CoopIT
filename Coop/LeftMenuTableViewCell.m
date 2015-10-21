//
//  LeftMenuTableViewCell.m
//  Coop
//
//  Created by Pankaj Verma on 09/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import "LeftMenuTableViewCell.h"

@implementation LeftMenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.icon.layer.cornerRadius = 20.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
