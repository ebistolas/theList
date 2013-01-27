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
   [loginButton addTarget:self action:@selector(signUp:) forControlEvents:UIControlEventTouchDown];
   [loginButton setTitle:@"Login with Facebook" forState:UIControlStateNormal];
   loginButton.frame = CGRectMake(20, 210, 280, 40);
   [self.view addSubview:loginButton];
}

- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
      // Dispose of any resources that can be recreated.
}



- (IBAction)signUp:(id)sender {
   NSArray *permissions = @[@"user_about_me", @"user_location", @"email"];
   [PFFacebookUtils logInWithPermissions:permissions block:^(PFUser *user, NSError *error) {
      if (!user) {
         if (!error) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
         }
         else {
            NSLog(@"Uh oh. An error occurred: %@", error);
         }
      }
      else if (user.isNew) {
         NSLog(@"User signed up and logged in through Facebook!");
      } else {
         NSLog(@"User logged in through Facebook!");
      }
   }];
}

@end
