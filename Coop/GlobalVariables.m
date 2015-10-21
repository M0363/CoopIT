//
//  GlobalVariables.m
//  DemoCoop
//
//  Created by Pankaj Verma on 16/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import "GlobalVariables.h"
#import "AppConfig.h"
@import UIKit;

//#define     HOME_BACKGROUND_COLOR        @""
//
//#define     NEWS_TITLE1        @"There’s more to the economy than equities"
//#define     NEWS_TITLE2        @"Fed Budget Balance Boosts Markets"
//#define     NEWS_ARTICLE1        @"Even though the stock market gets a lot of attention with its wild swings making, losing and partially regaining the fortunes of its investors, there’s more to the U.S. economy.  Whatever caused that to happen, Bob Young is reassuring about the U.S. economy overall"
//#define     NEWS_ARTICLE2        @"This is not a correlated market.  The dollar is down- and crude is down which is not normal but the 30 year bond is trading higher.  The Financials should always correlate with the US dollar such that if the dollar is lower then bonds should follow and vice-versa."
//#define     NEWS_IMAGE1        @"Image1"
//#define     NEWS_IMAGE2        @"Image2"
//#define     NEWS_URL1        @"http://brownfieldagnews.com/2015/09/14/theres-more-to-the-economy-than-equities/"
//#define     NEWS_URL2        @"http://www.farmersco-operative.com/news/story.php?id=10780049"
//
//#define     MENU_TITLE1        @"Home"
//#define     MENU_TITLE2        @"News Feed"
//#define     MENU_TITLE3         @"HAM Weather"
//#define     MENU_TITLE4        @"Crop Prices"
//#define     MENU_TITLE5       @" Twitter Channel"


@implementation GlobalVariables

+(NSArray *)getNEWS{
 NSArray *value = [[AppConfig sharedInstance] lookupConfigByKey:@"NEWS"];
    return value;
}
+(NSString *)getBASE_URL{
    NSString *value = [[AppConfig sharedInstance] lookupConfigByKey:@"BASE_URL"];
    return value;
}
+(NSString *)getTWITTER_URL{
    NSString *value = [[AppConfig sharedInstance] lookupConfigByKey:@"TWITTER_URL"];
    return value;
}
+(NSString*)getTWITTER_USER{
    NSString *value = [[AppConfig sharedInstance] lookupConfigByKey:@"TWITTER_USER"];
    return value;

}
+(NSArray *)getMENU{
    NSArray *value = [[AppConfig sharedInstance] lookupConfigByKey:@"MENU"];
    return value;
}
+(NSArray *)getCROP{
    NSArray *value = [[AppConfig sharedInstance] lookupConfigByKey:@"CROP"];
    return value;
}
+(NSArray *)getWEATHER{
    NSArray *value = [[AppConfig sharedInstance] lookupConfigByKey:@"WEATHER"];
    return value;
}
+(UIColor *)getBGCOLOR{
    NSString *color = [[AppConfig sharedInstance] lookupConfigByKey:@"BGCOLOR"];
    unsigned result = 0;
    NSScanner *scanner = [NSScanner scannerWithString:color];
    [scanner setScanLocation:0];
    [scanner scanHexInt:&result];
    return [UIColor colorWithRed:((float)((result & 0xFF0000) >> 16))/255.0 green:((float)((result & 0xFF00) >> 8))/255.0 blue:((float)(result & 0xFF))/255.0 alpha:1.0];

}
@end
