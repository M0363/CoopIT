//
//  AppConfig.m
//  DemoCoop
//
//  Created by Pankaj Verma on 16/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import "AppConfig.h"
#import "UIImageView+AFNetworking.h"
#import "AFNetworking.h"
#import "GlobalVariables.h"
//#import "RSSItem.h"
//#import "RSSParser.h"
#import "GDataXMLNode.h"
#import "GDataXMLElement-Extras.h"
@implementation AppConfig{
NSDictionary *newsDict;
    NSArray *newsArray;
}

+( AppConfig *) sharedInstance{

static dispatch_once_t shared_initialized;
static  AppConfig *shared_instance = nil;

dispatch_once(&shared_initialized, ^ {
    shared_instance = [[AppConfig alloc] init];

});
return shared_instance;
}
-(NSDictionary *)getConfigData{
    NSString* path  = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"json"];
    
    
    NSString* jsonString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    
    NSData* jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *jsonError;
    id Keys = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&jsonError];
    
//    
//    for (int i=0; i<[Keys count]; i++) {
//        NSDictionary *arrayResult = [Keys objectAtIndex:i];
//        
//        [nameArray addObject:[arrayResult objectForKey:@"Name"]];
//        [LongitudeArray addObject:[arrayResult objectForKey:@"Longitude"]];
//        [LatitudeArray addObject:[arrayResult objectForKey:@"Latitude"]];
//        
//        
//        distanceArray = [NSArray arrayWithObjects:@"2.5km",@"1.5km",@"2.0km",@"1.0km",nil];
//        descriptionArray = [NSArray arrayWithObjects:@"Shopping Mall",@"Shopping Mall",@"Shopping Mall",@"Shopping Mall",nil];
//        storeImageArray = [NSArray arrayWithObjects:@"store1.png",@"store2.png",@"store3.png",@"store4.png",nil];
//        NSLog(@"name=%@",[arrayResult objectForKey:@"Name"]);
//        NSLog(@"Longitude=%@",[arrayResult objectForKey:@"Longitude"]);
//        NSLog(@"Latitude=%@",[arrayResult objectForKey:@"Latitude"]);
    return Keys;
}
-(id) lookupConfigByKey:(NSString *)key{
        NSDictionary *result = [self getConfigData];
        return [result objectForKey:key];
}

-(void)downloadFromURL:(NSURL *)url{


    NSURLRequest *request = [NSURLRequest requestWithURL:url];
   
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
         newsDict = (NSDictionary *)responseObject;
//        self.title = @"JSON Retrieved";
//        [self.tableView reloadData];
        [self.delegate sendData : newsDict];
        [self.weatherDelegate getWeatherData: newsDict];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                   otherButtonTitles:nil];
        [alertView show];
    }];
 
    [operation start];
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
//    NSData *data = [NSData dataWithContentsOfURL:url1];
//    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data
//                                                           options:0 error:&error];
//    if (doc == nil) {
//        NSLog(@"Failed to parse %@", url1);
//    } else {
//        printf("successed\n");
//   
//        GDataXMLElement *channel = [[doc.rootElement elementsForName:@"channel"] lastObject];
//    GDataXMLElement *item = [[channel elementsForName:@"item"] lastObject];
//    GDataXMLElement *media = [[item elementsForName:@"media:thumbnail"] lastObject];
//    NSString *url = [[media attributeForName:@"url"] stringValue];
//        NSString *title = [[[item elementsForName:@"title"] lastObject] stringValue];
//        NSString *link = [[[item elementsForName:@"link"] lastObject] stringValue];
//        NSString *description = [[[item elementsForName:@"description"] lastObject] stringValue];
        
        
//    if (error) {
//        NSLog(@"XML Parsing error is %@", [error localizedDescription]);
////        return NO;
//    }
   // [[self delegate] getNewsData:channel];

//    //__weak WTTableViewController *weakSelf = self;
//    [RSSParser parseRSSFeedForRequest:req success:^(NSArray *feedItems) {
//      //  [self setTitle:@"Blog"];
//        //        NSArray *rssItem0 = feedItems[0];
//        //         NSArray *rssItem1 = feedItems[1];
//        //you get an array of RSSItem
//       // [self setDataSource:feedItems];
//        printf("succeed!\n");
//      //  [weakSelf.tableView reloadData];
//        newsArray = feedItems;
//        //self.delegate getNewsData: newsArray];
//         [self.delegate getNewsData:newsArray];
//     
//    } failure:^(NSError *error) {
//        
//        //something went wrong
//        printf("something went wrong\n");
//    }];
//
  

@end
