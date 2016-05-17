//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "ProductViewController.h"

@interface CompanyViewController ()

@end

@implementation CompanyViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
     self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    self.companyList = [NSMutableArray arrayWithObjects:@"Apple",@"Samsung",@"Volkswagen",@"Rolex", nil];
    self.title = @"Amir's Companies";
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    cell.textLabel.text = [self.companyList objectAtIndex:[indexPath row]];
    NSString *companyName = [self.companyList objectAtIndex:[indexPath row]];
    
    if ([companyName isEqualToString:@"Samsung"]) {
        [[cell imageView] setImage: [UIImage imageNamed:@"Samsung_logo.png"]];
    }
    if ([companyName isEqualToString:@"Apple"]) {
        [[cell imageView] setImage: [UIImage imageNamed:@"Apple_Logo.png"]];
    }
    if ([companyName isEqualToString:@"Volkswagen"]){
        [[cell imageView] setImage: [UIImage imageNamed:@"Volkswagen_logo.png"]];;
    }
    if ([companyName isEqualToString:@"Rolex"]){
        [[cell imageView] setImage: [UIImage imageNamed:@"Rolex-logo.jpg"]];;
    }
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *companyName = [self.companyList objectAtIndex:[indexPath row]];
    
    if ([companyName isEqualToString:@"Apple"]) {
        self.productViewController.title = @"Apple";
    } else if ([companyName isEqualToString:@"Samsung"]) {
        self.productViewController.title = @"Samsung";
    } else if ([companyName isEqualToString:@"Volkswagen"]){
        self.productViewController.title = @"Volkswagen";
    } else if ([companyName isEqualToString:@"Rolex"]){
        self.productViewController.title = @"Rolex";
    }

    
    
    /*if (indexPath.row == 0){
        self.productViewController.title = @"Apple mobile devices";
    } else {
        self.productViewController.title = @"Samsung mobile devices";
    }*/
    
    [self.navigationController
        pushViewController:self.productViewController
        animated:YES];
    

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.companyList removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.companyList insertObject: [self.companyList objectAtIndex:sourceIndexPath.row] atIndex:destinationIndexPath.row];
    [self.companyList removeObjectAtIndex:(sourceIndexPath.row + 1)];
}


@end
