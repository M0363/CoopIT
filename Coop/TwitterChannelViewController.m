//
//  TwitterChannelViewController.m
//  Coop
//
//  Created by Pankaj Verma on 10/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import "TwitterChannelViewController.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareDialog.h>
#import "GlobalVariables.h"
#import "AppDelegate.h"
#import "Tweet.h"

@interface TwitterChannelViewController ()

@property (strong, nonatomic) NSMutableArray *twitterData;
@property (strong, nonatomic) NSArray *fbData;
@property (weak, nonatomic) IBOutlet UITableView *twitterTable;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftSpace;
@property (weak, nonatomic) IBOutlet UIView *theView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topSpace;
@property (weak, nonatomic) IBOutlet UILabel *time;
@end

@implementation TwitterChannelViewController{
    NSInteger n;
    NSTimer* timer;
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _twitterData.count;
    //return _fbData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.twitterTable
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *tweet = _twitterData[[indexPath row]];
    cell.textLabel.text = tweet[@"text"];
    cell.textLabel.font = [UIFont systemFontOfSize:9];
    __weak UITableViewCell *weakCell = cell;
    NSDictionary *tempD = tweet[@"extended_entities"][@"media"][0];
    if (tempD.count > 0) {
        NSString *url = tempD[@"media_url"];
        NSURL * imgUrl = [NSURL URLWithString:url];
        NSURLRequest *request = [NSURLRequest requestWithURL:imgUrl];
        [cell.imageView setImageWithURLRequest:request
                              placeholderImage:[UIImage imageNamed:@"placeholder"]
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           
                                           weakCell.imageView.image = image;
                                           [weakCell setNeedsLayout];
                                           
                                       } failure:nil];

    }
    
   
  //  cell.imageView.image = tweet[@"media_url"];
//    NSDictionary *fbPost = _twitterData[[indexPath row]];
//    cell.textLabel.text = fbPost[@"text"];
    return cell;
}


