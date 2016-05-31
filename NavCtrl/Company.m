//
//  Company.m
//  NavCtrl
//
//  Created by amir sankar on 5/17/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company

-(instancetype)initName:(NSString *)name andImage:(NSString *)image andProducts:(NSMutableArray *)products
{
    _companyName = name;
    _companyImage = image;
    _productsArray = [products retain];
    return self;
}
//
//-(instancetype)initName:(NSString *)name andImage:(NSString *)image
//{
//    _productsArray = [[NSMutableArray alloc] init];
//    return [self initName:name andImage:image andProducts:_productsArray];
//}

@end
