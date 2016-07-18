//
//  DAO.m
//  NavCtrl
//
//  Created by amir sankar on 5/18/16.
//  Copyright © 2016 Aditya Narayan. All rights reserved.
//

#import "DAO.h"
#import "ManagedProduct.h"
#import "ManagedCompany.h"


static DAO *sharedMyManager = nil;


@implementation DAO
{
 NSUndoManager *undoManager;
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
        [self createCompany];
        [self loadData];
    }
    return self;
}

-(void)createCompany
{
    if (![[[NSUserDefaults standardUserDefaults]objectForKey:@"check"] isEqual: @"yes"]) {
        Product *ipad = [[Product alloc]init];
        ipad.productName = @"iPad";
        ipad.productURL = @"http://www.apple.com/ipad/";
        ipad.productImage = @"ipad_no.jpg";
        
        Product *ipod = [[Product alloc]init];
        ipod.productName = @"iPod";
        ipod.productURL = @"http://www.apple.com/ipod/";
        ipod.productImage = @"ipod_pic.png";
        
        Product *iphone = [[Product alloc]init];
        iphone.productName = @"iPhone";
        iphone.productURL = @"http://www.apple.com/iphone/";
        iphone.productImage = @"iphone_no.png";
        
        Product *s4 = [[Product alloc]init];
        s4.productName = @"Galaxy S4";
        s4.productURL = @"http://www.samsung.com/us/mobile/cell-phones/SCH-I545ZWAVZW";
        s4.productImage = @"galaxy_s4.png";
        
        Product *note = [[Product alloc]init];
        note.productName = @"Galaxy Note";
        note.productURL = @"http://www.samsung.com/us/mobile/cell-phones/SCH-I545ZWAVZW";
        note.productImage = @"galaxyNote.png";
        
        Product *tab = [[Product alloc]init];
        tab.productName = @"Galaxy Tab";
        tab.productURL = @"http://www.samsung.com/us/explore/tab-s2-features-and-specs/?cid=ppc-";
        tab.productImage = @"galaxyTab.jpg";
        
        Product *jetta = [[Product alloc]init];
        jetta.productName = @"Jetta";
        jetta.productURL = @"http://www.vw.com/models/jetta/?&cid=ssem_XxWHHIvB_95913081306_c";
        jetta.productImage = @"Jetta.jpg";
        
        Product *passat = [[Product alloc]init];
        passat.productName = @"Passat";
        passat.productURL = @"http://www.vw.com/models/passat/?&cid=ssem_Q9LIdBM9_95913100146_c";
        passat.productImage = @"Passat.jpg";
        
        Product *golf = [[Product alloc]init];
        golf.productName = @"Golf";
        golf.productURL = @"http://www.vw.com/models/golf/?&cid=ssem_YcnZ1Yyk_96457705266_c";
        golf.productImage = @"Golf.png";
        
        Product *presidential = [[Product alloc]init];
        presidential.productName = @"Presidential";
        presidential.productURL = @"http://www.rolex.com/watches/day-date/m118205f-0107.html";
        presidential.productImage = @"presidential2.jpg";
        
        Product *submariner = [[Product alloc]init];
        submariner.productName = @"Submariner";
        submariner.productURL = @"http://www.rolex.com/watches/submariner/m114060-0002.html";
        submariner.productImage = @"submariner.jpg";
        
        Product *yachtmaster = [[Product alloc]init];
        yachtmaster.productName = @"Yacht Master";
        yachtmaster.productURL = @"http://www.rolex.com/watches/yacht-master-ii/m116688-0001.html";
        yachtmaster.productImage = @"yacht_master.jpg";
        
        Company *apple = [[Company alloc]init];
        apple.companyName = @"Apple";
        apple.companyImage = @"Apple_logo1.png";
        apple.stockSymbol = @"AAPL";
        
        Company *samsung = [[Company alloc]init];
        samsung.companyName = @"Samsung";
        samsung.companyImage = @"Samsung_logo.png";
        samsung.stockSymbol = @"SSNLF";
        
        Company *volkswagen = [[Company alloc]init];
        volkswagen.companyName = @"Volkswagen";
        volkswagen.companyImage = @"Volkswagen_logo.png";
        volkswagen.stockSymbol = @"GM";
        
        Company *rolex = [[Company alloc]init];
        rolex.companyName = @"Rolex";
        rolex.companyImage = @"Rolex_logo1.png";
        rolex.stockSymbol = @"UA";
        
        apple.productsArray = (NSMutableArray*)@[iphone, ipad, ipod];
        samsung.productsArray = (NSMutableArray*)@[s4, note, tab];
        volkswagen.productsArray = (NSMutableArray*)@[jetta, passat, golf];
        rolex.productsArray = (NSMutableArray*)@[presidential, submariner, yachtmaster];
        self.companyList = [NSMutableArray arrayWithObjects:apple, samsung, volkswagen, rolex, nil];
        
        self.managedCompanyList = [[NSMutableArray alloc] init];
        for (Company *company in self.companyList){
            ManagedCompany *mC = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:self.managedObjectContext];
            
            [mC setValue:company.companyName forKey:@"companyName"];
            [mC setValue:company.companyImage forKey:@"companyImage"];
            [mC setValue:company.stockSymbol forKey:@"stockSymbol"];
            for (Product *product in company.productsArray ) {
                ManagedProduct *pC = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
                
                [pC setValue:product.productName forKey:@"productName"];
                [pC setValue:product.productURL forKey:@"productURL"];
                [pC setValue:product.productImage forKey:@"productLogo"];
                
                [mC addProductsObject:pC];
            }
            
            [self.managedCompanyList addObject:mC];
        }
        [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"check"];
        [self saveContext];
    }
}


