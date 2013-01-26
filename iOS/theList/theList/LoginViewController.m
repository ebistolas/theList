//
//  LoginViewController.m
//  theList
//
//  Created by Donald Percivalle on 1/26/13.
//  Copyright (c) 2013 Eugene Bistolas. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

   if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
      NSLog(@"User cached");
   }

   // Do any additional setup after loading the view.
   UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [loginButton addTarget:self action:@selector(loginButtonTouchHandler:) forControlEvents:UIControlEventTouchDown];
   [loginButton setTitle:@"Login with Facebook" forState:UIControlStateNormal];
   loginButton.frame = CGRectMake(20, 210, 280, 40);
   [self.view addSubview:loginButton];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonTouchHandler:(id)sender  {
      // The permissions requested from the user
   NSArray *permissionsArray = @[ @"user_about_me", @"user_location", @"email"];
      // Login PFUser using Facebook
   [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
      if (!user) {
         if (!error) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
         } else {
            NSLog(@"Uh oh. An error occurred: %@", error);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
            [alert show];
         }
         
      } else if (user.isNew) {
         NSLog(@"User with facebook signed up and logged in!");
      } else {
         NSLog(@"User with facebook logged in!");
      }      
   }];
}

@end
