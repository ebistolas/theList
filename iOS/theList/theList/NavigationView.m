//
//  NavigationView.m
//  theList
//
//  Created by Eugene Bistolas on 1/26/13.
//  Copyright (c) 2013 Eugene Bistolas. All rights reserved.
//

#import "NavigationView.h"

@implementation NavigationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = PRICE_COLOR;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //Setup logo label
    self.alpha = 0.9;
    
    //Titlebar text
    self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.titleLabel.font = [UIFont fontWithName:@"SourceSansPro-SemiboldIt" size:28];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    
    //Buttons
    UIButton *leftBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarButton setFrame:CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height)];
    [leftBarButton addTarget:self action:@selector(leftBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton setFrame:CGRectMake(self.bounds.size.width - self.bounds.size.height, 0, self.bounds.size.height, self.bounds.size.height)];
    [rightBarButton addTarget:self action:@selector(rightBarButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    leftBarButton.backgroundColor = [UIColor clearColor];
    rightBarButton.backgroundColor = [UIColor clearColor];
    [self addSubview:leftBarButton];
    [self addSubview:rightBarButton];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(7, 7, 7, 7);
    self.rightBarButtonImage = [[UIImageView alloc] initWithFrame:UIEdgeInsetsInsetRect(rightBarButton.frame, padding)];
    self.leftBarButtonImage = [[UIImageView alloc] initWithFrame:UIEdgeInsetsInsetRect(leftBarButton.frame, padding)];

    self.rightBarButtonImage.alpha = self.leftBarButtonImage.alpha = 0.75;
    [self addSubview:self.rightBarButtonImage];
    [self addSubview:self.leftBarButtonImage];
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowRadius = 4;
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowOffset = CGSizeMake(0, 0);
}

-(void)leftBarButtonPressed:(id)sender {
    NSLog(@"Left bar button pressed");
    [_delegate leftBarButtonPressed];
    
}

-(void)rightBarButtonPressed:(id)sender {
    NSLog(@"Right bar button pressed");
    [_delegate rightBarButtonPressed];
}

-(void)pushingViewControllerWithTotalViews:(int)total {
    //we have more than 1 vc, set image.
    if (total > 1) {
        NSLog(@"Adding back button");
        if (self.leftBarButtonImage.image == nil) {
            self.leftBarButtonImage.alpha = 0;
            [self.leftBarButtonImage setImage:NAVBAR_BACKIMG];
            [UIView animateWithDuration:0.3 animations:^{
                self.leftBarButtonImage.alpha = 0.75;
            }];
        }
    }
    else {
        NSLog(@"removing back button");
        [UIView animateWithDuration:0.3 animations:^{
            self.leftBarButtonImage.alpha = 0.0;
        } completion:^(BOOL finished) {
            self.leftBarButtonImage.image = nil;
        }];
    }
}




@end
