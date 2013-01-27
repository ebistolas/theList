//
//  ListingDetailViewController.h
//  theList
//
//  Created by Eugene Bistolas on 1/27/13.
//  Copyright (c) 2013 Eugene Bistolas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListingDetailViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *listings;
@property (nonatomic, assign) int listingIndex;
@property (nonatomic, strong) PFObject *currentListing;

@end
