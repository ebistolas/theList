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

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        [self.tableView registerClass:[SearchResultsImageCell class] forCellReuseIdentifier:@"cell"];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        UIEdgeInsets topInset = UIEdgeInsetsMake(NAVBAR_HEIGHT, 0, 0, 0);
        [self.tableView setContentInset:topInset];
        [self.tableView setScrollIndicatorInsets:topInset];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //TODO we need a search manager
    
    //Kick off query
    self.query = [PFQuery queryWithClassName:LISTING_CLASS];
    [self.query findObjectsInBackgroundWithBlock:^(NSArray* objs, NSError *err) {
        if (!err) {
            self.searchResults = objs;
            [self.tableView reloadData];
        }
    }];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    _navView = ((TheListNavigationViewController*)self.navigationController).navView;
    
    NSLog(@"Nav controller; %@", self.navigationController);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130.0f;
}

#pragma mark scroll view delegates

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
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
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [UIView animateWithDuration:0.3 animations:^{
        _navView.transform = CGAffineTransformIdentity;

    }];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [UIView animateWithDuration:0.3 animations:^{
            _navView.transform = CGAffineTransformIdentity;
            
        }];
    }
}

@end
