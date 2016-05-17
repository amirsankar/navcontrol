//
//  ProductViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "ProductViewController.h"
#import "Webview.h"

@interface ProductViewController ()

@end

@implementation ProductViewController

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
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if ([self.title isEqualToString:@"Apple"]) {
        self.products = [NSMutableArray arrayWithObjects:@"iPad", @"iPod Touch",@"iPhone", nil];
    }
    if([self.title isEqualToString:@"Samsung"]){
        self.products = [NSMutableArray arrayWithObjects:@"Galaxy S4", @"Galaxy Note", @"Galaxy Tab", nil];
    }
    if([self.title isEqualToString:@"Volkswagen"]){
        self.products = [NSMutableArray arrayWithObjects:@"Jetta", @"Passat", @"Golf", nil];
    }
    if([self.title isEqualToString:@"Rolex"]){
        self.products = [NSMutableArray arrayWithObjects:@"Presidential", @"Submariner", @"Yacht Master", nil];
    }
    [self.tableView reloadData];
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
    return [self.products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    cell.textLabel.text = [self.products objectAtIndex:[indexPath row]];
    NSString *productName = [self.products objectAtIndex:[indexPath row]];
    
    if ([productName isEqualToString:@"iPad"]) {
        [[cell imageView] setImage: [UIImage imageNamed:@"ipad_pic.jpg"]];
    }
    if ([productName isEqualToString:@"iPod Touch"]) {
        [[cell imageView] setImage: [UIImage imageNamed:@"ipod_pic.png"]];
    }
    if ([productName isEqualToString:@"iPhone"]) {
        [[cell imageView] setImage: [UIImage imageNamed:@"iphone_pic.jpg"]];
    }
    if ([productName isEqualToString:@"Galaxy S4"]) {
        [[cell imageView] setImage: [UIImage imageNamed:@"galaxys4.jpg"]];
    }
    if ([productName isEqualToString:@"Galaxy Note"]) {
        [[cell imageView] setImage: [UIImage imageNamed:@"galaxyNote.png"]];
    }
    if ([productName isEqualToString:@"Galaxy Tab"]) {
        [[cell imageView] setImage: [UIImage imageNamed:@"galaxyTab.jpg"]];
    }
    if ([productName isEqualToString:@"Jetta"]) {
        [[cell imageView] setImage: [UIImage imageNamed:@"Jetta.jpg"]];
    }
    if ([productName isEqualToString:@"Passat"]) {
        [[cell imageView] setImage: [UIImage imageNamed:@"Passat.jpg"]];
    }
    if ([productName isEqualToString:@"Golf"]) {
        [[cell imageView] setImage: [UIImage imageNamed:@"Golf.png"]];
    }
    if ([productName isEqualToString:@"Presidential"]) {
        [[cell imageView] setImage: [UIImage imageNamed:@"presidential.jpg"]];
    }
    if ([productName isEqualToString:@"Submariner"]) {
        [[cell imageView] setImage: [UIImage imageNamed:@"submariner.jpg"]];
    }
    if ([productName isEqualToString:@"Yacht Master"]) {
        [[cell imageView] setImage: [UIImage imageNamed:@"yacht_master.jpg"]];
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
    // Navigation logic may go here, for example:
    // Create the next view controller.
    
    Webview *detailViewController = [[Webview alloc] initWithNibName:@"Webview" bundle:nil];    
    NSString *productName = [self.products objectAtIndex:[indexPath row]];
    
    if ([productName isEqualToString:@"iPad"]) {
        detailViewController.myProductsURL = @"http://www.apple.com/ipad/";
    }
    if ([productName isEqualToString:@"iPod Touch"]) {
        detailViewController.myProductsURL = @"http://www.apple.com/ipod/";
    }
    if ([productName isEqualToString:@"iPhone"]) {
        detailViewController.myProductsURL = @"http://www.apple.com/iphone/";
    }
    if ([productName isEqualToString:@"Galaxy S4"]) {
        detailViewController.myProductsURL = @"http://www.samsung.com/us/mobile/cell-phones/SCH-I545ZWAVZW";
    }
    if ([productName isEqualToString:@"Galaxy Note"]) {
        detailViewController.myProductsURL = @"http://www.samsung.com/us/explore/galaxy-note-5-features-and-specs/?cid=ppc-";
    }
    if ([productName isEqualToString:@"Galaxy Tab"]) {
        detailViewController.myProductsURL = @"http://www.samsung.com/us/explore/tab-s2-features-and-specs/?cid=ppc-";
    }
    if ([productName isEqualToString:@"Jetta"]) {
        detailViewController.myProductsURL = @"http://www.vw.com/models/jetta/?&cid=ssem_XxWHHIvB_95913081306_c";
    }
    if ([productName isEqualToString:@"Passat"]) {
        detailViewController.myProductsURL = @"http://www.vw.com/models/passat/?&cid=ssem_Q9LIdBM9_95913100146_c";
    }
    if ([productName isEqualToString:@"Golf"]) {
        detailViewController.myProductsURL = @"http://www.vw.com/models/golf/?&cid=ssem_YcnZ1Yyk_96457705266_c";
    }
    if ([productName isEqualToString:@"Yacht Master"]) {
        detailViewController.myProductsURL = @"http://www.rolex.com/watches/yacht-master-ii/m116688-0001.html";
    }
    if ([productName isEqualToString:@"Submariner"]) {
        detailViewController.myProductsURL = @"http://www.rolex.com/watches/submariner/m114060-0002.html";
    }
    if ([productName isEqualToString:@"Presidential"]) {
        detailViewController.myProductsURL = @"http://www.rolex.com/watches/day-date/m118205f-0107.html";
    }


    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.products removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.products insertObject: [self.products objectAtIndex:sourceIndexPath.row] atIndex:destinationIndexPath.row];
    [self.products removeObjectAtIndex:(sourceIndexPath.row + 1)];
}


@end
