//
//  Webview.h
//  NavCtrl
//
//  Created by amir sankar on 5/16/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "AddNewProduct.h"
#import "Product.h"
#import "Company.h"

@interface Webview : UIViewController
@property (nonatomic, retain) WKWebView *theWebView;
@property (nonatomic, retain) NSString *myProductsURL;
@property (nonatomic, retain) AddNewProduct *productEditVC;
@property (nonatomic, retain) Product *currentProduct;
@property (nonatomic, retain) Company *currentCompany;

@end
