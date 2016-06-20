//
//  DAO.m
//  NavCtrl
//
//  Created by amir sankar on 5/18/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "DAO.h"


static DAO *sharedMyManager = nil;


@implementation DAO
{
    sqlite3 *personDB;
    NSString *dbPathString;
}

#pragma mark Singleton Methods
+ (id)sharedManager
{
    @synchronized(self) {
        if(sharedMyManager == nil)
            sharedMyManager = [[super allocWithZone:NULL] init];
    }
    return sharedMyManager;
}

- (id)init
{
    if (self = [super init]) {
        [self createOrOpenDB];
    }
    return self;
}

//-(void)getCompanysAndProducts
//{
//    Product *ipad = [[Product alloc]initName:@"iPad" andURL:@"http://www.apple.com/ipad/" andImage:@"ipad_pic.jpg"];
//    Product *ipod = [[Product alloc]initName:@"iPod Touch" andURL:@"http://www.apple.com/ipod/" andImage:@"ipod_pic.png"];
//    Product *iphone = [[Product alloc]initName:@"iPhone" andURL:@"http://www.apple.com/iphone/" andImage:@"iphone_pic.jpg"];
//    Product *s4 = [[Product alloc]initName:@"Galaxy S4" andURL:@"http://www.samsung.com/us/mobile/cell-phones/SCH-I545ZWAVZW" andImage:@"galaxys4.jpg"];
//    Product *note = [[Product alloc]initName:@"Galaxy Note" andURL:@"http://www.samsung.com/us/explore/galaxy-note-5-features-and-specs/?cid=ppc-" andImage:@"galaxyNote.png"];
//    Product *tab = [[Product alloc]initName:@"Galaxy Tab" andURL:@"http://www.samsung.com/us/explore/tab-s2-features-and-specs/?cid=ppc-" andImage:@"galaxyTab.jpg"];
//    Product *jetta = [[Product alloc]initName:@"Jetta" andURL:@"http://www.vw.com/models/jetta/?&cid=ssem_XxWHHIvB_95913081306_c" andImage:@"Jetta.jpg"];
//    Product *passat = [[Product alloc]initName:@"Passat" andURL:@"http://www.vw.com/models/passat/?&cid=ssem_Q9LIdBM9_95913100146_c" andImage:@"Passat.jpg"];
//    Product *golf = [[Product alloc]initName:@"Golf" andURL:@"http://www.vw.com/models/golf/?&cid=ssem_YcnZ1Yyk_96457705266_c" andImage:@"Golf.png"];
//    Product *presidential = [[Product alloc]initName:@"Presidential" andURL:@"http://www.rolex.com/watches/day-date/m118205f-0107.html" andImage:@"presidential.jpg"];
//    Product *submariner = [[Product alloc]initName:@"Submariner" andURL:@"http://www.rolex.com/watches/submariner/m114060-0002.html" andImage:@"submariner.jpg"];
//    Product *yachtmaster = [[Product alloc]initName:@"Yacht Master" andURL:@"http://www.rolex.com/watches/yacht-master-ii/m116688-0001.html" andImage:@"yacht_master.jpg"];
//
//
//    NSMutableArray *apple_products = [[NSMutableArray alloc]initWithArray:@[ipad, ipod, iphone]];
//    Company *apple = [[Company alloc]initName:@"Apple" andImage:@"Apple_Logo.png" andProducts:apple_products andStock:@"AAPL"];
//
//    NSMutableArray *samsung_products = [[NSMutableArray alloc]initWithArray:@[s4, note, tab]];
//    Company *samsung = [[Company alloc]initName:@"Samsung" andImage:@"Samsung_logo.png" andProducts:samsung_products andStock:@"SSNLF"];
//
//    NSMutableArray *volkswagen_products = [[NSMutableArray alloc]initWithArray:@[jetta, passat, golf]];
//    Company *volkswagen = [[Company alloc]initName:@"Volkswagen" andImage:@"Volkswagen_logo.png" andProducts:volkswagen_products andStock:@"GM"];
//
//    NSMutableArray *rolex_products = [[NSMutableArray alloc]initWithArray:@[presidential, submariner, yachtmaster]];
//    Company *rolex = [[Company alloc]initName:@"Rolex" andImage:@"Rolex-logo.jpg" andProducts:rolex_products andStock:@"UA"];
//    [rolex_products release];
//    [volkswagen_products release];
//    [samsung_products release];
//    [apple_products release];
//
//    self.companyList = [NSMutableArray arrayWithObjects:apple, samsung, volkswagen, rolex, nil];
//
//}

