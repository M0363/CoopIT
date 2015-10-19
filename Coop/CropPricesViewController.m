//
//  CropPricesViewController.m
//  Coop
//
//  Created by Pankaj Verma on 10/09/15.
//  Copyright © 2015 Pankaj Verma. All rights reserved.
//

#import "CropPricesViewController.h"
#import "CropPricesTableViewCell.h"
//#import  "CropData.h"
#import "GlobalVariables.h"
@interface CropPricesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *cropPriceTable;

@end

@implementation CropPricesViewController{
    NSArray *cropData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width,[[UIScreen mainScreen] bounds].size.height);
    [self.cropPriceTable registerNib:[UINib nibWithNibName:@"CropPricesTableViewCell" bundle:nil]forCellReuseIdentifier:@"CROP_CELL"];
    cropData = [GlobalVariables getCROP];
   
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
            switch (section) {
                case 0: {
                    return 1;
                }
                case 1: {
                    return 3;                }
                default:
                    return 0;
            }

}
    
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

static NSString *CellIdentifier = @"CROP_CELL";
CropPricesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    switch (indexPath.section) {
        case 0: {
            
            cell.backgroundColor = [UIColor lightGrayColor];
            cell.crop_name.font = [UIFont systemFontOfSize:17];
            cell.crop_date.font = [UIFont systemFontOfSize:17];
            cell.crop_price.font = [UIFont systemFontOfSize:17];
            cell.crop_note.font = [UIFont systemFontOfSize:17];
            cell.crop_name.textColor = [UIColor cyanColor];
            cell.crop_date.textColor = [UIColor cyanColor];
            cell.crop_price.textColor = [UIColor cyanColor];
            cell.crop_note.textColor = [UIColor cyanColor];
            
            
            cell.crop_name.text = @"NAME";
            cell.crop_date.text = @"DATE";
            cell.crop_price.text = @"PRICE";
            cell.crop_note.text = @"NOTES";
            break;
        }
            
        case 1: {
  
            cell.crop_name.font = [UIFont systemFontOfSize:13];
            cell.crop_date.font = [UIFont systemFontOfSize:13];
            cell.crop_price.font = [UIFont systemFontOfSize:13];
            cell.crop_note.font = [UIFont systemFontOfSize:13];

            cell.crop_name.text = [cropData[indexPath.row] objectForKey:@"CROP_NAME"];
            cell.crop_date.text = [cropData[indexPath.row] objectForKey:@"CROP_DATE"];
            cell.crop_price.text = [cropData[indexPath.row] objectForKey:@"CROP_PRICE"];
            cell.crop_note.text = [cropData[indexPath.row] objectForKey:@"CROP_COMMENT"];
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
    // Navigation logic may go here. Create and push another view controller.
}

@end
