//
//  AppConfig.h
//  DemoCoop
//
//  Created by Pankaj Verma on 16/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GDataXMLNode.h"
//#import "GDataXMLElement-Extras.h"
@protocol myProto
@optional
-(void)sendData:(NSDictionary *)dictionary;
-(void)getNewsData:( GDataXMLElement *)newsArray;
@end

@protocol WeatherProtocol
@optional
-(void)getWeatherData:(NSDictionary *)dictionary;
@end

@interface AppConfig : NSObject
@property (nonatomic, weak) id<myProto>  delegate;
@property (nonatomic, weak) id<WeatherProtocol>  weatherDelegate;
+ (AppConfig *)sharedInstance;
-(id) lookupConfigByKey:(NSString *)key;
- (NSDictionary *) getConfigData;
-(void)downloadFromURL:(NSURL *)url;
-(void)getFromURL:(NSURL *)url withParameters :(NSDictionary *)param;
@end
