//
//  NewsViewController.m
//  Coop
//
//  Created by Pankaj Verma on 09/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsCollectionViewCell.h"
#import  "SVWebViewController.h"
#import "MFSideMenu.h"
#import "GlobalVariables.h"
#import "AppConfig.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "UIKit+AFNetworking.h"
//#import "RSSParser.h"
//#import "RSSItem.h"
#import "GDataXMLNode.h"
#import "GDataXMLElement-Extras.h"
@interface NewsViewController ()<myProto>
@property (weak, nonatomic) IBOutlet UICollectionView *news_CollectionView;


@end

@implementation NewsViewController{
    MBProgressHUD *HUD;
    
}



static NSMutableArray *imageUrlStringArray ;
static NSMutableArray *titleArray ;
static NSMutableArray *linkStringArray ;
static NSMutableArray *descriptionArray ;

CGFloat itemWidth;
CGFloat scrollWidth_L;
CGFloat scrollWidth_P;
NSDictionary *dict;



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Home";
  imageUrlStringArray =  [[NSMutableArray alloc] init];
   titleArray =  [[NSMutableArray alloc] init];
    linkStringArray = [[NSMutableArray alloc] init];
    descriptionArray = [[NSMutableArray alloc] init];
    
    //dict = [GlobalVariables getNEWS];
     //NSString *str = @"http://appfeeds.grahamdigital.com/Top%20Stories.json";
        NSString *baseString = [GlobalVariables getBASE_URL];
       // NSString *urlString = [GlobalVariables getURL];
        //NSString *theURLString = [NSString stringWithFormat:@"%@%@",baseString,urlString];
        NSURL *url = [NSURL URLWithString:baseString];
        [AppConfig sharedInstance].delegate = self;
    [[AppConfig sharedInstance] getFromURL:url withParameters:nil];
      //  [[AppConfig sharedInstance]downloadFromURL:url];
   // [[AppConfig sharedInstance] getFromURL:url withParameters:nil];
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"Downloading...";
    [HUD show:YES];
    
    //
