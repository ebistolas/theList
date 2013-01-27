//
//  LaunchScreenViewController.m
//  theList
//
//  Created by Eugene Bistolas on 1/26/13.
//  Copyright (c) 2013 Eugene Bistolas. All rights reserved.
//

#import "LaunchScreenViewController.h"

@interface LaunchScreenViewController ()

@property (nonatomic, strong) UIImageView *logo;
@property (nonatomic, strong) UIImageView *burger;
@property (nonatomic, strong) UITextField *searchField;
@property (nonatomic, strong) UIImageView *searchButtonImage;

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

    [super viewDidLoad];

    
    //Set up the mothafuckin launch screen.
    UIImageView *launchImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"launch_background_photo.png"]];
    launchImage.frame = self.view.bounds;
    [self.view addSubview:launchImage];
    
    //mothafuckin hamburgers
    self.burger = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hamburger.png"]];
    self.burger.frame = CGRectMake(7, 3, 30, 30);
    [self.view addSubview:self.burger];
    
    self.logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_launchpage.png"]];
    self.logo.frame = CGRectMake(0, 110, self.view.bounds.size.width, 224);
    [self.view addSubview:self.logo];
    
    //Text search box
    self.searchField = [[UITextField alloc] initWithFrame:CGRectMake(15, 350, 240, 33)];
    self.searchField.delegate = self;
    self.searchField.placeholder = @" What are you looking for?";
    self.searchField.font = [UIFont fontWithName:@"SourceSansPro-Light" size:22];
    self.searchField.adjustsFontSizeToFitWidth = YES;
    self.searchField.borderStyle = UITextBorderStyleRoundedRect;
    self.searchField.backgroundColor = [UIColor whiteColor];
    self.searchField.layer.shadowColor = [UIColor blackColor].CGColor;
    self.searchField.layer.shadowOffset = CGSizeMake(0, 2);
    self.searchField.layer.shadowRadius = 6;
    self.searchField.layer.shadowOpacity = 1;
    self.searchField.clipsToBounds = NO;
    self.searchField.returnKeyType = UIReturnKeySearch;

    [self.view addSubview:self.searchField];
    
    self.searchButtonImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_icon.png"]];
    self.searchButtonImage.frame = CGRectMake(self.searchField.frame.size.width + 30, self.searchField.frame.origin.y, 31,31);
    [self.view addSubview:self.searchButtonImage];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame = self.searchButtonImage.frame;
    [searchButton addTarget:self action:@selector(searchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //Notifications
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowOrHide:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowOrHide:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [tapGesture setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapGesture];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NavigationView *navView = ((TheListNavigationViewController*)self.navigationController).navView;
    navView.hidden = YES;
    
    CGRect logoRect = self.logo.frame;
    logoRect.origin.y = 40;
    
    self.burger.alpha = 0;
    self.searchField.alpha = 0;
    self.searchButtonImage.alpha = 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        //self.logo.frame = logoRect;
        self.burger.alpha = 1;
        self.searchField.alpha = 1;
        self.searchButtonImage.alpha = 1;

    } completion:^(BOOL finished){
    }];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NavigationView *navView = ((TheListNavigationViewController*)self.navigationController).navView;
    navView.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchButtonPressed:(id)button {
    if ([self.searchField.text length]) {
        [self searchWithText:self.searchField.text];
    }
    
}

-(void)keyboardDidShowOrHide:(NSNotification*)note {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect logoRect = self.logo.frame;
        CGRect searchFieldRect = self.searchField.frame;
        CGRect searchButtonRect = self.searchButtonImage.frame;
        
        if ([[note name] isEqualToString:UIKeyboardWillHideNotification]) {
            logoRect.origin.y += 80;
            searchFieldRect.origin.y += 80;
            searchButtonRect.origin.y += 80;
        } else if ([[note name] isEqualToString:UIKeyboardWillShowNotification]) {
            logoRect.origin.y -= 80;
            searchFieldRect.origin.y -= 80;
            searchButtonRect.origin.y -= 80;
        }
        
        self.logo.frame = logoRect;
        self.searchField.frame = searchFieldRect;
        self.searchButtonImage.frame = searchButtonRect;
        
    }completion:^(BOOL finished){
        
    }];
}

-(void)handleTap:(UIGestureRecognizer*)gesture{
    [self.searchField.textInputView resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if ([textField.text length]) {
        [self searchWithText:textField.text];
    }
    return YES;
}

-(void)searchWithText:(NSString*)text {
    //Construct a new query
    
    PFQuery *titleQueryCaps = [PFQuery queryWithClassName:LISTING_CLASS];
    PFQuery *titleQuery = [PFQuery queryWithClassName:LISTING_CLASS];
    [titleQueryCaps whereKey:LISTING_TITLE containsString:text];
    [titleQuery whereKey:LISTING_TITLE containsString:[text lowercaseString]];
    PFQuery *descriptionQueryCaps = [PFQuery queryWithClassName:LISTING_CLASS];
    PFQuery *descriptionQuery = [PFQuery queryWithClassName:LISTING_CLASS];
    [descriptionQueryCaps whereKey:LISTING_DESCRIPTION containsString:text];
    [descriptionQuery whereKey:LISTING_DESCRIPTION containsString:[text lowercaseString]];

    PFQuery *query = [PFQuery orQueryWithSubqueries:@[titleQuery, titleQueryCaps, descriptionQuery, descriptionQueryCaps]];
    
    
    SearchResultsViewController *svc = [[SearchResultsViewController alloc] initWithStyle:UITableViewStylePlain query:query title:text];
    NavigationView *navView = ((TheListNavigationViewController*)self.navigationController).navView;
    navView.hidden = NO;
    navView.titleLabel.text = text;
    [self.navigationController pushViewController:svc animated:YES];
}

@end