-(void)loadData
{
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    NSEntityDescription *managedCompanyEntity = [[self.managedObjectModel entitiesByName]objectForKey:@"ManagedCompany"];
    [request setEntity:managedCompanyEntity];
    NSError *error = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (!result) {
        NSLog(@"Error!: %@", error.localizedDescription);
    }
    self.managedCompanyList = [[NSMutableArray alloc]initWithArray:result];
    self.companyList = [[NSMutableArray alloc]init];
    for (ManagedCompany *mC in self.managedCompanyList) {
        Company *company = [[Company alloc]initName:mC.companyName andImage:mC.companyImage andStock:mC.stockSymbol];
        
        for (ManagedProduct * mP in mC.products) {
            
            Product *product = [[Product alloc]initName:mP.productName andURL:mP.productURL andImage:mP.productLogo];
            [company.productsArray addObject:product];
        }
        [self.companyList addObject:company];
    }
}

-(void)addCompany:(NSString *)name withImage:(NSString *)image withStock:(NSString *)stock
{
    Company *newcompany = [[Company alloc] initName:name andImage:image andStock:stock];
    [self.companyList addObject:newcompany];
    ManagedCompany *newManagedCompany = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedCompany" inManagedObjectContext:self.managedObjectContext];
    [newManagedCompany setCompanyName:name];
    [newManagedCompany setCompanyImage:image];
    [newManagedCompany setStockSymbol:stock];
    [self.managedCompanyList addObject:newManagedCompany];
    [self saveContext];
}

-(void)editCompany:(Company *)company newName:(NSString *)name withImage:(NSString *)image withStock:(NSString *)stock
{
    company.companyName = name;
    company.companyImage = image;
    company.stockSymbol = stock;
    NSInteger index = [self.companyList indexOfObject:company];
    ManagedCompany *mC = [self.managedCompanyList objectAtIndex:index];
    mC.companyName = name;
    mC.companyImage = image;
    mC.stockSymbol = stock;
    [self saveContext];
}

-(void)deleteCompany: (Company *)companyToDelete
{
    NSInteger index = [self.companyList indexOfObject:companyToDelete];
    [self.managedObjectContext deleteObject:[self.managedCompanyList objectAtIndex:index]];
    [self.managedCompanyList removeObjectAtIndex:index];
    [self.companyList removeObject:companyToDelete];
    [self saveContext];
}

-(void)addProduct:(NSString *)name andURL:(NSString *)url andImage:(NSString *)image forCompany:(Company*)company
{
    Product *newProduct = [[Product alloc]initName:name andURL:url andImage:image];
    [company.productsArray addObject:newProduct];
    ManagedProduct *newManagedProduct = [NSEntityDescription insertNewObjectForEntityForName:@"ManagedProduct" inManagedObjectContext:self.managedObjectContext];
    [newManagedProduct setProductName:name];
    [newManagedProduct setProductURL:url];
    [newManagedProduct setProductLogo:image];
    
    NSInteger index = [self.companyList indexOfObject:company];
    ManagedCompany *mC = [self.managedCompanyList objectAtIndex:index];
    [mC addProductsObject:newManagedProduct];
    [self saveContext];
}

-(void)editProduct: (Product*)productToEdit inCompany: (Company*)company newName: (NSString*)name newImage: (NSString*)image newURL: (NSString*)urlString
{
    NSString *originalName = productToEdit.productName;
    productToEdit.productName = name;
    productToEdit.productImage = image;
    productToEdit.productURL = urlString;
    NSInteger index = [self.companyList indexOfObject:company];
    ManagedCompany *mC = [self.managedCompanyList objectAtIndex:index];
    NSArray *productArray = [mC.products allObjects];
    for (ManagedProduct *mP in productArray) {
        if ([mP.productName isEqualToString:originalName]) {
            mP.productName = name;
            mP.productURL = urlString;
            mP.productLogo = image;
        }
    }
    [self saveContext];
}

-(void)deleteProduct: (Product*) productToDelete inCompany: (Company*)company
{
    NSInteger companyIndex = [self.companyList indexOfObject:company];
    ManagedCompany *mC = [self.managedCompanyList objectAtIndex:companyIndex];
    NSArray *productArray = [mC.products allObjects];
    for (ManagedProduct *mP in productArray) {
        if ([mP.productName isEqualToString:productToDelete.productName]) {
            [self.managedObjectContext deleteObject:mP];
            [company.productsArray removeObject:productToDelete];
            [self saveContext];
        }
    }
}




#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.bignerdranch.coreData" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"coreData.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    _managedObjectContext.undoManager = [[NSUndoManager alloc]init];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
