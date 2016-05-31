//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductViewController.h"
#import "DAO.h"
#import "AddNewCompany.h"
@interface CompanyViewController ()

@end

@implementation CompanyViewController

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
    self.sharedManager = [DAO sharedManager];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"Amir's Companies";
    
    self.tableView.allowsSelectionDuringEditing = YES;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]init];
    addButton.action = @selector(openAddNewCompany);
    addButton.title = @"Add Company";
    addButton.target = self;
    self.navigationItem.leftBarButtonItem = addButton;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

-(void)openAddNewCompany
{
    UIViewController *vc =
    [[AddNewCompany alloc]
     initWithNibName:@"AddNewCompany" bundle:nil];
    
    [self.navigationController
     pushViewController:vc
     animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.sharedManager.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [[self.sharedManager.companyList objectAtIndex:[indexPath row]] companyName];
    cell.imageView.image = [UIImage imageNamed:[[self.sharedManager.companyList objectAtIndex:[indexPath row]]companyImage]];

    return cell;
}

#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.tableView.editing == YES) {
        
                AddNewCompany *editCompany =
                [[AddNewCompany alloc]
                 initWithNibName:@"AddNewCompany" bundle:nil];
        
        editCompany.addcompany = [self.sharedManager.companyList objectAtIndex:indexPath.row];
        
        [self.navigationController pushViewController:editCompany
                 animated:YES];
        
    } else {
        
        self.productViewController.title = [[self.sharedManager.companyList objectAtIndex:[indexPath row]]companyName];
        self.productViewController.company = [self.sharedManager.companyList objectAtIndex:[indexPath row]];
        
        [self.navigationController
         pushViewController:self.productViewController
         animated:YES];

    }

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.sharedManager.companyList removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.sharedManager.companyList insertObject: [self.sharedManager.companyList objectAtIndex:sourceIndexPath.row] atIndex:destinationIndexPath.row];
    [self.sharedManager.companyList removeObjectAtIndex:(sourceIndexPath.row + 1)];
}




@end
