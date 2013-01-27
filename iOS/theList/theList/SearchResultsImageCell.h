//
//  SearchResultsImageCell.h
//  theList
//
//  Created by Eugene Bistolas on 1/26/13.
//  Copyright (c) 2013 Eugene Bistolas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface SearchResultsImageCell : UITableViewCell <UIScrollViewDelegate> {
    UILabel *_titleLabel;
    UILabel *_descriptionLabel;
    UILabel *_priceLabel;
    CGFloat scrollImageOffset;
}

@property (nonatomic, strong) PFObject *listing;
@property (nonatomic, strong) UIScrollView *scrollView;

@end