-(void)showTweets:(NSTimer *)timer{

     if (self.twitterData.count > 0) {
         printf("timer = %ld\n",n);
         NSDictionary *tweet = self.twitterData[n++%_twitterData.count];
         void (^animateChangeWidth1)() = ^(){
             CGRect frame = _textLabel.frame;
             frame.size = CGSizeMake(frame.size.width, frame.size.height-250);
             _photo.alpha = 0;
             _time.alpha = 0;
             _textLabel.frame = frame;
         };

         void (^animateChangeWidth)() = ^(){
             _leftSpace.constant = 8;
             _photo.alpha = 1.0;
             _time.alpha = 1.0;
             _photo.image = nil;
             if ([tweet valueForKey:@"media"] ) {
                 _leftSpace.constant = 67;
                 NSString *url = [tweet valueForKey:@"media"];
                 NSURL * imgUrl = [NSURL URLWithString:url];
                 NSURLRequest *request = [NSURLRequest requestWithURL:imgUrl];
                 [_photo setImageWithURLRequest:request
                          placeholderImage:[UIImage imageNamed:@"placeholder"]
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       _photo.image = image;
                                   } failure:nil];
            
             }
             else printf("no media available\n");
        

             _time.text = [tweet valueForKey:@"time"];
             _textLabel.text = [tweet valueForKey:@"tweets"];
             CGRect frame = _textLabel.frame;
             frame.size = CGSizeMake(frame.size.width, frame.size.height+250);//mycell.intrinsicContentSize;
             _textLabel.frame = frame;
         };
         [UIView transitionWithView:_textLabel duration:2.0f options:UIViewAnimationOptionCurveEaseInOut   animations:animateChangeWidth1 completion:
     
     ^(BOOL finished) {
         [UIView transitionWithView:_textLabel duration:2.0f options:UIViewAnimationOptionCurveEaseInOut   animations:animateChangeWidth completion:nil];
         
                             }];
    

    
   //    [UIView animateWithDuration:1.0
//                          delay:1.0
//                            options: UIViewAnimationCurveEaseIn
//                     animations:^{
//                         _text.alpha = 0.5;
//                         _text.text = tweet[@"text"];
//       NSDictionary *tempD = tweet[@"extended_entities"][@"media"][0];
//     _leftSpace.constant = 8;
//    _photo.image = nil;
//    if (tempD.count > 0) {
//        _leftSpace.constant = 67;
//        _topSpace.constant = 0;
//        NSString *url = tempD[@"media_url"];
//        NSURL * imgUrl = [NSURL URLWithString:url];
//        NSURLRequest *request = [NSURLRequest requestWithURL:imgUrl];
//        [_photo setImageWithURLRequest:request
//                              placeholderImage:[UIImage imageNamed:@"placeholder"]
//                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//                                           
//                                           _photo.image = image;
//                                         
//                                       } failure:nil];
//    }
//                     }
//completion:^(BOOL finished)
//                              {
//                                   _text.alpha = 1.0;
//                                  _topSpace.constant = 64;
//                                 NSLog(@"Completed");
//                     
//         }];
    
    
//    UIView* view = [self.view viewWithTag:100];
//    [UIView animateWithDuration:0.5
//                          delay:0.1
//                        options: UIViewAnimationCurveEaseOut
//                     animations:^
//     {
//         CGRect frame = view.frame;
//         frame.origin.y = 0;
//         frame.origin.x = (-100);
//         view.frame = frame;
//     }
//                     completion:^(BOOL finished)
//     {
//         NSLog(@"Completed");
//         
//     }];
     }
}
-(void)tapForTwitter:(UITapGestureRecognizer *)tap{
    NSString *urlString = [GlobalVariables getTWITTER_URL];

[[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}
-(void)designTheView{
    self.theView.layer.cornerRadius = 10.0f;
    self.theView.layer.borderWidth = 1.0f;
    self.theView.layer.borderColor = [UIColor cyanColor].CGColor;
    self.theView.backgroundColor = [UIColor whiteColor];
}
-(void)designPhoto{
    self.photo.layer.cornerRadius = 25.5f;
   

}
-(void)viewDidDisappear:(BOOL)animated{
    [timer invalidate];
    printf("time stopped. \n");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    n = 0;
    self.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height);
 
    [self designTheView];
    [self designPhoto];
    
    // Load old tweets
    //Retriving data from the database
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    NSManagedObjectContext *context = delegate.managedObjectContext;
//    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Tweet"];
//    NSMutableArray * result =  [[context executeFetchRequest:request error:NULL] mutableCopy];
//    
//    if (result.count > 0) {
//        self.twitterData = result;
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//            [self showTweets:nil];
//            NSTimer *t = [NSTimer scheduledTimerWithTimeInterval:10.0
//                                                          target:self
//                                                        selector:@selector(showTweets:)
//                                                        userInfo:nil
//                                                         repeats:YES];
//            NSRunLoop *runner = [NSRunLoop currentRunLoop];
//            [runner addTimer:t forMode: NSDefaultRunLoopMode];
//            
//            
//        });

   // }
//    else
//        printf("couldn't fetch request");

    timer =  [NSTimer scheduledTimerWithTimeInterval:5.0
                                              target:self
                                            selector:@selector(showTweets:)
                                            userInfo:nil
                                             repeats:YES];

    UITapGestureRecognizer *tapForTwitter =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapForTwitter:)];
    [self.theView addGestureRecognizer:tapForTwitter];
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account
                                  accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [account requestAccessToAccountsWithType:accountType
                                     options:nil completion:^(BOOL granted, NSError *error)
     {
         if (granted == YES)
         {
             NSArray *arrayOfAccounts = [account
                                         accountsWithAccountType:accountType];
             
             if ([arrayOfAccounts count] > 0)
             {
                 ACAccount *twitterAccount =
                 [arrayOfAccounts lastObject];
                 
                 NSURL *requestURL = [NSURL URLWithString:
                                      @"https://api.twitter.com/1.1/statuses/user_timeline.json"];
                 
                   NSString *urlString = [GlobalVariables getTWITTER_USER];
                 NSDictionary *parameters =
                 @{@"screen_name" : urlString,
                   @"include_rts" : @"0",
                   @"trim_user" : @"1",
                   @"count" : @"20"};
                 
                 SLRequest *postRequest = [SLRequest
                                           requestForServiceType:SLServiceTypeTwitter
                                           requestMethod:SLRequestMethodGET
                                           URL:requestURL parameters:parameters];
                 
                 postRequest.account = twitterAccount;
                 
                 [postRequest performRequestWithHandler:
                  ^(NSData *responseData, NSHTTPURLResponse
                    *urlResponse, NSError *error)
                  {
                      if (error) {
                          NSLog(@"Error ! :%@",error.localizedDescription);
                          AppDelegate *delegate = [UIApplication sharedApplication].delegate;
                          NSManagedObjectContext *contextR = delegate.managedObjectContext;
                          NSFetchRequest *requestR = [[NSFetchRequest alloc]initWithEntityName:@"Tweet"];
                          NSMutableArray * result =  [[contextR executeFetchRequest:requestR error:NULL] mutableCopy];
                          
                          if (result.count > 0) {
                              self.twitterData = result;
                          }
                          else
                              printf("couldn't fetch request");
                          dispatch_async(dispatch_get_main_queue(), ^{
                              [self showTweets:nil];
                                                    NSRunLoop *runner = [NSRunLoop currentRunLoop];
                          [runner addTimer:timer forMode: NSDefaultRunLoopMode];
                          
                          });
                      
                      

                        }
                        else{
                            NSArray *tweets = [NSJSONSerialization
                                         JSONObjectWithData:responseData
                                         options:NSJSONReadingMutableLeaves
                                         error:&error];
                      
                            AppDelegate *delegate = [UIApplication sharedApplication].delegate;
                            NSManagedObjectContext *context = delegate.managedObjectContext;
                            NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Tweet"];
                             NSError *err= nil;
                            
                             // delete old tweets since network is available
                      
                            if (SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(@"8.4")) {
                                printf("Device has Lower iOS version\n");
                                [request setIncludesPropertyValues:NO];
                                NSArray *fetchedObjects = [context executeFetchRequest:request error:&err];
                                for (NSManagedObject *object in fetchedObjects)
                                    [context deleteObject:object];
                            }
                            if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")) {
                                printf("Device has updutaded iOS version\n");
                                NSBatchDeleteRequest *delete = [[NSBatchDeleteRequest alloc] initWithFetchRequest:request];
                                if ([context executeRequest:delete error:&err]) printf("Error :%s",[[err localizedDescription] UTF8String]);
                            }

                            
                            [context lock];
                            if (![context save:&err])  printf("could not save/delete .");
                            [context unlock];

                            
                            //    Saving data to the database
                                
                               
                 
                            NSEntityDescription *description = [NSEntityDescription entityForName:@"Tweet" inManagedObjectContext:context];

                           
                                for ( NSDictionary *item in tweets) {
                                     NSManagedObject *obj = [[NSManagedObject alloc]initWithEntity:description insertIntoManagedObjectContext:context];
                                   NSString *mediaUrl = item[@"extended_entities"][@"media"][0][@"media_url"];
                                    NSString *tweetText = item[@"text"];
                                    NSString *tweetTime = item[@"created_at"];
                                    [obj setValue:tweetText forKey:@"tweets"];
                                    [obj setValue:tweetTime forKey:@"time"];
                                    [obj setValue:mediaUrl forKey:@"media"];
                                   // printf("%s %s %s\n",[tweetText UTF8String],[tweetTime UTF8String],[mediaUrl UTF8String]);
                                                                   }
                            
                            [context lock];
                            if (![context save:&err])  printf("could not save/delete .");
                            [context unlock];

                            //Retriving tweets from the database
                         
                            
                                NSMutableArray * result =  [[context executeFetchRequest:request error:NULL] mutableCopy];
                                
                                if (result.count > 0) {
                                    self.twitterData = result;
                                }
                                else
                                    printf("couldn't fetch request");
                            
                                // start timer
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [self showTweets:nil];
                                    NSRunLoop *runner = [NSRunLoop currentRunLoop];
                                    [runner addTimer:timer forMode: NSDefaultRunLoopMode];
                                    
                               });

                                
                                
                              }
                      
                  }];
             }
         } else {
             // Handle failure to get account access
         }
     }];
}

