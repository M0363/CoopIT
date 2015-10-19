//
//  WeatherHTTPClient.h
//  Coop
//
//  Created by Pankaj Verma on 18/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import <CoreLocation/CoreLocation.h>

@protocol WeatherHTTPClientDelegate;

@interface WeatherHTTPClient : AFHTTPSessionManager
@property (nonatomic, weak) id<WeatherHTTPClientDelegate>delegate;

+ (WeatherHTTPClient *)sharedWeatherHTTPClient;
- (instancetype)initWithBaseURL:(NSURL *)url;
//- (void)updateWeatherAtLocation:(CLLocation *)location forNumberOfDays:(NSUInteger)number;
- (void)updateWeatherAtLocation:(NSString *)location forNumberOfDays:(NSUInteger)number;
@end
//@protocol HAMWeatherProtocol <NSObject>
//@optional
//-(void)weatherHTTPClient:(WeatherHTTPClient *)client
//
//@end
@protocol WeatherHTTPClientDelegate <NSObject>
@optional
-(void)weatherHTTPClient:(WeatherHTTPClient *)client didUpdateWithWeather:(id)weather;
-(void)weatherHTTPClient:(WeatherHTTPClient *)client didFailWithError:(NSError *)error;
@end
