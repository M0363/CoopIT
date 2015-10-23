//
//  Tweet+CoreDataProperties.h
//  Coop
//
//  Created by Pankaj Verma on 23/10/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface Tweet (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *tweet;

@end

NS_ASSUME_NONNULL_END
