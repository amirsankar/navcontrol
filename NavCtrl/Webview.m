//
//  Webview.m
//  NavCtrl
//
//  Created by amir sankar on 5/16/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Webview.h"

@interface Webview ()

@end

@implementation Webview

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc]initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editAction)];
    
    self.navigationItem.rightBarButtonItem = editButton;
    
    NSString *urlString = self.myProductsURL;
    NSURL *myURL;
    if ([urlString.lowercaseString hasPrefix:@"http://"]) {
        myURL = [NSURL URLWithString:urlString];
    } else {
        myURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", urlString]];
    }
    WKWebViewConfiguration *theConfig = [[WKWebViewConfiguration alloc]init];
    self.theWebView = [[WKWebView alloc]initWithFrame:[[UIScreen mainScreen]bounds]configuration:theConfig];
    [self.theWebView loadRequest:[NSURLRequest requestWithURL:myURL]];
    [self.view addSubview:self.theWebView];
}

-(void)editAction {
    
    self.productEditVC = [[AddNewProduct alloc]init];
    self.productEditVC.productToEdit = self.currentProduct;
    self.productEditVC.company = self.currentCompany;
    [self.navigationController pushViewController:self.productEditVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    [_theWebView release];
    [super dealloc];
}
@end
