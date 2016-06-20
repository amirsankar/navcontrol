//
//  DAO.h
//  NavCtrl
//
//  Created by amir sankar on 5/18/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"
#import "sqlite3.h"
#import "Company.h"

@interface DAO : NSObject
@property (nonatomic, retain) NSMutableArray *companyList;
+ (id)sharedManager;
-(void)addCompany:(NSString *)name withImage:(NSString *)image withStock:(NSString *)stock;
-(void)addProduct:(NSString *)name andURL:(NSString *)url andImage:(NSString *)image forCompany:(Company*)company;
-(void)deleteCompanyFromSQL:(NSNumber *) companyID;
-(void)deleteProductFromSQL:(NSNumber *) productID;
-(void)editCompany:(Company *)company;
-(void)editProduct:(Product *)product;

@end
