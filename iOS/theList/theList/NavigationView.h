//
//  NavigationView.h
//  theList
//
//  Created by Eugene Bistolas on 1/26/13.
//  Copyright (c) 2013 Eugene Bistolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol NavViewProtocol
- (void)leftBarButtonPressed;
- (void)rightBarButtonPressed;

@end

@interface NavigationView : UIView

@property (nonatomic, strong) UIImageView *rightBarButtonImage;
@property (nonatomic, strong) UIImageView *leftBarButtonImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, weak) id<NavViewProtocol> delegate;

-(void)pushingViewControllerWithTotalViews:(int)total;



@end


