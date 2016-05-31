//
//  Webview.h
//  NavCtrl
//
//  Created by amir sankar on 5/16/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface Webview : UIViewController
@property (nonatomic, retain) WKWebView *theWebView;
@property (nonatomic, retain) NSString *myProductsURL;

@end
