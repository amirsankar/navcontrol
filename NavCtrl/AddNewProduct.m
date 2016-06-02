//
//  AddNewProduct.m
//  NavCtrl
//
//  Created by amir sankar on 5/23/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "AddNewProduct.h"
#import "Webview.h"

@interface AddNewProduct ()

@end

@implementation AddNewProduct

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.addProduct != nil) {
        self.productNameTextField.text = self.addProduct.productName;
        self.productLogoTextField.text = self.addProduct.productImage;
        self.productUrlTextField.text = self.addProduct.productURL;
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
    if(self.addProduct == nil){
        
        Product *addProduct = [[Product alloc]initName:self.productNameTextField.text andURL:self.productUrlTextField.text andImage:self.productLogoTextField.text];
        [self.company.productsArray addObject:addProduct];
        
    } else {
        self.addProduct.productName = self.productNameTextField.text;
        self.addProduct.productImage = self.productLogoTextField.text;
        self.addProduct.productURL = self.productUrlTextField.text;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Webview *detailViewController = [[Webview alloc] initWithNibName:@"Webview" bundle:nil];
    detailViewController.myProductsURL = [[self.company.productsArray objectAtIndex:[indexPath row] ] productURL];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}
@end
