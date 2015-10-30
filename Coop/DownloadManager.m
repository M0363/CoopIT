//
//  DownloadManager.m
//  Coop
//
//  Created by Pankaj Verma on 29/10/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import "DownloadManager.h"
//#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"
#import "GDataXMLNode.h"
#import "GDataXMLElement-Extras.h"

@implementation DownloadManager
+( DownloadManager *) sharedInstance{
    
    static dispatch_once_t shared_initialized;
    static  DownloadManager *shared_instance = nil;
    
    dispatch_once(&shared_initialized, ^ {
        shared_instance = [[DownloadManager alloc] init];
        
    });
    return shared_instance;
}


-(void)getFromURL:(NSURL *)url withParameters :(NSDictionary *)param{
    
    
    //  NSURL *url1 = [NSURL URLWithString:@"http://feeds.abcnews.com/abcnews/usheadlines"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        printf("successed\n");
        NSData *data = (NSData *)responseObject;
        GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data                                                       options:0 error:nil];
        GDataXMLElement *channel = [[doc.rootElement elementsForName:@"channel"] lastObject];
        [[self delegate] getNewsData:channel];
    }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         [[self delegate] ErrorNewsData];
                                         printf("something went wrong\n");
                                     }];
    [operation start];
}


- (void)getWeatherAtPlace:(NSString *)place fromUrl:(NSURL*)url withParameters:(NSDictionary *)param
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithBaseURL:url];
    
    //    parameters[@"num_of_days"] = @(number);
    //    parameters[@"q"] = [NSString stringWithFormat:@"%f,%f",-33.7969235,150.9224326];
    //    parameters[@"format"] = @"json";
    //    parameters[@"key"] = WorldWeatherOnlineAPIKey;
    parameters[@"client_id"] = @"sAsnNlP1JIqpBmTaXUvhH";
    parameters[@"client_secret"] = @"63MEPK55Nqvm7ez1g9FNvxP1ySLn6NouuknwtevJ";
    
    [manager GET:place parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        if ([self.weatherDelegate respondsToSelector:@selector(updateWeather:)]) {
            
            [self.weatherDelegate updateWeather:responseObject];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([self.weatherDelegate respondsToSelector:@selector(errorWhileUpdating:)]) {
            [self.weatherDelegate updateWeather:error];
        }
    }];
}

@end
