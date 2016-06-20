//
//  Company.h
//  NavCtrl
//
//  Created by amir sankar on 5/17/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Product.h"

@interface Company : NSObject
@property (nonatomic, retain) NSMutableArray *productsArray;
@property (nonatomic, retain) NSString *companyName;
@property(nonatomic, retain) NSString *companyImage;
@property(nonatomic, retain) NSString *stockSymbol;
@property(nonatomic, retain) NSNumber *companyID;
-(instancetype)initName:(NSString *)names andImage:(NSString *)image andStock:(NSString *)symbol;
-(instancetype)initName:(NSString *)names andImage:(NSString *)image andStock:(NSString *)symbol andID:(NSNumber *)number;

@end
