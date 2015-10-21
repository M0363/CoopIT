//
//  HomeViewController.m
//  Coop
//
//  Created by Pankaj Verma on 15/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import "HomeViewController.h"
#import "MFSideMenu.h"
#import "NewsViewController.h"
#import "HAMWeatherViewController.h"
#import "CropPricesViewController.h"
#import "TwitterChannelViewController.h"
#import "GlobalVariables.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIView *support_V;
@property (weak, nonatomic) IBOutlet UIView *home_V;
@property (weak, nonatomic) IBOutlet UIView *crop_V;
@property (weak, nonatomic) IBOutlet UIView *other_V;
@property (weak, nonatomic) IBOutlet UIView *twitter_V;
@property (weak, nonatomic) IBOutlet UIView *news_V;
@property (weak, nonatomic) IBOutlet UIView *weather_V;
@property (weak, nonatomic) IBOutlet UIView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *homeIcon;
@property (weak, nonatomic) IBOutlet UIImageView *newsIcon;
@property (weak, nonatomic) IBOutlet UIImageView *ewatherIcon;
@property (weak, nonatomic) IBOutlet UIImageView *cropIcon;
@property (weak, nonatomic) IBOutlet UIImageView *twitterIcon;
@property (weak, nonatomic) IBOutlet UIImageView *otherIcon;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self designIcons];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = self.bgColor;
    _scrollView.backgroundColor = self.bgColor;
    _support_V.backgroundColor =                                             self.bgColor ;
    _home_V.backgroundColor = [UIColor purpleColor];
    _crop_V.backgroundColor = [UIColor greenColor];
    _other_V.backgroundColor = [UIColor orangeColor];
    _twitter_V.backgroundColor = [UIColor magentaColor];
    _news_V.backgroundColor = [UIColor cyanColor];
    _weather_V.backgroundColor = [UIColor purpleColor];
    
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

-(void)designIcons{
     self.homeIcon.layer.cornerRadius = 30.0;
     self.newsIcon.layer.cornerRadius = 30.0;
     self.ewatherIcon.layer.cornerRadius = 30.0;
     self.cropIcon.layer.cornerRadius = 30.0;
     self.twitterIcon.layer.cornerRadius = 30.0;
     self.otherIcon.layer.cornerRadius = 30.0;
    _home_V.layer.cornerRadius = 30;
    _crop_V.layer.cornerRadius = 30;
    _other_V.layer.cornerRadius = 30;
    _twitter_V.layer.cornerRadius = 30;
    _news_V.layer.cornerRadius = 30;
    _weather_V.layer.cornerRadius = 30;
    
    
}
- (IBAction)homeButtonTapped:(id)sender {
}
- (IBAction)NewsButtonTapped:(id)sender {
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
        NewsViewController *newsViewController=[[NewsViewController alloc]initWithNibName:@"NewsViewController" bundle:nil];
        [self.navigationController pushViewController:newsViewController animated:YES];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:newsViewController];
        self.menuContainerViewController.centerViewController=navController;
        //[menuController1 setRootController:navController animated:YES];
       
        
        printf("Left closed\n");
        
        
    }];

}
- (IBAction)weatherButtonTapped:(id)sender {
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
        HAMWeatherViewController *hamWeather = [[HAMWeatherViewController alloc]initWithNibName:@"HAMWeatherViewController" bundle:nil];
        [self.navigationController pushViewController:hamWeather animated:YES];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:hamWeather];
        self.menuContainerViewController.centerViewController=navController;
        //[menuController1 setRootController:navController animated:YES];
       
        
    }];

}
- (IBAction)cropButtonTapped:(id)sender {
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
        CropPricesViewController *cropPrice = [[CropPricesViewController alloc]initWithNibName:@"CropPricesViewController" bundle:nil];
        [self.navigationController pushViewController:cropPrice animated:YES];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:cropPrice];
        self.menuContainerViewController.centerViewController=navController;
        //[menuController1 setRootController:navController animated:YES];
      
        printf("Left closed\n");
        
    }];

}
- (IBAction)twitterButtonTapped:(id)sender {
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
        TwitterChannelViewController *twitterChannel = [[TwitterChannelViewController alloc]initWithNibName:@"TwitterChannelViewController" bundle:nil];
        [self.navigationController pushViewController:twitterChannel animated:YES];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:twitterChannel];
        self.menuContainerViewController.centerViewController=navController;
        //[menuController1 setRootController:navController animated:YES];
        
        printf("Left closed\n");
        
    }];
}
- (IBAction)otherButtonTapped:(id)sender {
}

@end