- (IBAction)fbButtonClicked:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *fbSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [fbSheet setInitialText:@" Commenting from my own app ! :P"];
        [fbSheet addURL:[NSURL URLWithString:@"https://twitter.com/Coopitalia"]];
        [fbSheet addImage:[UIImage imageNamed:@"Image1"]];
        [self presentViewController:fbSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a comment right now, make sure your device has an internet connection and you have at least one Facebook account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
}

- (IBAction)twitterButtonClicked:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:@"Tweeting from my own app! :)"];
        [tweetSheet addImage:[UIImage imageNamed:@"Image1"]];
        [tweetSheet addURL:[NSURL URLWithString:@"https://twitter.com/Coopitalia"]];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Sorry"
                                  message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
        [alertView show];
    }
    

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//    ACAccountStore *account = [[ACAccountStore alloc] init];
//    ACAccountType *accountType = [account
//                                  accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
//    NSDictionary *options = @{
//                              ACFacebookAppIdKey: @"716505388483428",
//                              ACFacebookPermissionsKey: @[@"publish_stream"],
//                              ACFacebookAudienceKey: ACFacebookAudienceEveryone
//                              };
//    [account requestAccessToAccountsWithType:accountType
//                                     options:options completion:^(BOOL granted, NSError *error)
//     {
//         if (granted == YES)
//         {
//             NSArray *arrayOfAccounts = [account
//                                         accountsWithAccountType:accountType];
//
//             if ([arrayOfAccounts count] > 0)
//             {
//                 ACAccount *fbAccount =
//                 [arrayOfAccounts lastObject];
//
//                 NSURL *requestURL = [NSURL URLWithString:
//                                      @"https://graph.facebook.com/me/feed"];
//
//                 NSDictionary *parameters =
//                 @{@"screen_name" : @"",
//                   @"include_rts" : @"0",
//                   @"trim_user" : @"1",
//                   @"count" : @"20"};
//
//                 SLRequest *postRequest = [SLRequest
//                                           requestForServiceType:SLServiceTypeFacebook
//                                           requestMethod:SLRequestMethodGET
//                                           URL:requestURL parameters:parameters];
//
//                 postRequest.account = fbAccount;
//
//                 [postRequest performRequestWithHandler:
//                  ^(NSData *responseData, NSHTTPURLResponse
//                    *urlResponse, NSError *error)
//                  {
//                      self.fbData = [NSJSONSerialization
//                                          JSONObjectWithData:responseData
//                                          options:NSJSONReadingMutableLeaves
//                                          error:&error];
//
//                      if (self.fbData.count != 0) {
//                          dispatch_async(dispatch_get_main_queue(), ^{
//                              [self.twitterTable reloadData];
//                          });
//                      }
//                  }];
//             }
//         } else {
//
//             UIAlertView *alertView = [[UIAlertView alloc]
//                                                                         initWithTitle:@"Sorry"
//                                                                         message:error.localizedDescription
//                                                                         delegate:self
//                                                                         cancelButtonTitle:@"OK"
//                                                                         otherButtonTitles:nil];
//                                               [alertView show];
//         }
//     }];
//

