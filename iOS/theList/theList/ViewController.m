//
//  ViewController.m
//  theList
//
//  Created by Eugene Bistolas on 1/26/13.
//  Copyright (c) 2013 Eugene Bistolas. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Mock up some dummy objects for testing
    PFObject *testObj1 = [PFObject objectWithClassName:@"listing"];
    [testObj1 setObject:@"HIP FIXIE" forKey:@"title"];
    [testObj1 setObject:@"Buy my sick ass bike" forKey:@"description"];
    [testObj1 setObject:[NSNumber numberWithFloat:150.00] forKey:@"price"];
    [testObj1 setObject:@[@"hipster", @"tight", @"bike"] forKey:@"tags"];
    [testObj1 setObject:@"bikes" forKey:@"category"];
    [testObj1 setObject:[NSNumber numberWithBool:NO] forKey:@"sold"];
    [testObj1 setObject:[NSNumber numberWithInt:12345] forKey:@"user"];
    
    
    [testObj1 saveInBackground];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
