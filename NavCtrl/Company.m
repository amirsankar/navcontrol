//
//  Company.m
//  NavCtrl
//
//  Created by amir sankar on 5/17/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company

-(instancetype)initName:(NSString *)name andImage:(NSString *)image andStock:(NSString *)symbol
{
    _companyName = [name retain];
    _companyImage = [image retain];
    _stockSymbol = [symbol retain];
    _productsArray = [[NSMutableArray alloc]init];
    return self;
}

-(instancetype)initName:(NSString *)name andImage:(NSString *)image andStock:(NSString *)symbol andID:(NSNumber *)number
{
    _companyName = [name retain];
    _companyImage = [image retain];
    _stockSymbol = [symbol retain];
    _companyID = [number retain];
    _productsArray = [[NSMutableArray alloc]init];
    return self;
}


@end
