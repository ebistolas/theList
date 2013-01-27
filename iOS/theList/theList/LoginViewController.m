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
         //DISMISS MODAL VIEW CONTROLLER AND SEND USER TO SEARCH/LAUNCH VIEW
   }

      // Do any additional setup after loading the view.
   UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 360, 50)];
   [self.view addSubview:navBar];

   UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [loginButton addTarget:self action:@selector(signUp:) forControlEvents:UIControlEventTouchUpInside];
   [loginButton setTitle:@"Login with Facebook" forState:UIControlStateNormal];
   loginButton.frame = CGRectMake(20, 110, 280, 40);
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
            //USER IS NEW!! SET UP WITH ALL NECESSARY INFORMATION
         NSLog(@"User signed up and logged in through Facebook!");
         NSString *requestPath = @"me/?fields=name,location,gender,email,bio,username";

            // Send request to Facebook
         PF_FBRequest *request = [PF_FBRequest requestForGraphPath:requestPath];
         [request startWithCompletionHandler:^(PF_FBRequestConnection *connection, id result, NSError *error) {
            if (!error) {
               NSDictionary *userData = (NSDictionary *)result; // The result is a dictionary

                  //Set basic user data from Facebook
               NSLog(@"User facebook ID is %@", userData[@"id"]);
               [user setObject:userData[@"username"] forKey:@"FBid"];
               NSLog(@"Username should be %@", userData[@"name"]);
               [user setObject:userData[@"name"] forKey:@"name"];
               NSLog(@"User location should be %@", userData[@"location"]);
               [user setObject:userData[@"location"][@"name"] forKey:@"location"];
               NSLog(@"User gender should be %@", userData[@"gender"]);
               [user setObject:userData[@"gender"] forKey:@"gender"];
               NSLog(@"User email should be %@", userData[@"email"]);
               [user setObject:userData[@"email"] forKey:@"email"];
               if (userData[@"bio"] != nil) {
                  NSLog(@"User bio added now");
                  [user setObject:userData[@"bio"] forKey:@"bio"];
               }
               [user save];
               [self presentViewController:[[UserDetailViewController alloc] initWithNibName:nil bundle:nil]
                                  animated:YES completion:nil];
            }
         }];

      }
      else {
         NSLog(@"User logged in through Facebook!");
            //DISMISS LOGIN VIEW AND BRING USER TO SEARCH/LAUNCH VIEW
         [self presentViewController:[[UserDetailViewController alloc] initWithNibName:nil bundle:nil]
                            animated:YES completion:nil];
      }
   }];

   
}

@end