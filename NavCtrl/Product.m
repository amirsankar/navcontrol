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
    _productName = names;
    _productURL = url;
    _productImage = image;
    
    return self;
}

-(void)dealloc{
    [super dealloc];
}

@end
