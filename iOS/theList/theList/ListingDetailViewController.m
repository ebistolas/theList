//
//  ListingDetailViewController.m
//  theList
//
//  Created by Eugene Bistolas on 1/27/13.
//  Copyright (c) 2013 Eugene Bistolas. All rights reserved.
//

#import "ListingDetailViewController.h"

@interface ListingDetailViewController ()

@end

@implementation ListingDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue:209/255.0 alpha:1];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	//Stuff in a scroll view
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.showsHorizontalScrollIndicator = scrollView.showsVerticalScrollIndicator = NO;
    scrollView.alwaysBounceHorizontal = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
