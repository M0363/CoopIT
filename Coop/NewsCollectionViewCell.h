//
//  NewsCollectionViewCell.h
//  Coop
//
//  Created by Pankaj Verma on 09/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *news_head;
@property (weak, nonatomic) IBOutlet UIImageView *news_image;
@property (weak, nonatomic) IBOutlet UILabel *news_article;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end
