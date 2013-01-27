//
//  LaunchScreenViewController.m
//  theList
//
//  Created by Eugene Bistolas on 1/26/13.
//  Copyright (c) 2013 Eugene Bistolas. All rights reserved.
//

#import "LaunchScreenViewController.h"

@interface LaunchScreenViewController ()

@end

@implementation LaunchScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(50, 50, 200, 50);
    [button addTarget:self action:@selector(searchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"SEARCH!!!" forState:UIControlStateNormal];
    [self.view addSubview:button];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchButtonPressed:(id)button {
    SearchResultsViewController *srvc = [[SearchResultsViewController alloc] initWithClassName:LISTING_CLASS];
    [self.navigationController pushViewController:srvc animated:YES];
}

@end
