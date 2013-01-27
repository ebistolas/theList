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
#import "ListingDetailViewController.h"
#import "SearchView.h"
#import "GmailLikeLoadingView.h"

@interface SearchResultsViewController : UITableViewController {
    NavigationView *_navView;
    SearchView *sv;
    GmailLikeLoadingView *lv;
}

@property (nonatomic, strong) PFQuery *query;
@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic, strong) NSString *queryTitle;

- (id)initWithStyle:(UITableViewStyle)style query:(PFQuery*)query title:(NSString*)text;
@end