//    __block NSDictionary *weather ;
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    operation.responseSerializer = [AFJSONResponseSerializer serializer];
//    
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        dict = (NSDictionary *)responseObject;
//        //        self.title = @"JSON Retrieved";
//               [self.news_CollectionView reloadData];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
//                                                            message:[error localizedDescription]
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"Ok"
//                                                  otherButtonTitles:nil];
//        [alertView show];
//    }];
//    
//    [operation start];
    // Do any additional setup after loading the view from its nib.
     self.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height);
    self.news_CollectionView.delegate = self;
    self.news_CollectionView.dataSource = self;
    [self.news_CollectionView registerNib:[UINib nibWithNibName:@"NewsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CenterNewsCell"];
    
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
-(void)viewWillLayoutSubviews{
 itemWidth = self.view.bounds.size.width;
}

- (BOOL)shouldAutorotate {
    return YES;
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight || toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        //itemWidth = scrollWidth_L;
         itemWidth = self.view.bounds.size.width;
    }
    else {
        //itemWidth = scrollWidth_P;
         itemWidth = self.view.bounds.size.width;
    }
    [self.news_CollectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //return [[dict objectForKey:@"items"] count];
       return titleArray.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString * CellIdentifier = @"CenterNewsCell";
    
    NewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    

//    
//    if ([[dict[indexPath.row] objectForKey:@"NEWS_TITLE"] length] > 30) {
//        cell.news_head.font = [UIFont systemFontOfSize:16];
//    }
//    cell.news_image.image = [UIImage imageNamed:news_image_array[indexPath.row]];
//    cell.news_head.text = news_title_array[indexPath.row];
//    cell.news_article.text = news_article_array[indexPath.row];
    
//    NSArray *arr = [dict objectForKey:@"items"];
//    NSDictionary *dict_News = arr[indexPath.row];
//    if ([[dict_News objectForKey:@"title"] length] > 30) {
//         cell.news_head.font = [UIFont systemFontOfSize:16];
//    }
//  // cell.news_image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[dict_News objectForKey:@"thumbUrl"]]]];
//    cell.news_head.text = [dict_News objectForKey:@"title"];
////    cell.news_article.text = [dict_News objectForKey:@"content"];
//    cell.news_article.text = [dict_News objectForKey:@"title"];
//
//    NSURL *url = [NSURL URLWithString:[dict_News objectForKey:@"thumbUrl"]];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];
//    
//    __weak NewsCollectionViewCell *weakCell = cell;
//    
//    [cell.news_image setImageWithURLRequest:request
//                          placeholderImage:placeholderImage
//                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//                                       
//                                       weakCell.news_image.image = image;
//                                       [weakCell setNeedsLayout];
//                                       
//                                   } failure:nil];
   
    
    
    if ([titleArray[indexPath.row] length] > 30) {
                        cell.news_head.font = [UIFont systemFontOfSize:16];
                    }
    cell.news_head.text = titleArray[indexPath.row];
        cell.news_article.text = descriptionArray[indexPath.row];
        cell.news_article.textColor = [UIColor brownColor];
        cell.news_article.font = [UIFont systemFontOfSize:17];
    
   
    
    
    __weak NewsCollectionViewCell *weakCell = cell;
    NSURL * imgUrl = [NSURL URLWithString:imageUrlStringArray[indexPath.row]];
    NSURLRequest *request = [NSURLRequest requestWithURL:imgUrl];
        [cell.news_image setImageWithURLRequest:request
                              placeholderImage:[UIImage imageNamed:@"placeholder"]
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
    
                                           weakCell.news_image.image = image;
                                           [weakCell setNeedsLayout];
    
                                       } failure:nil];
    
//    for (GDataXMLElement *news in newsChannel){
//        for(GDataXMLElement *itemData in [news elementsForName:@"item"]){
//          GDataXMLElement   *mediaArray = [itemData elementsForName:@"media:thumbnail"];
//            imageUrl = [[mediaArray attributeForName:@"url"] stringValue];
//        }
////        timeZone = [NSNumber numberWithFloat:[[[cityItem attributeForName:@"TimeZone"] stringValue] floatValue]];
////        isDayLightSaving = [[[cityItem attributeForName:@"IsDaylightSavings"] stringValue] boolValue];
////        observesDaylightSavings = [[[cityItem attributeForName:@"ObservesDaylightSavings"] stringValue] boolValue];
//        
//        
//    }
//    
   // NSArray *mediaArray = [item elementsForName:@"media:thumbnail"];
    
    
//    NSArray *alertsArray = [alerts elementsForName:@"Alert"];
//    
//    RSSItem *item = [newsDataArray objectAtIndex:indexPath.row];
//    
//    if ([[item title] length] > 30) {
//                cell.news_head.font = [UIFont systemFontOfSize:16];
//            }
//   
//     cell.news_head.text = [item title];
//    cell.news_article.text = [item itemDescription];
//    cell.news_article.textColor = [UIColor brownColor];
//    cell.news_article.font = [UIFont systemFontOfSize:17];
//    NSURL *url = [NSURL URLWithString:[item imagesFromMedia][0]];
//    __weak NewsCollectionViewCell *weakCell = cell;
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [cell.news_image setImageWithURLRequest:request
//                               placeholderImage:[UIImage imageNamed:@"placeholder"]
//                                        success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//     
//                                            weakCell.news_image.image = image;
//                                            [weakCell setNeedsLayout];
//     
//                                        } failure:nil];
//
//    if ([[item imagesFromItemDescription] count]>0) {
//        [cell.news_image setImageWithURL:[NSURL URLWithString:[item.imagesFromItemDescription objectAtIndex:0]]
//                       placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//        
//    }
//    else cell.news_image.image = [UIImage imageNamed:@"placeholder.png"];
//    if ([[item imagesFromContent] count]>0) {
//        [cell.news_image setImageWithURL:[NSURL URLWithString:[item.imagesFromContent objectAtIndex:0]]
//                        placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//        
//    }
//    else printf("No Image available\n");
    return cell;
    


}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
//    static NewsCollectionViewCell* cell;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        
//        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CenterNewsCell" forIndexPath:indexPath];
//    });
//    
//    // size the cell for the current orientation.  assume's we're full screen width:
//    cell.frame = CGRectMake(0, 0, itemWidth, cell.frame.size.height );
//    
//    // perform a cell layout - this runs autolayout and also updates any preferredMaxLayoutWidths via layoutSubviews in our subclassed UILabels
//    [cell layoutIfNeeded];
//    
//    // finally calculate the required height:
//    CGSize s = [cell.contentView systemLayoutSizeFittingSize: UILayoutFittingCompressedSize];
    
  //  return CGSizeMake(itemWidth,500);
    
    
    
//    NSArray *arr = [dict objectForKey:@"items"];
//    NSDictionary *dict_News = arr[indexPath.row];
//
////    CGFloat articleSize = [self getSizeOfText:[dict_News objectForKey:@"content"]];
//    CGFloat articleSize = [self getSizeOfText:[dict_News objectForKey:@"title"]];

//     RSSItem *item = [newsDataArray objectAtIndex:indexPath.row];
//    CGFloat articleSize = [self getSizeOfText:[item itemDescription]];
    CGFloat articleSize = [self getSizeOfText:descriptionArray[indexPath.row]];
    return CGSizeMake(itemWidth, 353+articleSize);
    //return CGSizeMake(itemWidth, 343+100);

}
-(CGFloat)getSizeOfText:theText{

    CGSize constraint = CGSizeMake(itemWidth, MAXFLOAT);
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:17.0] forKey:NSFontAttributeName];
    CGRect frameOfText = [theText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
   
    return frameOfText.size.height;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    printf("item selected\n");
//    NSArray *arr = [dict objectForKey:@"items"];
//    NSDictionary *dict_News = arr[indexPath.row];
//    NSURL *url = [NSURL URLWithString:[dict_News objectForKey:@"url"]];
//     RSSItem *item = [newsDataArray objectAtIndex:indexPath.row];
//    
    NSURL *url = [NSURL URLWithString:linkStringArray[indexPath.row]];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
        UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [web setDelegate:self];
    [web loadRequest:requestObj];
    [self.view addSubview:web];

//   SVWebViewController * webCtrl = [[SVWebViewController alloc] initWithAddress:news_links_array[indexPath.row]];
//       [self.navigationController pushViewController:web animated:YES];
    
    
 }
-(void)sendData:(NSDictionary *)dictionary{
    printf("Downloading Pankaj!\n");
    //[HUD hide:YES];
    dict = dictionary;
[self.news_CollectionView reloadData];
}

-(void)getNewsData:(GDataXMLElement *)newsData{
    printf("in News\n");
    [HUD hide:YES];
      [self setTitle:@"Blog"];
    NSArray *itemArray = [newsData elementsForName:@"item"];
    for (GDataXMLElement *item  in itemArray) {
     GDataXMLElement *media = [[item elementsForName:@"media:thumbnail"] lastObject];
        [imageUrlStringArray addObject:[[media attributeForName:@"url"] stringValue]];
    [titleArray addObject: [[[item elementsForName:@"title"] lastObject] stringValue]];
    [linkStringArray addObject:[[[item elementsForName:@"link"] lastObject] stringValue]];
    [descriptionArray addObject:[[[item elementsForName:@"description"] lastObject] stringValue]];
    }
    [self.news_CollectionView reloadData];
}
@end
