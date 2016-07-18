//
//  CompanyViewController.m
//  NavCtrl
//
//  Created by Aditya Narayan on 10/22/13.
//  Copyright (c) 2013 Aditya Narayan. All rights reserved.
//

#import "CompanyViewController.h"
#import "DAO.h"
#import "AddNewCompany.h"
#import "Company.h"

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
    self.sharedManager = [DAO sharedManager];
    [self getStockPrice];
    self.title = @"Amir's Companies";
    self.tableView.allowsSelectionDuringEditing = YES;
    self.view.frame = self.view.window.frame;
    self.tableView.frame = self.view.frame;
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]init];
    addButton.action = @selector(openAddNewCompany);
    addButton.title = @"Add";
    addButton.target = self;
    UIBarButtonItem *undoButton = [[UIBarButtonItem alloc]init];
    undoButton.action = @selector(undoButtonAction);
    undoButton.title = @"Undo";
    undoButton.target = self;
    [self.navigationItem setLeftBarButtonItems:@[addButton]];

    [self.navigationItem setRightBarButtonItems: @[self.editButtonItem, undoButton]];

}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];

}

-(void)undoButtonAction
{
    DAO *sharedManager = [DAO sharedManager];
    [sharedManager.managedObjectContext undo];
    [sharedManager loadData];
    [self.tableView reloadData];
}

-(void)openAddNewCompany
{
    UIViewController *vc =
    [[AddNewCompany alloc] initWithNibName:@"AddNewCompany" bundle:nil];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.sharedManager.companyList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    NSString *companyName = [[self.sharedManager.companyList objectAtIndex:indexPath.row] companyName];
    
    NSString *stockSymbol = [[self.sharedManager.companyList objectAtIndex:indexPath.row]stockSymbol];
    
    if ([self.stockPrices objectAtIndex:[indexPath row]] != nil) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", companyName,stockSymbol];
        cell.detailTextLabel.numberOfLines = 2;
        cell.detailTextLabel.text = [self.stockPrices objectAtIndex:[indexPath row]];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.sharedManager.companyList objectAtIndex:[indexPath row]] companyName]];
    }
    cell.imageView.image = [UIImage imageNamed:[[self.sharedManager.companyList objectAtIndex:[indexPath row]]companyImage]];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView.editing == YES) {
                AddNewCompany *editCompany =
                [[AddNewCompany alloc]
                 initWithNibName:@"AddNewCompany" bundle:nil];
        
        editCompany.companyToEdit = [self.sharedManager.companyList objectAtIndex:indexPath.row];
        
        [self.navigationController pushViewController:editCompany
                 animated:YES];
    } else {
        
        self.productListViewController = [[ProductListViewController alloc]init];
        self.productListViewController.title = [[self.sharedManager.companyList objectAtIndex:[indexPath row]] companyName];
        self.productListViewController.company = [self.sharedManager.companyList objectAtIndex:[indexPath row]];
        
        [self.navigationController
         pushViewController:self.productListViewController
         animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Company *company = [self.sharedManager.companyList objectAtIndex:indexPath.row];
        [self.sharedManager deleteCompany:company];
        
        [company release];
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

-(void)getStockPrice
{
    NSMutableArray *stockSymbols = [[NSMutableArray alloc] init];
    for (Company *company in self.sharedManager.companyList) {
        [stockSymbols addObject:company.stockSymbol];
    }
    
    NSString *dataURL = [NSString stringWithFormat:@"http://finance.yahoo.com/d/quotes.csv?s=%@&f=b",[stockSymbols componentsJoinedByString:@"+"]];
    
    [stockSymbols release];
    
    NSURL *url = [NSURL URLWithString:dataURL];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.stockPrices = [newStr componentsSeparatedByString:@"\n"];
               dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
        [newStr release];
        [session finishTasksAndInvalidate];
    }];
    [dataTask resume];
}


@end
