//
//  AppConfig.h
//  DemoCoop
//
//  Created by Pankaj Verma on 16/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"

@interface AppConfig : NSObject

+ (AppConfig *)sharedInstance;
-(id) lookupConfigByKey:(NSString *)key;
- (NSDictionary *) getConfigData;


@end
