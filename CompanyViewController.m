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
    
    self.title = @"Amir's Companies";
    
    Product *ipad = [[Product alloc]initName:@"iPad" andURL:@"http://www.apple.com/ipad/" andImage:@"ipad_pic.jpg"];
    Product *ipod = [[Product alloc]initName:@"iPod Touch" andURL:@"http://www.apple.com/ipod/" andImage:@"ipod_pic.png"];
    Product *iphone = [[Product alloc]initName:@"iPhone" andURL:@"http://www.apple.com/iphone/" andImage:@"iphone_pic.jpg"];
    Product *s4 = [[Product alloc]initName:@"Galaxy S4" andURL:@"http://www.samsung.com/us/mobile/cell-phones/SCH-I545ZWAVZW" andImage:@"galaxys4.jpg"];
    Product *note = [[Product alloc]initName:@"Galaxy Note" andURL:@"http://www.samsung.com/us/explore/galaxy-note-5-features-and-specs/?cid=ppc-" andImage:@"galaxyNote.png"];
    Product *tab = [[Product alloc]initName:@"Galaxy Tab" andURL:@"http://www.samsung.com/us/explore/tab-s2-features-and-specs/?cid=ppc-" andImage:@"galaxyTab.jpg"];
    Product *jetta = [[Product alloc]initName:@"Jetta" andURL:@"http://www.vw.com/models/jetta/?&cid=ssem_XxWHHIvB_95913081306_c" andImage:@"Jetta.jpg"];
    Product *passat = [[Product alloc]initName:@"Passat" andURL:@"http://www.vw.com/models/passat/?&cid=ssem_Q9LIdBM9_95913100146_c" andImage:@"Passat.jpg"];
    Product *golf = [[Product alloc]initName:@"Golf" andURL:@"http://www.vw.com/models/golf/?&cid=ssem_YcnZ1Yyk_96457705266_c" andImage:@"Golf.png"];
    Product *presidential = [[Product alloc]initName:@"Presidential" andURL:@"http://www.rolex.com/watches/day-date/m118205f-0107.html" andImage:@"presidential.jpg"];
    Product *submariner = [[Product alloc]initName:@"Submariner" andURL:@"http://www.rolex.com/watches/submariner/m114060-0002.html" andImage:@"submariner.jpg"];
    Product *yachtmaster = [[Product alloc]initName:@"Yacht Master" andURL:@"http://www.rolex.com/watches/yacht-master-ii/m116688-0001.html" andImage:@"yacht_master.jpg"];

    Company *apple = [[Company alloc]initName:@"Apple" andImage:@"Apple_Logo.png" andProducts:[NSMutableArray arrayWithObjects:ipad, ipod, iphone, nil]];
    Company *samsung = [[Company alloc]initName:@"Samsung" andImage:@"Samsung_logo.png" andProducts:[NSMutableArray arrayWithObjects:s4, note, tab, nil]];
    Company *volkswagen = [[Company alloc]initName:@"Volkswagen" andImage:@"Volkswagen_logo.png" andProducts:[NSMutableArray arrayWithObjects:jetta, passat, golf, nil]];
    Company *rolex = [[Company alloc]initName:@"Rolex" andImage:@"Rolex-logo.jpg" andProducts:[NSMutableArray arrayWithObjects:presidential, submariner, yachtmaster, nil]];
    
  self.companyList = [NSMutableArray arrayWithObjects:apple, samsung, volkswagen, rolex, nil];
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
    Company *currentCompany = [self.companyList objectAtIndex:[indexPath row]];
    cell.textLabel.text = currentCompany.companyName;
    cell.imageView.image = [UIImage imageNamed:currentCompany.companyImage];

    return cell;
}


#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    Company *currentCompany = [self.companyList objectAtIndex:[indexPath row]];
    self.productViewController.title = currentCompany.companyName;
    self.productViewController.company = currentCompany;
    
    
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
    
//    DAO *something = [DAO sharedManager];
//    something.companyList
//    do this in .h
//    [[DAO sharedManger] companyList];
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.companyList insertObject: [self.companyList objectAtIndex:sourceIndexPath.row] atIndex:destinationIndexPath.row];
    [self.companyList removeObjectAtIndex:(sourceIndexPath.row + 1)];
}


@end
