//
//  HAMWeatherViewController.m
//  Coop
//
//  Created by Pankaj Verma on 10/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import "HAMWeatherViewController.h"
//#import "WeatherData.h"
#import "GlobalVariables.h"
//#import "AppConfig.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "MBProgressHUD.h"
@interface HAMWeatherViewController ()

@end

@implementation HAMWeatherViewController{
NSDictionary *weatherData ;
    MBProgressHUD *HUD;
    __weak IBOutlet UITableView *weatherTable;
    __weak IBOutlet UISearchBar *searchBar;
}
static NSString *place;
static WeatherHTTPClient *client;
//NSArray *locationImg;
//NSArray *location;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    searchBar.delegate = self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard:)];
    [weatherTable addGestureRecognizer:tap];
   // weatherData = [GlobalVariables getWEATHER];
   // NSString *str = @"http://www.raywenderlich.com/demos/weather_sample/weather.php?format=json";
//    NSString *baseString = [GlobalVariables getBASE_URL];
//    NSString *urlString = [GlobalVariables getURL];
//    NSString *theURLString = [NSString stringWithFormat:@"%@%@",baseString,urlString];
    //NSURL *url = [NSURL URLWithString:str];
    
   // [AppConfig sharedInstance].weatherDelegate = self;
    //[[AppConfig sharedInstance]downloadFromURL:url];
    client = [WeatherHTTPClient sharedWeatherHTTPClient];
    client.delegate = self;
    place = @"delhi,india";
    double your_latitiude_value = 8.391916;
    double your_longitude_value = 77.094315;
    
    CLLocation *myLocation = [[CLLocation alloc] initWithLatitude:your_latitiude_value longitude:your_longitude_value];
    
    [client updateWeatherAtLocation:place forNumberOfDays:5];

    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"Downloading...";
    [HUD show:YES];
//    temp = [WeatherData getInstance].getLocatinoTemp;
//    locationImg = [WeatherData getInstance].getLocationImage;
//    location = [WeatherData getInstance].getLocation;
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(!weatherData)
        return 0;
    
    switch (section) {
        case 0: {
            return 1;
        }
        case 1: {
//                NSDictionary *dataDict = [weatherData objectForKey:@"data"];
//    NSArray *weather_array = [dataDict objectForKey:@"weather"];
//    return weather_array.count;
            NSArray *responce = [weatherData objectForKey:@"response"];
            NSArray *periods = [responce[0] objectForKey:@"periods"];
            
            return periods.count-1;
        }
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CELL";
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    

//    NSDictionary *daysWeather = nil;
//    NSDictionary *dataDict = [weatherData objectForKey:@"data"];
//    NSArray *weather_current = [dataDict objectForKey:@"current_condition"];
    NSArray *responce = [weatherData objectForKey:@"response"];
    NSArray *periods = [responce[0] objectForKey:@"periods"];
   // NSArray *place = [responce objectForKey:@"place"];
   // NSArray *weather_upcoming = [dataDict objectForKey:@"weather"];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    switch (indexPath.section) {
        case 0: {
//            daysWeather = weather_current[0];
//            cell.textLabel.text = [daysWeather[@"weatherDesc"][0] objectForKey:@"value"];
//            cell.detailTextLabel.text = daysWeather[@"temp_C"];
//            NSURL *url = [NSURL URLWithString:[daysWeather[@"weatherIconUrl"][0] objectForKey:@"value"]];
//            NSURLRequest *request = [NSURLRequest requestWithURL:url];
//            UIImage *placeholderImage = [UIImage imageNamed:@"placeholder"];
//            
//            __weak UITableViewCell *weakCell = cell;
//            
//            [cell.imageView setImageWithURLRequest:request
//                                  placeholderImage:placeholderImage
//                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//                                               
//                                               weakCell.imageView.image = image;
//                                               [weakCell setNeedsLayout];
//                                               
//                                           } failure:nil];
//
//            break;
            cell.imageView.image = [UIImage imageNamed:periods[indexPath.row][@"icon"]];
            cell.textLabel.text = periods[indexPath.row][@"weather"];
            if (periods[indexPath.row][@"avgTempC"] == (id)[NSNull null])  {
                cell.detailTextLabel.text = @"null";
            }
            else  cell.detailTextLabel.text = [periods[indexPath.row][@"avgTempC"]stringValue];
                break;
                }
            
        case 1: {
//            daysWeather = weather_upcoming[indexPath.row];
//            cell.textLabel.text = daysWeather[@"maxtempC"];
//            cell.detailTextLabel.text = daysWeather[@"mintempC"];
            cell.imageView.image = [UIImage imageNamed:periods[indexPath.row][@"icon"]];
            cell.textLabel.text = periods[indexPath.row+1][@"weather"];
            if (periods[indexPath.row+1][@"avgTempC"] == (id)[NSNull null])  {
                cell.detailTextLabel.text = @"null";
            }
            else  cell.detailTextLabel.text = [periods[indexPath.row+1][@"avgTempC"]stringValue];
            

            break;
        }
            
        default:
            break;
    }

    return cell;

}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    printf("row selected\n");
    // Navigation logic may go here. Create and push another view controller.
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    NSDictionary *responce = [weatherData objectForKey:@"response"];
   // NSDictionary *placeData = [responce objectForKey:@"place"];

    switch (section)
    {
        case 0:
           sectionName = [NSString stringWithFormat:@"place : %@",place];//NSLocalizedString(@"Thursday(10/09/2015)", @"thursday");
            break;
        case 1:
            sectionName = @"Upcomming";//NSLocalizedString(@"Friday(11/09/2015)", @"friday");
            break;
            // ...
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}
#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // Last object contains the most recent location
    CLLocation *newLocation = [locations lastObject];
    
    // If the location is more than 5 minutes old, ignore it
    if([newLocation.timestamp timeIntervalSinceNow] > 300)
        return;
    
    [self.locationManager stopUpdatingLocation];
    
    WeatherHTTPClient *client = [WeatherHTTPClient sharedWeatherHTTPClient];
    client.delegate = self;
    [client updateWeatherAtLocation:place forNumberOfDays:5];
}

