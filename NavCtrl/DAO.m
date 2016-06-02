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
        [self getCompanysAndProducts];

    }
    return self;
}

-(void)getCompanysAndProducts
{
    Product *ipad = [[Product alloc]initName:@"iPad" andURL:@"http://www.apple.com/ipad/" andImage:@"ipad_pic.jpg"];
    Product *ipod = [[Product alloc]initName:@"iPod Touch" andURL:@"http://www.apple.com/ipod/" andImage:@"ipod_pic.png"];
    Product *iphone = [[Product alloc]initName:@"iPhone" andURL:@"http://www.apple.com/iphone/" andImage:@"iphone_pic.jpg"];
    Product *s4 = [[Product alloc]initName:@"Galaxy S4" andURL:@"http://www.samsung.com/us/mobile/cell-phones/SCH-I545ZWAVZW" andImage:@"galaxys4.jpg"];
    Product *note = [[Product alloc]initName:@"Galaxy Note" andURL:@"http://www.samsung.com/us/explore/galaxy-note-5-features-and-specs/?cid=ppc-" andImage:@"galaxyNote.png"];
    Product *tab = [[Product alloc]initName:@"Galaxy Tab" andURL:@"http://www.samsung.com/us/explore/tab-s2-features-and-specs/?cid=ppc-" andImage:@"galaxyTab.jpg"];
    Product *jetta = [[Product alloc]initName:@"Jetta" andURL:@"http://www.vw.com/models/jetta/?&cid=ssem_XxWHHIvB_95913081306_c" andImage:@"Jetta.jpg"];
    Product *passat = [[Product alloc]initName:@"Passat" andURL:@"http://www.vw.com/models/passat/?&cid=ssem_Q9LIdBM9_95913100146_c" andImage:@"Passat.jpg"];
    Product *golf = [[Product alloc]initName:@"Golf" andURL:@"http://www.vw.com/models/golf/?&cid=ssem_YcnZ1Yyk_96457705266_c" andImage:@"Golf.png"];
    Product *presidential = [[Product alloc]initName:@"Presidential" andURL:@"http://www.rolex.com/watches/day-date/m118205f-0107.html" andImage:@"presidential.jpg"];
    Product *submariner = [[Product alloc]initName:@"Submariner" andURL:@"http://www.rolex.com/watches/submariner/m114060-0002.html" andImage:@"submariner.jpg"];
    Product *yachtmaster = [[Product alloc]initName:@"Yacht Master" andURL:@"http://www.rolex.com/watches/yacht-master-ii/m116688-0001.html" andImage:@"yacht_master.jpg"];
    
    
    NSMutableArray *apple_products = [[NSMutableArray alloc]initWithArray:@[ipad, ipod, iphone]];
    Company *apple = [[Company alloc]initName:@"Apple" andImage:@"Apple_Logo.png" andProducts:apple_products andStock:@"AAPL"];

    NSMutableArray *samsung_products = [[NSMutableArray alloc]initWithArray:@[s4, note, tab]];
    Company *samsung = [[Company alloc]initName:@"Samsung" andImage:@"Samsung_logo.png" andProducts:samsung_products andStock:@"SSNLF"];

    NSMutableArray *volkswagen_products = [[NSMutableArray alloc]initWithArray:@[jetta, passat, golf]];
    Company *volkswagen = [[Company alloc]initName:@"Volkswagen" andImage:@"Volkswagen_logo.png" andProducts:volkswagen_products andStock:@"GM"];
    
    NSMutableArray *rolex_products = [[NSMutableArray alloc]initWithArray:@[presidential, submariner, yachtmaster]];
    Company *rolex = [[Company alloc]initName:@"Rolex" andImage:@"Rolex-logo.jpg" andProducts:rolex_products andStock:@"UA"];
    [rolex_products release];
    [volkswagen_products release];
    [samsung_products release];
    [apple_products release];
    
    self.companyList = [NSMutableArray arrayWithObjects:apple, samsung, volkswagen, rolex, nil];
    
}

@end
