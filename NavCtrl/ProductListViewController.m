//
//  ProductListViewController.m
//  NavCtrl
//
//  Created by amir sankar on 7/8/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "ProductListViewController.h"

@interface ProductListViewController ()

@end

@implementation ProductListViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sharedManager = [DAO sharedManager];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]init];
    addButton.action = @selector(openAddNewProduct);
    addButton.title = @"Add";
    addButton.target = self;
    self.navigationItem.rightBarButtonItem = addButton;
    self.tableView.allowsSelectionDuringEditing = YES;
}

-(void)openAddNewProduct
{
    AddNewProduct *vc =
    [[AddNewProduct alloc]
     initWithNibName:@"AddNewProduct" bundle:nil];
    vc.company = self.company;
    [self.navigationController
     pushViewController:vc
     animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    self.imageView.image = [UIImage imageNamed:self.company.companyImage];
    self.companyNameLabel.text = self.company.companyName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.company.productsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Product *currentProduct = [self.company.productsArray objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = currentProduct.productName;
    cell.imageView.image = [UIImage imageNamed:currentProduct.productImage];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Webview *detailViewController = [[Webview alloc] initWithNibName:@"Webview" bundle:nil];
    detailViewController.currentProduct = [self.company.productsArray objectAtIndex:[indexPath row]];
    detailViewController.currentCompany = self.company;
    detailViewController.myProductsURL = [[self.company.productsArray objectAtIndex:[indexPath row] ] productURL];
    
    if (self.tableView.editing == YES) {
        AddNewProduct *editProduct =
        [[AddNewProduct alloc]
         initWithNibName:@"AddNewProduct" bundle:nil];
        editProduct.productToEdit = [self.company.productsArray objectAtIndex:[indexPath row]];
        [self.navigationController
         pushViewController:editProduct
         animated:YES];
        
    } else {
        
        [self.navigationController pushViewController:detailViewController animated:YES];
        
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Product *product = [self.company.productsArray objectAtIndex:indexPath.row];
        [self.sharedManager deleteProduct:product inCompany:self.company];
        [product release];
        [tableView reloadData];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.company.productsArray insertObject: [self.company.productsArray objectAtIndex:sourceIndexPath.row] atIndex:destinationIndexPath.row];
    [self.company.productsArray removeObjectAtIndex:(sourceIndexPath.row + 1)];
}

- (void)dealloc {
    [_imageView release];
    [_tableView release];
    [_companyNameLabel release];
    [super dealloc];
}
@end
