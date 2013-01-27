//
//  SearchResultsViewController.m
//  theList
//
//  Created by Eugene Bistolas on 1/26/13.
//  Copyright (c) 2013 Eugene Bistolas. All rights reserved.
//

#import "SearchResultsViewController_OLD.h"

@interface SearchResultsViewController_OLD ()

@end

@implementation SearchResultsViewController_OLD

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
    return 100.0f;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchResultsImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    PFObject *dataObject = [self.objects objectAtIndex:indexPath.row];

    if (cell == nil) {
        cell = [[SearchResultsImageCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:@"cell" listing:dataObject];
    }
    else {
        NSLog(@"|--reusing old cell");
        cell.listing = dataObject;
    }

    
    return cell;
}

@end
