//
//  SearchResultsImageCell.m
//  theList
//
//  Created by Eugene Bistolas on 1/26/13.
//  Copyright (c) 2013 Eugene Bistolas. All rights reserved.
//

#import "SearchResultsImageCell.h"

@implementation SearchResultsImageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setListing:(PFObject *)listing {
    _listing = listing;
    [self setupCell];
}

- (void)setupCell {
    [self.textLabel removeFromSuperview];
    self.clipsToBounds = YES;
    
    scrollImageOffset = 0.0f;
    //Nab image
    NSArray *images = [self.listing objectForKey:LISTING_IMAGES];
    
    //Setup scroll view
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.delegate = self;
    self.scrollView.alwaysBounceHorizontal = NO;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.showsHorizontalScrollIndicator = self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
    [self addSubview:self.scrollView];
    
    for (PFFile *image in images) {
        [image getDataInBackgroundWithBlock:^(NSData* data, NSError *error) {
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:data]];
            CGRect frame = self.bounds;
            imageView.layer.borderColor = [UIColor whiteColor].CGColor;
            imageView.layer.borderWidth = 1.0f;
            frame.origin.x = scrollImageOffset;
            scrollImageOffset += self.bounds.size.width;
            self.scrollView.contentSize = CGSizeMake(scrollImageOffset, self.bounds.size.height);
            imageView.frame = frame;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView.clipsToBounds = YES;
            
            [self.scrollView addSubview:imageView];
            
            imageView.alpha = 0;
            [UIView animateWithDuration:0.3 animations:^{
                imageView.alpha = 1;
            }];
        }];
    }
    
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 40, self.bounds.size.width, 40)];
    titleView.alpha = 0.8;
    titleView.backgroundColor = [UIColor whiteColor];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = titleView.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor, (id)[UIColor clearColor].CGColor, nil];
    gradientLayer.startPoint = CGPointMake(1.0f, 0.5f);
    gradientLayer.endPoint = CGPointMake(1.0f, 1.0f);
    //titleView.layer.mask = gradientLayer;
    //TODO fix this.
    
    NSString *title = [self.listing objectForKey:LISTING_TITLE];
    NSString *price = [NSString stringWithFormat:@"$%@",[self.listing objectForKey:LISTING_PRICE]];
    
    UIEdgeInsets insetPadding = UIEdgeInsetsMake(0, 10, 0, 10);
    CGRect titleRect = UIEdgeInsetsInsetRect(CGRectMake(0, titleView.frame.origin.y, titleView.bounds.size.width * 0.75, titleView.bounds.size.height), insetPadding);
    _titleLabel = [[UILabel alloc] initWithFrame:titleRect];
    _titleLabel.text = title;
    _titleLabel.textColor = [UIColor darkGrayColor];
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = TEXT_COLOR;
    _titleLabel.font = [UIFont fontWithName:@"Rambla" size:24];
    
    CGRect priceRect = UIEdgeInsetsInsetRect(CGRectMake(titleView.bounds.size.width * 0.75, titleView.frame.origin.y, titleView.bounds.size.width * 0.25, titleView.bounds.size.height), insetPadding);
    _priceLabel = [[UILabel alloc] initWithFrame:priceRect];
    _priceLabel.text = price;
    _priceLabel.textColor = [UIColor darkGrayColor];
    _priceLabel.adjustsFontSizeToFitWidth = YES;
    _priceLabel.backgroundColor = [UIColor clearColor];
    _priceLabel.font = [UIFont fontWithName:@"Rambla-BoldItalic" size:24];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.textColor = PRICE_COLOR;

    [self addSubview:titleView];
    [self addSubview:_titleLabel];
    [self addSubview:_priceLabel];
    
}

@end
