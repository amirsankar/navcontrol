//
//  Company.m
//  NavCtrl
//
//  Created by amir sankar on 5/17/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "Company.h"

@implementation Company

-(instancetype)initName:(NSString *)name andImage:(NSString *)image andProducts:(NSMutableArray *)products;
{
    self.companyName = name;
    self.companyImage = image;
    self.productsArray = products;
    
    return self;
}

@end
