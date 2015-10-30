//
//  NewsDelegate.h
//  Coop
//
//  Created by Pankaj Verma on 29/10/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GDataXMLElement;
@protocol NewsDelegate <NSObject>
@optional
-(void)getNewsData:(GDataXMLElement *)newsArray;
-(void)ErrorNewsData;
@end
