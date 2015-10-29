//
//  News+CoreDataProperties.h
//  Coop
//
//  Created by Pankaj Verma on 26/10/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "News.h"

NS_ASSUME_NONNULL_BEGIN

@interface News (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *article;
@property (nullable, nonatomic, retain) NSString *heading;
@property (nullable, nonatomic, retain) NSString *image;
@property (nullable, nonatomic, retain) NSString *link;

@end

NS_ASSUME_NONNULL_END