#pragma mark - WeatherHTTPClientDelegate

- (void)weatherHTTPClient:(WeatherHTTPClient *)client didUpdateWithWeather:(id)weather
{
    [HUD hide:YES];
    weatherData = weather;
    if ([[weatherData objectForKey:@"success"] boolValue]) {
       weatherData = weather;
        NSArray *responce = [weatherData objectForKey:@"response"];
        NSDictionary *profile = [responce[0] objectForKey:@"profile"];
        place = profile[@"tz"];
        //self.title = @"API Updated";
        [weatherTable reloadData];
        
    }else {
    
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[weatherData objectForKey:@"error"][@"code"]
                                                            message:[weatherData objectForKey:@"error"][@"description"]
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
}
}
- (void)weatherHTTPClient:(WeatherHTTPClient *)client didFailWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                        message:[NSString stringWithFormat:@"%@",error]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

//-(void)getWeatherData:(NSDictionary *)dictionary{
//    printf("Downloading Pankaj!\n");
//    [HUD hide:YES];
//    weatherData = dictionary;
//    [weatherTable reloadData];
//}


-(void)hideKeyboard:(UITapGestureRecognizer *)tap{
    [searchBar resignFirstResponder];
}
#pragma mark - SearchBarDelegates

-(void)searchBarCancelButtonClicked:(UISearchBar *)sBar{
    NSLog(@"Cancel");
}


-(void)searchBarSearchButtonClicked:(UISearchBar *)sBar{
    [sBar resignFirstResponder];
    place = sBar.text;
   NSString *placeEdited = [NSString stringWithFormat:@"%@,",sBar.text];
    NSLog(@"GO : %@", searchBar.text);
    [client updateWeatherAtLocation:placeEdited forNumberOfDays:5];
    [HUD show:YES];
}

-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    NSLog(@"Search string is -> %@",searchText);
}

@end
