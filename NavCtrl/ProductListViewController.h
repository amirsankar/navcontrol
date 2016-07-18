//
//  ProductListViewController.h
//  NavCtrl
//
//  Created by amir sankar on 7/8/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductViewController.h"
#import "Webview.h"
#import "DAO.h"
#import "AddNewProduct.h"
#import "Company.h"
#import "DAO.h"

@interface ProductListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) Company *company;
@property (nonatomic, retain) DAO *sharedManager;



@end
