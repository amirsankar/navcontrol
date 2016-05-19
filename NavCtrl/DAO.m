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
+ (id)sharedManager {
    @synchronized(self) {
        if(sharedMyManager == nil)
            sharedMyManager = [[super allocWithZone:NULL] init];
    }
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {

        
    }
    return self;
}



@end
