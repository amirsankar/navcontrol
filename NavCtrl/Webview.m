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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *nsurl=[[NSURL alloc ]initWithString:self.myProductsURL];
    self.theWebView = [[WKWebView alloc]initWithFrame:self.view.frame];
    [self.theWebView loadRequest:[NSURLRequest requestWithURL:nsurl]];
    [self.view addSubview:self.theWebView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_theWebView release];
    [super dealloc];
}
@end
