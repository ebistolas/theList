//
//  SearchManager.m
//  theList
//
//  Created by Eugene Bistolas on 1/26/13.
//  Copyright (c) 2013 Eugene Bistolas. All rights reserved.
//

#import "SearchManager.h"

@implementation SearchManager

#pragma mark sharedSearchManager

+(SearchManager*)sharedSearchManager {
    static SearchManager *sSearchManager;
    if (sSearchManager == nil) {
        sSearchManager = [[SearchManager alloc] init];
    }
    return sSearchManager;
}

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSArray*)allListings {
    PFQuery *allObjectsQuery = [PFQuery queryWithClassName:LISTING_CLASS];
    //allObjectsQuery
}

@end
