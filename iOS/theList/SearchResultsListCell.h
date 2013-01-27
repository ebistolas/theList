//
//  SearchResultsListCell.h
//  theList
//
//  Created by Eugene Bistolas on 1/26/13.
//  Copyright (c) 2013 Eugene Bistolas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultsListCell : UITableViewCell {
    UILabel *_titleLabel;
    UILabel *_descriptionLabel;
    UILabel *_priceLabel;
}

@property (nonatomic, strong) PFObject *listing;

@end
