//
//  UserDetailViewController.m
//  theList
//
//  Created by Donald Percivalle on 1/26/13.
//  Copyright (c) 2013 Eugene Bistolas. All rights reserved.
//

#import "UserDetailViewController.h"
#import "LaunchScreenViewController.h"

@interface UserDetailViewController ()

@end

@implementation UserDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
   {
    self = [super initWithNibName:nil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization   
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goBack:(id)sender {
   NSLog(@"Should dismiss and go home");
   [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (void)setSelectedUser:(PFUser *)user{
//   PFQuery *query = [PFUser query];
//   [query whereKey:@"FBid" equalTo:userFBid];
//   NSArray *users = [query findObjects];
//   self.user = [users objectAtIndex:0];
   self.user = user;

   UIButton *back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
   [back setTitle:@"Back" forState:UIControlStateNormal];
   [back addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
   back.frame = CGRectMake(250, 520, 50, 40);
   [self.view addSubview:back];

   self.view.backgroundColor = [UIColor whiteColor];
      // Do any additional setup after loading the view.
      //Get all revlevant data from User in Parse database
   NSString *username = [self.user objectForKey:@"FBid"];
   NSLog(@"Username is %@", username);
   NSString *name = [self.user objectForKey:@"name"];
   NSLog(@"Name is %@", name);
   NSString *location = [self.user objectForKey:@"location"];
   NSLog(@"Location is %@", location);
   NSString *bio = [self.user objectForKey:@"bio"];
   NSLog(@"Bio is %@", bio);
   NSString *email = [self.user objectForKey:@"email"];
   NSLog(@"Email is %@", email);
   NSString *gender = [self.user objectForKey:@"gender"];
   NSLog(@"Gender is %@", gender);

      //Get Profile picture from Facebook and present it large in a UIImageView
   NSString *picURLtarget = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", username];
   NSURL *picURL = [NSURL URLWithString:picURLtarget];
   UIImage *profilePic = [UIImage imageWithData: [NSData dataWithContentsOfURL:picURL]];
   UIImageView *picView = [[UIImageView alloc] initWithImage:profilePic];
      //Make profile pictures cirlces
   CGSize picSize = [profilePic size];
   [picView setFrame:CGRectMake(160.0-(picSize.width/2.0), 90, picSize.width, picSize.height)];

      //User info displayed underneath profile picture
   UILabel *profName = [[UILabel alloc] initWithFrame:CGRectMake(40, picSize.height + 100, 240, 40)];
   profName.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:35];
   profName.textAlignment = NSTextAlignmentCenter;
   profName.text = name;
   UILabel *profEmail = [[UILabel alloc] initWithFrame:CGRectMake(0, picSize.height + 140, 320, 40)];
   profEmail.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20];
   profEmail.textAlignment = NSTextAlignmentCenter;
   profEmail.text = email;
   UILabel *profLoc = [[UILabel alloc] initWithFrame:CGRectMake(0, picSize.height + 180, 320, 40)];
   profLoc.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:20];
   profLoc.textAlignment = NSTextAlignmentCenter;
   profLoc.text = location;
   if (bio != nil) {
      UITextView *profBio = [[UITextView alloc] initWithFrame:CGRectMake(0, picSize.height + 220, 320, 90)];
      profBio.editable = NO;
      profBio.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:15];
      profBio.textAlignment = NSTextAlignmentCenter;
      profBio.text = bio;
      [self.view addSubview:profBio];
   }
      //Add elements to view
   [self.view addSubview:picView];
   [self.view addSubview:profName];
   [self.view addSubview:profEmail];
   [self.view addSubview:profLoc];

   NSLog(@"Current user is %@", [PFUser currentUser].email);
}

@end
