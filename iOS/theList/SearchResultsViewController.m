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

- (id)initWithClassName:(NSString *)aClassName {
    self = [super initWithClassName:aClassName];
    if (self) {
        [self.tableView registerClass:[SearchResultsListCell class] forCellReuseIdentifier:@"cell"];
        NSLog(@"Class name is %@", aClassName);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView delegate stuff

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 84.0f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[SearchResultsListCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:@"cell"];
    }
    
    PFObject *dataObject = [self.objects objectAtIndex:indexPath.row];
    cell.textLabel.text = [dataObject objectForKey:LISTING_TITLE];
    
    return cell;
}

@end
