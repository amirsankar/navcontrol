//
//  ProductViewController.h
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "DAO.h"

@interface ProductViewController : UITableViewController
@property (nonatomic, retain) Company *company;
@property (nonatomic, retain) DAO *sharedManager;

@end
