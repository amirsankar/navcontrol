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
#import <CoreData/coreData.h>


@interface DAO : NSObject
@property (nonatomic, retain) NSMutableArray *companyList;
@property (nonatomic, retain) NSMutableArray *managedCompanyList;
+ (id)sharedManager;
-(void)loadData;
-(void)deleteCompany: (Company *) companyToDelete;
-(void)editCompany:(Company *)company newName:(NSString *)name withImage:(NSString *)image withStock:(NSString *)stock;
-(void)addCompany:(NSString *)name withImage:(NSString *)image withStock:(NSString *)stock;
-(void)addProduct:(NSString *)name andURL:(NSString *)url andImage:(NSString *)image forCompany:(Company*)company;
-(void)editProduct: (Product*)productToEdit inCompany: (Company*)company newName: (NSString*)name newImage: (NSString*)image newURL: (NSString*)urlString;
-(void)deleteProduct: (Product*) productToDelete inCompany: (Company*)company;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end
