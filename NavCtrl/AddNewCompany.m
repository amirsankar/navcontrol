//
//  AddNewCompany.m
//  NavCtrl
//
//  Created by amir sankar on 5/19/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "AddNewCompany.h"
#import "DAO.h"
#import "DAO.m"

@interface AddNewCompany ()

@end

@implementation AddNewCompany

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.companyToEdit != nil) {
        self.companyNameTextField.text = self.companyToEdit.companyName;
        self.companyImageTextField.text = self.companyToEdit.companyImage;
        self.companyStockTextField.text =  self.companyToEdit.stockSymbol;
    }
    self.sharedManager = [DAO sharedManager];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_companyNameTextField release];
    [_companyImageTextField release];
    [_companyStockTextField release];
    [super dealloc];
}

- (IBAction)submitButton:(id)sender
{
    if (self.companyToEdit == nil) {
        [[DAO sharedManager] addCompany:self.companyNameTextField.text withImage:self.companyImageTextField.text withStock:self.companyStockTextField.text];
    } else {
        [[DAO sharedManager] editCompany:self.companyToEdit newName:self.companyNameTextField.text withImage:self.companyImageTextField.text withStock:self.companyStockTextField.text];
        
        self.companyToEdit = nil;
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
