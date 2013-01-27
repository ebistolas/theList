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
    
    //Setup nav bar
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(50, 100, 200, 50);
    [button addTarget:self action:@selector(searchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"SEARCH!!!" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    
    //update images
    /*
    for (int i = 0; i < 10; i++) {
        PFObject *newObject = [[PFObject alloc] initWithClassName:LISTING_CLASS];
        [newObject setObject:[NSString stringWithFormat:@"Test item %d", arc4random()%50] forKey:@"title"];
        [newObject setObject:[NSNumber numberWithFloat:25] forKey:LISTING_PRICE];
        [newObject setObject:@"HELLO WORLD THIS IS A DESCRIPTION" forKey:LISTING_DESCRIPTION];
        [newObject setObject:@"other" forKey:LISTING_CATEGORY];
        PFFile *f = [PFFile fileWithData:UIImagePNGRepresentation([UIImage imageNamed:@"fattestcat.jpg"])];
        [f saveInBackground];
        [newObject setObject:@[f] forKey:LISTING_IMAGES];
        [newObject saveInBackground];
    }*/
    

    
    /*
    
    PFQuery *objQuery = [PFQuery queryWithClassName:LISTING_CLASS];
    PFObject *car = [objQuery getObjectWithId:@"x4MJPlWPzg"];
    [car setObjectId:@"asdf"];
    PFFile *carImage = [PFFile fileWithData:UIImagePNGRepresentation([UIImage imageNamed:@"iPhone.jpeg"])];
    [carImage saveInBackground];
    [car setObject:@[carImage] forKey:LISTING_IMAGES];
    [car saveInBackground];
    
    
    
    PFObject *fixie = [objQuery getObjectWithId:@"Kam8DUJwLw"];
    PFFile *f1 = [PFFile fileWithData:UIImagePNGRepresentation([UIImage imageNamed:@"fixie1.jpg"])];
    [f1 saveInBackground];
    PFFile *f2 = [PFFile fileWithData:UIImagePNGRepresentation([UIImage imageNamed:@"fixie2.jpg"])];
    [f2 saveInBackground];
    
    PFFile *f3 = [PFFile fileWithData:UIImagePNGRepresentation([UIImage imageNamed:@"fixie3.jpg"])];
    [f3 saveInBackground];
    
    [fixie setObject:@[f1, f2, f3] forKey:LISTING_IMAGES];
    [fixie saveInBackground];
    
    PFObject *camera = [objQuery getObjectWithId:@"IKc3WaTfnX"];
    PFFile *c = [PFFile fileWithData:UIImagePNGRepresentation([UIImage imageNamed:@"fatcat.jpg"])];
    [c saveInBackground];
    [camera setObject:@[c] forKey:LISTING_IMAGES];
    [camera saveInBackground];
    
    PFObject *lappie = [objQuery getObjectWithId:@"RhpOg4oxyL"];
    PFFile *l = [PFFile fileWithData:UIImagePNGRepresentation([UIImage imageNamed:@"macbook.png"])];
    [l saveInBackground];
    [lappie setObject:@[l] forKey:LISTING_IMAGES];
    [lappie saveInBackground];*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchButtonPressed:(id)button {
    SearchResultsViewController *srvc = [[SearchResultsViewController alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:srvc animated:YES];
}



@end
