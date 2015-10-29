//
//  BaseViewController.m
//  Coop
//
//  Created by Pankaj Verma on 11/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import "BaseViewController.h"
#import "MFSideMenu.h"
#import "HomeViewController.h"
#import "GlobalVariables.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _bgColor = [GlobalVariables getBGCOLOR];


    UIImage *menuImg = [UIImage imageNamed:@"mobile_menu.png"];
    UIImage *homeImg = [UIImage imageNamed:@"homeBar"];
    UIImage *headImg = [UIImage imageNamed:@"crop"];
//    UIButton *menuButton = [[UIButton alloc]initWithFrame:CGRectMake(10,(self.navigationController.navigationBar.frame.size.height-menuImg.size.height)/2, menuImg.size.width, menuImg.size.height)];
//    [menuButton setImage:menuImg forState:UIControlStateNormal];
//    [menuButton addTarget:self action:@selector(openLeftMenu) forControlEvents:UIControlEventTouchUpInside];
//    
//   
//    UIButton *homeButton = [[UIButton alloc]initWithFrame:CGRectMake(self.navigationController.navigationBar.frame.size.width-homeImg.size.width-5,(self.navigationController.navigationBar.frame.size.height-homeImg.size.height)/2, homeImg.size.width, homeImg.size.height)];
//    [homeButton setImage:homeImg forState:UIControlStateNormal];
//    [homeButton addTarget:self action:@selector(openHomePage) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *menu=[[UIBarButtonItem alloc]initWithImage:menuImg style:UIBarButtonItemStylePlain target:self action:@selector(openLeftMenu)];
    UIBarButtonItem *add=[[UIBarButtonItem alloc]initWithImage:homeImg style:UIBarButtonItemStyleDone target:self action:@selector(openHomePage)];
    UIImageView *head_imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.navigationController.navigationBar.frame.size.width, self.navigationController.navigationBar.frame.size.height-10)];
    head_imgView.image = headImg;
    self.navigationController.navigationBar.tintColor = _bgColor;
    self.navigationController.navigationBar.backgroundColor = [UIColor blueColor];
    self.navigationItem.titleView = head_imgView;
    self.navigationItem.rightBarButtonItem = add;
    self.navigationItem.leftBarButtonItem = menu;
   // [self.navigationController.navigationBar addSubview:menuButton];
    //[self.navigationController.navigationBar addSubview:homeButton];
    
    
    

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
- (BOOL)shouldAutorotate {
    return YES;
}


-(void)openLeftMenu{
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{}];
    
}
-(void)openHomePage{
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
        HomeViewController *homeViewController=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
        [self.navigationController pushViewController:homeViewController animated:YES];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
        self.menuContainerViewController.centerViewController=navController;
        //[menuController1 setRootController:navController animated:YES];
       
        printf("Left closed\n");
        
        
    }];

}
- (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return networkStatus != NotReachable;
}
@end
