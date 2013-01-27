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
        [self.tableView registerClass:[SearchResultsImageCell class] forCellReuseIdentifier:@"cell"];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLineEtched];
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
    return 200.0f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultsImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[SearchResultsImageCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:@"cell"];
    }
    
    PFObject *dataObject = [self.objects objectAtIndex:indexPath.row];
    cell.listing = dataObject;
    
    
    return cell;
}

@end
