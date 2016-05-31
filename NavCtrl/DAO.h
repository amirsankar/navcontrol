//
//  DAO.h
//  NavCtrl
//
//  Created by amir sankar on 5/18/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
#import "Company.h"

@interface DAO : NSObject
@property (nonatomic, retain) NSMutableArray *companyList;
-(void)getCompanysAndProducts;
+ (id)sharedManager;

@end
