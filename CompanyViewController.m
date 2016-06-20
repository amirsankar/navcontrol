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
    [self getStockPrice];
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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSString *companyName = [[self.sharedManager.companyList objectAtIndex:indexPath.row] companyName];
    
    if ([self.stockPrices objectAtIndex:[indexPath row]] != nil) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", companyName, [self.stockPrices objectAtIndex:[indexPath row]]];
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
        
        self.productViewController.title = [[self.sharedManager.companyList objectAtIndex:[indexPath row]] companyName];
        self.productViewController.company = [self.sharedManager.companyList objectAtIndex:[indexPath row]];
        
        [self.navigationController
         pushViewController:self.productViewController
         animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Company *company = [self.sharedManager.companyList objectAtIndex:indexPath.row];
        [self.sharedManager deleteCompanyFromSQL:company.companyID];
        
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

-(void)getStockPrice
{
    NSMutableString *stockString = [[NSMutableString alloc] initWithString:@""];
    for (Company *company in self.sharedManager.companyList) {
        [stockString appendString:[NSString stringWithFormat:@"%@+",company.stockSymbol ]];
    }
    stockString = (NSMutableString*)[stockString substringToIndex:[stockString length] - 1];
    NSString *dataURL = [[NSString alloc]initWithFormat:@"http://finance.yahoo.com/d/quotes.csv?s=%@&f=b",stockString];
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
    }];
    [dataTask resume];
}


@end
