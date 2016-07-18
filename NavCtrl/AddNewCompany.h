//
//  AddNewCompany.h
//  NavCtrl
//
//  Created by amir sankar on 5/19/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"


@interface AddNewCompany : UIViewController
@property (retain, nonatomic) DAO *sharedManager;
@property (retain, nonatomic) Company *companyToEdit;
@property (retain, nonatomic) IBOutlet UITextField *companyImageTextField;
@property (retain, nonatomic) IBOutlet UITextField *companyNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *companyStockTextField;
- (IBAction)submitButton:(id)sender;
@end
