//
//  ProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ProductViewController.h"
#import "Webview.h"
#import "DAO.h"
#import "AddNewProduct.h"
@interface ProductViewController ()

@end

@implementation ProductViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clearsSelectionOnViewWillAppear = NO;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]init];
    addButton.action = @selector(openAddNewProduct);
    addButton.title = @"Add Product";
    addButton.target = self;
    self.navigationItem.rightBarButtonItems= @[self.editButtonItem, addButton];
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
    detailViewController.myProductsURL = [[self.company.productsArray objectAtIndex:[indexPath row] ] productURL];
    
    if (self.tableView.editing == YES) {
        
        AddNewProduct *editProduct =
        [[AddNewProduct alloc]
         initWithNibName:@"AddNewProduct" bundle:nil];
        editProduct.addProduct = [self.company.productsArray objectAtIndex:[indexPath row]];
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
        [self.company.productsArray removeObjectAtIndex:indexPath.row];
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


@end
