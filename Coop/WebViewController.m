//
//  WebViewController.m
//  AdServerDemo
//
//  Created by Pankaj Verma on 30/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()<UIWebViewDelegate>


@property (weak, nonatomic) IBOutlet UIButton *farwordButton;
@property (weak, nonatomic) IBOutlet UIButton *backwordButton;
@property (weak, nonatomic) IBOutlet UILabel *webTitle;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webTitle.text = _theTitle;
    _webDetailView.delegate = self;
    
    // Do any additional setup after loading the view from its nib.
    [self.webDetailView loadRequest:self.requestObject];
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
@end
