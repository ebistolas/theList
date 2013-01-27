//
//  TheListNavigationViewController.h
//  theList
//
//  Created by Eugene Bistolas on 1/26/13.
//  Copyright (c) 2013 Eugene Bistolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationView.h"

@interface TheListNavigationViewController : UINavigationController <NavViewProtocol>

@property (nonatomic, strong) NavigationView* navView;

@end
