//
//  NewsCollectionViewCell.m
//  Coop
//
//  Created by Pankaj Verma on 09/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import "NewsCollectionViewCell.h"

@implementation NewsCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.news_head.layer.cornerRadius = 10.0f;
    self.containerView.layer.cornerRadius = 10.0f;
    self.containerView.layer.borderWidth = 1.0f;
    self.containerView.layer.borderColor = [UIColor cyanColor].CGColor;

}

@end
