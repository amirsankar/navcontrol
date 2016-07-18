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


-(void)dealloc{
    [_productsArray removeAllObjects];
    [_companyName release];
    [_companyImage release];
    [_stockSymbol release];
    [_productsArray release];
    
    _companyName = nil;
    _companyImage = nil;
    _stockSymbol = nil;
    _productsArray = nil;
    
    [super dealloc];
}

@end
