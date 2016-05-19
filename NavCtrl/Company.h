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

-(instancetype)initName:(NSString *)names andImage:(NSString *)image andProducts:(NSMutableArray *)products;


@end
