//
//  SearchResultsViewController.h
//  theList
//
//  Created by Eugene Bistolas on 1/26/13.
//  Copyright (c) 2013 Eugene Bistolas. All rights reserved.
//

#import <Parse/Parse.h>
#import "SearchResultsListCell.h"
#import "SearchResultsImageCell.h"

@interface SearchResultsViewController : PFQueryTableViewController

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *titleLabel;
@property (nonatomic, strong) NSString *descriptionLabel;
@property (nonatomic, strong) NSString *priceString;


@end