//
//    NSDictionary *options = @{
//                              ACFacebookAppIdKey: @"716505388483428",
//                              ACFacebookPermissionsKey: @[@"publish_stream"],
//                              ACFacebookAudienceKey: ACFacebookAudienceEveryone
//                              };
//
//
//    ACAccountStore *account = [[ACAccountStore alloc] init];
//    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
//    NSArray *arrayOfAccounts = [account  accountsWithAccountType:accountType];
//    ACAccount *facebookAccount = [arrayOfAccounts lastObject];
//    // NSString *acessToken = [NSString stringWithFormat:@"%@",facebookAccount.credential.oauthToken];
//    //  NSDictionary *parameters = @{@"access_token": acessToken};
//    NSURL *feedURL = [NSURL URLWithString:@"https://graph.facebook.com/me/friends"];
//    SLRequest *feedRequest = [SLRequest
//                              requestForServiceType:SLServiceTypeFacebook
//                              requestMethod:SLRequestMethodGET
//                              URL:feedURL
//                              parameters:options];
//    feedRequest.account = facebookAccount;
//    [feedRequest performRequestWithHandler:^(NSData *responseData,
//                                             NSHTTPURLResponse *urlResponse, NSError *error)
//     {
//         NSLog(@"%@",[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
//     }];
//

