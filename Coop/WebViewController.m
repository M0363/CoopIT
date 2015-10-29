//
//  WebViewController.m
//  AdServerDemo
//
//  Created by Pankaj Verma on 30/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import "WebViewController.h"
#import "AppDelegate.h"


@interface WebViewController ()<UIWebViewDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *crossButton;

@property (weak, nonatomic) IBOutlet UIButton *farwordButton;
@property (weak, nonatomic) IBOutlet UIButton *backwordButton;
@property (weak, nonatomic) IBOutlet UILabel *webTitle;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webTitle.text = _theTitle;
    _webDetailView.delegate = self;
  _crossButton.imageEdgeInsets = UIEdgeInsetsMake(-10, -10, -10, -10);
    NSURL *requestURL = [NSURL URLWithString:_requestUrl];
    
   

   //Retriving data from the database
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"NewsDetail"];
            NSPredicate *p=[NSPredicate predicateWithFormat:@"baseUrl == %@", _requestUrl];
           [request setPredicate:p];
    
    NSError *err = nil;
    NSMutableArray * result =  [[context executeFetchRequest:request error:&err] mutableCopy];
    NSLog(@"Error ! :%@",err.localizedDescription);
    if (result.count > 0) {
        NSString *htmlStr = [result[0] valueForKey:@"html"];
        
        if (htmlStr) [self.webDetailView loadHTMLString:htmlStr baseURL:requestURL];
        else {
            if (![super connected]) {
                printf("not connected\n");
                // not connected
                NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"networkFail" ofType:@"html"];
                NSString* htmlString = [NSString stringWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:nil];
                NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
                [self.webDetailView loadHTMLString:htmlString baseURL:baseURL];
            } else {
                printf(" connected\n");
                [self.webDetailView loadRequest:[NSURLRequest requestWithURL:requestURL]];
                    }

        }
    }
    else{ // could occer if application is closed before downloading
        printf("couldn't fetch request");
    [self.webDetailView loadRequest:[NSURLRequest requestWithURL:requestURL]];
    }
 }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)viewDidUnload {
    printf("back \n");
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (IBAction)dismissWebView:(id)sender {
   [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)backButtonPressed:(id)sender {
    _farwordButton.alpha = 1;
    if (_webDetailView.canGoBack) {
        [_webDetailView goBack];
    }
//else  _backwordButton.alpha = 0;
}
- (IBAction)farwordButtonPressed:(id)sender {
    _backwordButton.alpha = 1;
    if (_webDetailView.canGoForward) {
        [_webDetailView goForward];
    }
   // else _farwordButton.alpha = 0;
}
- (IBAction)homeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
//  
//        _backwordButton.alpha = 1;
//   
//    if (self.firstClick) {
//        self.firstClick = false;
//        _backwordButton.alpha = 0;
//        _farwordButton.alpha = 0;
//    }
//    printf("urlHit\n");
//   
//    return YES;
//}
#pragma mark - Web view delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    
}
#pragma mark - AlertView delegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
