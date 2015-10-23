//
//  Weather+CoreDataProperties.h
//  Coop
//
//  Created by Pankaj Verma on 23/10/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Weather.h"

NS_ASSUME_NONNULL_BEGIN

@interface Weather (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *city;
@property (nullable, nonatomic, retain) NSString *icon;
@property (nullable, nonatomic, retain) NSString *temperature;

@end

NS_ASSUME_NONNULL_END
