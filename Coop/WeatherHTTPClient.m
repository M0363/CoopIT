//
//  WeatherHTTPClient.m
//  Coop
//
//  Created by Pankaj Verma on 18/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//
#import "WeatherHTTPClient.h"

static NSString * const WorldWeatherOnlineAPIKey = @"bb08acc6b4531e200d12fe99a5479";

//static NSString * const WorldWeatherOnlineURLString = @"http://api.worldweatheronline.com/free/v2/";
static NSString * const WorldWeatherOnlineURLString1 = @"http://api.aerisapi.com/forecasts/";

@implementation WeatherHTTPClient

+ (WeatherHTTPClient *)sharedWeatherHTTPClient
{
    static WeatherHTTPClient *_sharedWeatherHTTPClient = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedWeatherHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:WorldWeatherOnlineURLString1]];
    });
    
    return _sharedWeatherHTTPClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}

- (void)updateWeatherAtLocation:(NSString *)location forNumberOfDays:(NSUInteger)number
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
//    parameters[@"num_of_days"] = @(number);
//    parameters[@"q"] = [NSString stringWithFormat:@"%f,%f",-33.7969235,150.9224326];
//    parameters[@"format"] = @"json";
//    parameters[@"key"] = WorldWeatherOnlineAPIKey;
     parameters[@"client_id"] = @"sAsnNlP1JIqpBmTaXUvhH";
     parameters[@"client_secret"] = @"63MEPK55Nqvm7ez1g9FNvxP1ySLn6NouuknwtevJ";
    
     [self GET:location parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.delegate respondsToSelector:@selector(weatherHTTPClient:didUpdateWithWeather:)]) {
            [self.delegate weatherHTTPClient:self didUpdateWithWeather:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([self.delegate respondsToSelector:@selector(weatherHTTPClient:didFailWithError:)]) {
            [self.delegate weatherHTTPClient:self didFailWithError:error];
        }
    }];
}

@end