-(void)createOrOpenDB
{
    NSString *folderPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString *sourcePath = [[[NSBundle mainBundle] resourcePath]  stringByAppendingPathComponent:@"CompanyProductDatabase.db"];
    dbPathString = [folderPath stringByAppendingPathComponent:@"CompanyProductDatabase.db"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    char *error = NULL;
    NSError *theError = nil;
    NSLog(@"%@", dbPathString);
    if (![fileManager fileExistsAtPath:dbPathString])
    {
        
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath
                                                toPath:dbPathString
                                                 error:&theError];
    }
    const char *dbPath = [dbPathString UTF8String];
    self.companyList = [[NSMutableArray alloc] init];
    
    if (sqlite3_open(dbPath, &personDB)== SQLITE_OK)
    {
        const char *sql_stmt = "SELECT * FROM Company";
        sqlite3_stmt *statement;
        if(sqlite3_prepare_v2(personDB, sql_stmt, -1, &statement, nil) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                int companyNumber = sqlite3_column_int(statement, 0);
                NSNumber *companyID = [NSNumber numberWithInt:companyNumber];
                NSString *companyName =
                [NSString stringWithUTF8String: (char*)sqlite3_column_text(statement, 1) ];
                NSString *companyImage =
                [NSString stringWithUTF8String: (char*)sqlite3_column_text(statement, 2) ];
                NSString *companyStock =
                [NSString stringWithUTF8String: (char*)sqlite3_column_text(statement, 3) ];
                Company *company = [[Company alloc]initName:companyName andImage:companyImage andStock:companyStock andID:companyID];
                [self.companyList addObject:company];
                NSString *string =  [NSString stringWithFormat:@"SELECT * FROM Product where product.Company_Id == %d", companyNumber];
                const char *sql_stmt_prod = [string UTF8String];
                sqlite3_stmt *statementProduct;
                if(sqlite3_prepare_v2(personDB, sql_stmt_prod, -1, &statementProduct, nil) == SQLITE_OK) {
                    while (sqlite3_step(statementProduct) == SQLITE_ROW) {
                        int productNumber = sqlite3_column_int(statementProduct, 0);
                        NSNumber *productID = [NSNumber numberWithInt:productNumber];
                        NSString *productName =
                        [NSString stringWithUTF8String: (char*)sqlite3_column_text(statementProduct, 1) ];
                        NSString *productURL =
                        [NSString stringWithUTF8String: (char*)sqlite3_column_text(statementProduct, 2) ];
                        NSString *productImage =
                        [NSString stringWithUTF8String: (char*)sqlite3_column_text(statementProduct, 3) ];
                        Product *product = [[Product alloc]initName:productName andURL:productURL andImage:productImage andId:productID];
                        [company.productsArray addObject:product];
                    }
                }
            }
        } else {
            NSLog(@"%s",error);
        }
    }
}

-(void)addCompany:(NSString *)name withImage:(NSString *)image withStock:(NSString *)stock
{
    char * error;
    NSString *querySQL = [NSString stringWithFormat:@"INSERT INTO Company (Company_Name, Company_Image, Company_Stock_Symbol) VALUES ('%@', '%@', '%@')", name, image, stock];
    
    if (sqlite3_exec(personDB, [querySQL UTF8String], NULL, NULL, &error) == SQLITE_OK){
        NSLog(@"company added");
    } else {
        NSLog(@"error adding company");
    }
    Company *theCompany = [[Company alloc]initName:name andImage:image andStock:stock];
    NSInteger lastRowId = sqlite3_last_insert_rowid(personDB);
    NSNumber *lastRow = @(lastRowId);
    theCompany.companyID = lastRow;
    [self.companyList addObject:theCompany];
}

-(void)addProduct:(NSString *)name andURL:(NSString *)url andImage:(NSString *)image forCompany:(Company*)company
{
    char * error;
    NSString *querySQL = [NSString stringWithFormat:@"INSERT INTO Product (Product_Name, Product_URL, Product_Image, Company_Id) VALUES ('%@', '%@', '%@', '%@')", name, url, image, company.companyID];
    
    if (sqlite3_exec(personDB, [querySQL UTF8String], NULL, NULL, &error) == SQLITE_OK){
        NSLog(@"product added");
    } else {
        NSLog(@"error adding product");
    }
    Product *product = [[Product alloc]initName:name andURL:url andImage:image];
    NSInteger lastRowId = sqlite3_last_insert_rowid(personDB);
    NSNumber *lastRow = @(lastRowId);
    product.productID = lastRow;
    [company.productsArray addObject:product];
}

-(void)deleteCompanyFromSQL:(NSNumber *) companyID
{
    char * error;
    NSString *deleteQuery = [NSString stringWithFormat:@"DELETE FROM Company WHERE id = '%@'", companyID];
    if (sqlite3_exec(personDB, [deleteQuery UTF8String], NULL, NULL, &error) == SQLITE_OK){
        NSLog(@"company deleted");
    } else {
        NSLog(@"error deleting company");
    }
}

-(void)deleteProductFromSQL:(NSNumber *) productID
{
    char * error;
    NSString *deleteQuery = [NSString stringWithFormat:@"DELETE FROM Product WHERE id = '%@'", productID];
    
    if (sqlite3_exec(personDB, [deleteQuery UTF8String], NULL, NULL, &error) == SQLITE_OK){
        NSLog(@"product deleted");
    } else {
        NSLog(@"error deleting product");
    }
}

-(void)editCompany:(Company *)company
{
    char * error;
    NSString *editQuery = [NSString stringWithFormat:@"UPDATE Company SET  Company_Name = '%@', Company_Image = '%@', Company_Stock_Symbol = '%@' Where id = '%@'", company.companyName, company.companyImage, company.stockSymbol, company.companyID];
    
    if (sqlite3_exec(personDB, [editQuery UTF8String], NULL, NULL, &error) == SQLITE_OK){
        NSLog(@"company edited");
    } else {
        NSLog(@"error editing company");
    }
}

-(void)editProduct:(Product *)product
{
    char * error;
    NSString *editQuery = [NSString stringWithFormat:@"UPDATE Product SET  Product_Name = '%@', Product_URL = '%@', Product_Image = '%@' Where id = '%@'", product.productName, product.productURL, product.productImage, product.productID];
    
    if (sqlite3_exec(personDB, [editQuery UTF8String], NULL, NULL, &error) == SQLITE_OK){
        NSLog(@"company edited");
    } else {
        NSLog(@"error editing product");
    }
}

@end
