//
//  AddNewProduct.m
//  NavCtrl
//
//  Created by amir sankar on 5/23/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "AddNewProduct.h"
#import "Webview.h"
#import "DAO.h"

@interface AddNewProduct ()

@end

@implementation AddNewProduct

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.productToEdit != nil) {
        self.productNameTextField.text = self.productToEdit.productName;
        self.productLogoTextField.text = self.productToEdit.productImage;
        self.productUrlTextField.text = self.productToEdit.productURL;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_productNameTextField release];
    [_productLogoTextField release];
    [_productUrlTextField release];
    [super dealloc];
}
- (IBAction)submit:(id)sender
{
    if(self.productToEdit == nil){
        [[DAO sharedManager] addProduct:self.productNameTextField.text andURL:self.productUrlTextField.text andImage:self.productLogoTextField.text forCompany:self.company];
    } else {

       [[DAO sharedManager] editProduct:self.productToEdit inCompany:self.company newName:self.productNameTextField.text newImage:self.productLogoTextField.text newURL:self.productUrlTextField.text];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)deleteButton:(id)sender {
    [[DAO sharedManager]deleteProduct:self.productToEdit inCompany:self.company];
    [self.navigationController popToViewController:self.navigationController.viewControllers[1]animated: YES];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Webview *detailViewController = [[Webview alloc] initWithNibName:@"Webview" bundle:nil];
    detailViewController.myProductsURL = [[self.company.productsArray objectAtIndex:[indexPath row] ] productURL];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}
@end
