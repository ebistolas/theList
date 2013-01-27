//
//  SearchResultsViewController.m
//  theList
//
//  Created by Eugene Bistolas on 1/26/13.
//  Copyright (c) 2013 Eugene Bistolas. All rights reserved.
//

#import "SearchResultsViewController.h"

@interface SearchResultsViewController ()

@end

@implementation SearchResultsViewController

- (id)initWithStyle:(UITableViewStyle)style query:(PFQuery*)query title:(NSString*)text
{
    self = [super initWithStyle:style];
    if (self) {
        [self.tableView registerClass:[SearchResultsImageCell class] forCellReuseIdentifier:@"cell"];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        UIEdgeInsets topInset = UIEdgeInsetsMake(NAVBAR_HEIGHT, 0, 0, 0);
        [self.tableView setContentInset:topInset];
        [self.tableView setScrollIndicatorInsets:topInset];
        self.query = query;
        self.queryTitle = text;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    lv = [[GmailLikeLoadingView alloc] initWithFrame:CGRectMake(135, 135, 50, 50)];
    [self.view addSubview:lv];
    lv.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchButtonPressed:) name:SEARCH_NOTIFICATION object:nil];

}

- (void)setQuery:(PFQuery *)query {
    [_query cancel];
    _query = query;
    NSLog(@"Kicking off a query");
    //Kick off query
    self.searchResults = nil;
    [self.tableView reloadData];
    lv.hidden = NO;
    [lv startAnimating];
    _navView.titleLabel.text = self.queryTitle;
    [_query findObjectsInBackgroundWithBlock:^(NSArray* objs, NSError *err) {
        NSLog(@"Error: %@", err);
        if (!err) {
            self.searchResults = objs;
            NSLog(@"Got %d search results", [self.searchResults count]);
            [self.tableView reloadData];
            [lv stopAnimating];
            lv.hidden = YES;
        }
    }];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    _navView = ((TheListNavigationViewController*)self.navigationController).navView;
    _navView.hidden = NO;
    _navView.titleLabel.text = self.queryTitle;
    _navView.rightBarButtonImage.image = [UIImage imageNamed:@"search_icon.png"];
    NSLog(@"Nav controller; %@", self.navigationController);
    
    //Make the search bar
   //sv = [[SearchView alloc] initWithFrame:CGRectMake(0, NAVBAR_HEIGHT+1, self.view.bounds.size.width, SEARCH_HEIGHT)];
    //[_navView addSubview:sv];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (sv) {
        [sv removeFromSuperview];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchButtonPressed:(NSNotification*)note {
    NSLog(@"|----search button pressed!");
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    SearchResultsImageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.listing = [self.searchResults objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListingDetailViewController *ldvc = [[ListingDetailViewController alloc] init];
    ldvc.listings = self.searchResults;
    ldvc.listingIndex = indexPath.row;
    ldvc.currentListing = [self.searchResults objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:ldvc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150.0f;
}

#pragma mark scroll view delegates

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    /*
    //NSLog(@"Scroll velocity: %f", scrollView scrollingSp)
    if (scrollView.contentOffset.y > -44) {
        __block CGAffineTransform transform;
        
        if (scrollView.contentOffset.y < 0) {
            transform = CGAffineTransformMakeTranslation(0, -(scrollView.contentOffset.y + NAVBAR_HEIGHT));
            _navView.transform = transform;
        }
        else {
            [UIView animateWithDuration:0.3 animations:^{
                transform = CGAffineTransformMakeTranslation(0, -NAVBAR_HEIGHT);
                _navView.transform = transform;
            }];
        }
    }
    else {
        _navView.transform = CGAffineTransformIdentity;
    }
     */
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    /*
    [UIView animateWithDuration:0.3 animations:^{
        _navView.transform = CGAffineTransformIdentity;

    }];*/
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    /*
    if (!decelerate) {
        [UIView animateWithDuration:0.3 animations:^{
            _navView.transform = CGAffineTransformIdentity;
            
        }];
    }*/
}

@end
