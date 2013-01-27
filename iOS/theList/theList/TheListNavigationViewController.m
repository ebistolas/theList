//
//  TheListNavigationViewController.m
//  theList
//
//  Created by Eugene Bistolas on 1/26/13.
//  Copyright (c) 2013 Eugene Bistolas. All rights reserved.
//

#import "TheListNavigationViewController.h"

@interface TheListNavigationViewController ()

@end

@implementation TheListNavigationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navView = [[NavigationView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, NAVBAR_HEIGHT)];
        self.view.layer.shadowColor = [UIColor darkGrayColor].CGColor;
        self.view.layer.shadowOffset = CGSizeMake(0, 0);
        self.view.layer.shadowRadius = 4.0f;
        [self.view addSubview:self.navView];
        CALayer *lineLayer = [CALayer layer];
        CGRect newframe = CGRectMake(0, NAVBAR_HEIGHT, self.view.bounds.size.width, 1);
        lineLayer.frame = newframe;
        lineLayer.backgroundColor = [UIColor lightGrayColor].CGColor;
        lineLayer.opacity = 0.5;
        [self.navView.layer addSublayer:lineLayer];
        
        self.navView.delegate = self;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {

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

#pragma mark nav view delegate

-(void)leftBarButtonPressed {
    [self popViewControllerAnimated:YES];
}

-(void)rightBarButtonPressed {
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:SEARCH_NOTIFICATION object:nil]];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self.navView pushingViewControllerWithTotalViews:[self.viewControllers count] + 1];
    [super pushViewController:viewController animated:animated];
    
}

-(UIViewController*)popViewControllerAnimated:(BOOL)animated {
    [self.navView pushingViewControllerWithTotalViews:[self.viewControllers count] - 1];
    return [super popViewControllerAnimated:animated];
}


@end
