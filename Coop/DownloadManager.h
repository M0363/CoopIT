//
//  DownloadManager.h
//  Coop
//
//  Created by Pankaj Verma on 29/10/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeatherHTTPClientDelegate.h" //protocol
#import "NewsDelegate.h" //protocol
@interface DownloadManager : NSObject
@property (nonatomic, weak) id<NewsDelegate>  delegate;
@property (nonatomic, weak) id<WeatherHTTPClientDelegate>  weatherDelegate;
+( DownloadManager *) sharedInstance;
-(void)getFromURL:(NSURL *)url withParameters :(NSDictionary *)param;
- (void)getWeatherAtPlace:(NSString *)place fromUrl:(NSURL*)url withParameters:(NSDictionary *)param;
@end
