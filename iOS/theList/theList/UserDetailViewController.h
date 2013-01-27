//
//  UserDetailViewController.h
//  theList
//
//  Created by Donald Percivalle on 1/26/13.
//  Copyright (c) 2013 Eugene Bistolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TheListNavigationViewController.h"

@interface UserDetailViewController : TheListNavigationViewController

@property (nonatomic, strong) PFUser *user;

- (void)setSelectedUser:(PFUser *)user;


@end
