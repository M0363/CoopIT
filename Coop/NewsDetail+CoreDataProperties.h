//
//  NewsDetail+CoreDataProperties.h
//  Coop
//
//  Created by Pankaj Verma on 26/10/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "NewsDetail.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsDetail (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *html;
@property (nullable, nonatomic, retain) NSString *baseUrl;

@end

NS_ASSUME_NONNULL_END
