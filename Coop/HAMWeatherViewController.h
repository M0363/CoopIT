//
//  HAMWeatherViewController.h
//  Coop
//
//  Created by Pankaj Verma on 10/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "WeatherHTTPClient.h"
@interface HAMWeatherViewController : BaseViewController<UITableViewDataSource,UITabBarDelegate,CLLocationManagerDelegate,WeatherHTTPClientDelegate,UISearchBarDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@end
