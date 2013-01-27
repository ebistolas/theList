//
//  UserDetailViewController.m
//  theList
//
//  Created by Donald Percivalle on 1/26/13.
//  Copyright (c) 2013 Eugene Bistolas. All rights reserved.
//

#import "UserDetailViewController.h"

@interface UserDetailViewController ()

@end

@implementation UserDetailViewController

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
   self.view.backgroundColor = [UIColor redColor];
      // Do any additional setup after loading the view.
   PFUser *user = [PFUser currentUser];
      //Get all revlevant data from User in Parse database
   NSString *username = [user objectForKey:@"FBid"];
   NSLog(@"Username is %@", username);
   NSString *name = [user objectForKey:@"name"];
   NSLog(@"Name is %@", name);
   NSString *location = [user objectForKey:@"location"];
   NSLog(@"Location is %@", location);
   NSString *bio = [user objectForKey:@"bio"];
   NSLog(@"Bio is %@", bio);
   NSString *email = [user objectForKey:@"email"];
   NSLog(@"Email is %@", email);
   NSString *gender = [user objectForKey:@"gender"];
   NSLog(@"Gender is %@", gender);
   
      //Get Profile picture from Facebook and present it large in a UIImageView
   NSString *picURLtarget = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", username];
   NSURL *picURL = [NSURL URLWithString:picURLtarget];
   UIImage *profilePic = [UIImage imageWithData: [NSData dataWithContentsOfURL:picURL]];
   [self.view addSubview:[[UIImageView alloc] initWithImage:profilePic]];

      //Create pretty UI elements to display all user info on a profile page
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
