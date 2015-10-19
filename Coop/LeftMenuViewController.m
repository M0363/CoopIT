//
//  LeftMenuViewController.m
//  Coop
//
//  Created by Pankaj Verma on 09/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "LeftMenuTableViewCell.h"
//#import "MenuData.h"
#import "MFSideMenu.h"
#import "NewsViewController.h"
#import "HAMWeatherViewController.h"
#import "CropPricesViewController.h"
#import "TwitterChannelViewController.h"
#import "HomeViewController.h"
#import "GlobalVariables.h"
@interface LeftMenuViewController ()
@property (weak, nonatomic) IBOutlet UITableView *leftMenuTable;
@end

@implementation LeftMenuViewController{
NSArray *menuDataArray;
}
//NSArray *arr;
//NSArray *icon_arr;
//UIColor *bgColor;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
     self.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height);
    [self.leftMenuTable registerNib:[UINib nibWithNibName:@"LeftMenuTableViewCell" bundle:nil]forCellReuseIdentifier:@"LeftMenuCell"];
    menuDataArray = [GlobalVariables getMENU];
    //arr = [MenuData getInstance].menu_list;
    //icon_arr = [MenuData getInstance].icon_list;
  //  bgColor = [MenuData getInstance].bgColor;
     //self.leftMenuTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //self.leftMenuTable.backgroundView = nil;
    self.leftMenuTable.backgroundColor = self.bgColor;
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




-(NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return menuDataArray.count;//temperature.count;// according to your need
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * CellIdentifier = @"LeftMenuCell";
    
    LeftMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
 
    cell.menu.text = [menuDataArray[indexPath.row] objectForKey:@"MENU_TITLE"];
    cell.icon.image = [UIImage imageNamed:[menuDataArray[indexPath.row] objectForKey:@"MENU_IMAGE"]];
    cell.backgroundColor = nil;
    cell.backgroundColor = self.bgColor;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        return 100;
//    }
     return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    

    if (indexPath.row == 0) {
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
            HomeViewController *homeViewController=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
            [self.navigationController pushViewController:homeViewController animated:YES];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
            self.menuContainerViewController.centerViewController=navController;
            //[menuController1 setRootController:navController animated:YES];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            printf("Left closed\n");
            
            
        }];
    }

    if (indexPath.row == 1) {
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
            NewsViewController *newsViewController=[[NewsViewController alloc]initWithNibName:@"NewsViewController" bundle:nil];
            [self.navigationController pushViewController:newsViewController animated:YES];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:newsViewController];
            self.menuContainerViewController.centerViewController=navController;
            //[menuController1 setRootController:navController animated:YES];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            printf("Left closed\n");
            
            
        }];
    }
       else if (indexPath.row == 2){
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
            HAMWeatherViewController *hamWeather = [[HAMWeatherViewController alloc]initWithNibName:@"HAMWeatherViewController" bundle:nil];
            [self.navigationController pushViewController:hamWeather animated:YES];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:hamWeather];
            self.menuContainerViewController.centerViewController=navController;
            //[menuController1 setRootController:navController animated:YES];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            printf("Left closed\n");
            
        }];
    }
       else if (indexPath.row == 3){
           [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
               CropPricesViewController *cropPrice = [[CropPricesViewController alloc]initWithNibName:@"CropPricesViewController" bundle:nil];
               [self.navigationController pushViewController:cropPrice animated:YES];
               UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:cropPrice];
               self.menuContainerViewController.centerViewController=navController;
               //[menuController1 setRootController:navController animated:YES];
               [tableView deselectRowAtIndexPath:indexPath animated:YES];
               printf("Left closed\n");
               
           }];
       }

       else if (indexPath.row == 4){
           [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
               TwitterChannelViewController *twitterChannel = [[TwitterChannelViewController alloc]initWithNibName:@"TwitterChannelViewController" bundle:nil];
               [self.navigationController pushViewController:twitterChannel animated:YES];
               UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:twitterChannel];
               self.menuContainerViewController.centerViewController=navController;
               //[menuController1 setRootController:navController animated:YES];
               [tableView deselectRowAtIndexPath:indexPath animated:YES];
               printf("Left closed\n");
               
           }];
       }

        else
            printf("other\n");
    
             }
             


@end
