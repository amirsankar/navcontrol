//
//  AddNewProduct.h
//  NavCtrl
//
//  Created by amir sankar on 5/23/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DAO.h"

@interface AddNewProduct : UIViewController
@property (retain, nonatomic) IBOutlet UITextField *productNameTextField;
@property (retain, nonatomic) IBOutlet UITextField *productLogoTextField;
@property (retain, nonatomic) IBOutlet UITextField *productUrlTextField;
@property (retain, nonatomic) Product *productToEdit;
@property (retain, nonatomic) Company *company;
- (IBAction)submit:(id)sender;
- (IBAction)deleteButton:(id)sender;


@end
