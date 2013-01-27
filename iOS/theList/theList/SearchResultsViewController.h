//
//  SearchResultsViewController.h
//  theList
//
//  Created by Eugene Bistolas on 1/26/13.
//  Copyright (c) 2013 Eugene Bistolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultsImageCell.h"
#import "NavigationView.h"
#import "TheListNavigationViewController.h"

@interface SearchResultsViewController : UITableViewController {
    NavigationView *_navView;
}

@property (nonatomic, strong) PFQuery *query;
@property (nonatomic, strong) NSArray *searchResults;

@end
