//
//  Product.h
//  NavCtrl
//
//  Created by amir sankar on 5/17/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject
@property(nonatomic, retain) NSString *productName;
@property(nonatomic, retain) NSString *productURL;
@property(nonatomic, retain) NSString *productImage;
@property(nonatomic, retain) NSNumber *productID;
-(instancetype)initName:(NSString *)names andURL:(NSString *)url andImage:(NSString *)image;

@end
