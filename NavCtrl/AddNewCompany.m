//
//  AddNewCompany.m
//  NavCtrl
//
//  Created by amir sankar on 5/19/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "AddNewCompany.h"
#import "DAO.h"

@interface AddNewCompany ()

@end

@implementation AddNewCompany

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if (self.addcompany != nil) {
        self.companyNameTextField.text = self.addcompany.companyName;
        self.companyImageTextField.text = self.addcompany.companyImage;
    }

    
    // Do any additional setup after loading the view from its nib.
    self.sharedManager = [DAO sharedManager];
}

- (void)didReceiveMemoryWarning
{

    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    [_companyNameTextField release];
    [_companyImageTextField release];
    [super dealloc];
}


- (IBAction)submitButton:(id)sender {
    
    if(self.addcompany == nil){
    
    NSMutableArray *productsArray = [[NSMutableArray alloc]init];
    
    Company *addcompany = [[Company alloc]initName:self.companyNameTextField.text andImage:self.companyImageTextField.text andProducts:productsArray];
    
    [self.sharedManager.companyList addObject:addcompany];
    
    } else {
        self.addcompany.companyName = self.companyNameTextField.text;
        self.addcompany.companyImage = self.companyImageTextField.text;
    }
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
