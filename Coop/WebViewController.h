//
//  WebViewController.h
//  AdServerDemo
//
//  Created by Pankaj Verma on 30/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIWebView *webDetailView;
@property NSString * theTitle;
@property  NSURLRequest *requestObject;

@end
