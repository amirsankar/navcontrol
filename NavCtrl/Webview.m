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
    NSString *urlString = self.myProductsURL;
    NSURL *myURL;
    if ([urlString.lowercaseString hasPrefix:@"http://"]) {
        myURL = [NSURL URLWithString:urlString];
    } else {
        myURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", urlString]];
    }
    
    self.theWebView = [[WKWebView alloc]initWithFrame:self.view.frame];
    [self.theWebView loadRequest:[NSURLRequest requestWithURL:myURL]];
    [self.view addSubview:self.theWebView];
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
