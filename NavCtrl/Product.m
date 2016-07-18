//
//  Product.m
//  NavCtrl
//
//  Created by amir sankar on 5/17/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Product.h"

@implementation Product

-(instancetype)initName:(NSString *)names andURL:(NSString *)url andImage:(NSString *)image;
{
    _productName = [names retain];
    _productURL = [url retain];
    _productImage = [image retain];
    
    return self;
}

-(void)dealloc{
    _productName = nil;
    _productURL = nil;
    _productName = nil;
    _productID = nil;
    [super dealloc];
}



@end