//    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
//    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
////    NSArray *arrayOfAccounts = [[[ACAccountStore alloc] init]  accountsWithAccountType:accountType];
////    ACAccount *facebookAccount = [arrayOfAccounts lastObject];
//    NSLog(@"0");
//    [accountStore requestAccessToAccountsWithType:accountType options:@{ACFacebookAppIdKey : @"716505388483428", ACFacebookPermissionsKey : @"publish_stream", ACFacebookAudienceKey : ACFacebookAudienceFriends} completion:^(BOOL granted, NSError *error) {
//        if(granted) {
//            NSLog(@"1");
//            NSArray *accountsArray = [accountStore accountsWithAccountType:accountType];
//            NSLog(@"2");
//            if ([accountsArray count] > 0) {
//                NSLog(@"3");
//                ACAccount *facebookAccount = [accountsArray objectAtIndex:0];
//                NSLog(@"4");
//                SLRequest *facebookRequest = [SLRequest requestForServiceType:SLServiceTypeFacebook
//                                                                requestMethod:SLRequestMethodPOST
//                                                                          URL:[NSURL URLWithString:@"https://graph.facebook.com/me/feed"]
//                                                                   parameters:nil];
//                NSLog(@"5");
//
//                [facebookRequest setAccount:facebookAccount];
//                NSLog(@"6");
//
//                [facebookRequest performRequestWithHandler:^(NSData* responseData, NSHTTPURLResponse* urlResponse, NSError* error) {
//                    NSLog(@"%@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
//                }];
//
//
//            }
//                   }
//        else printf("not granted\n");
//
//    }];
//

//    if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
//        // TODO: publish content.
//        NSLog(@"1");
//        UIImage *_image = [UIImage imageNamed:@"Coop3.jpg"];
//        NSMutableDictionary* params = [[NSMutableDictionary alloc] init];
//        [params setObject:@"Hi , This posting from my iOs app" forKey:@"message"];
//        [params setObject:UIImagePNGRepresentation(_image) forKey:@"picture"];
//
//        if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
//            [[[FBSDKGraphRequest alloc]
//              initWithGraphPath:@"me/photos"
//              parameters: params
//              HTTPMethod:@"POST"]
//             startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//                 if (!error) {
//                     NSLog(@"Post id:%@", result);
//                     UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Facebook"
//                                                                           message:@"Post successfullyqu"
//                                                                          delegate:nil
//                                                                 cancelButtonTitle:@"OK"
//                                                                 otherButtonTitles: nil];
//                     [myAlertView show];
//
//                 }
//                 else {
//                     NSLog(@"error :%@",error);
//                 }
//             }];
//        }
//
//    } else {
//        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
//        [loginManager logInWithPublishPermissions:@[@"publish_actions"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//            //TODO: process error or result.
//            NSLog(@"2");
//        }];
//    }



//    UIWebView *webDesc = [[UIWebView alloc]initWithFrame:CGRectMake(12, 50, 276, 228)];
//
//    NSString *embedHTML =@"";
//
//    webDesc.userInteractionEnabled = NO;
//    webDesc.opaque = NO;
//    webDesc.backgroundColor = [UIColor clearColor];
//    [webDesc loadHTMLString: embedHTML baseURL: nil];
//    [self.view addSubview:webDesc];



@end
