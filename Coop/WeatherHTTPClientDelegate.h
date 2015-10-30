//
//  WeatherHTTPClientDelegate.h
//  Coop
//
//  Created by Pankaj Verma on 29/10/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WeatherHTTPClient;
@protocol WeatherHTTPClientDelegate <NSObject>
@optional
-(void)updateWeather:(id)weather;
-(void)errorWhileUpdating:(NSError *)error;
//-(void)weatherHTTPClient:(WeatherHTTPClient *)client didUpdateWithWeather:(id)weather;
//-(void)weatherHTTPClient:(WeatherHTTPClient *)client didFailWithError:(NSError *)error;
@end
