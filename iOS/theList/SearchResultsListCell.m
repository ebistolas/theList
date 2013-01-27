//
//  SearchResultsListCell.m
//  theList
//
//  Created by Eugene Bistolas on 1/26/13.
//  Copyright (c) 2013 Eugene Bistolas. All rights reserved.
//

#import "SearchResultsListCell.h"
#define LABEL_PADDING 15
#define PRICE_PADDING 70


@implementation SearchResultsListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupCell];
}

-(void)setupCell {
    [self.textLabel removeFromSuperview];
    
    //Nab image
    PFFile *imageFile = [[self.listing objectForKey:LISTING_IMAGES] objectAtIndex:0];
    
    UIEdgeInsets borderInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    CGRect imageFrame = UIEdgeInsetsInsetRect(CGRectMake(0, 0, self.bounds.size.height * 1.2, self.bounds.size.height), borderInsets);
    
    __block UIImageView *imageView = [[UIImageView alloc] initWithFrame:imageFrame];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    
    [imageFile getDataInBackgroundWithBlock:^(NSData* data, NSError *error) {
        if (!error) {
            [imageView setImage:[UIImage imageWithData:data]];
        }
    }];
    
    NSString *title = [self.listing objectForKey:LISTING_TITLE];
    NSString *description = [self.listing objectForKey:LISTING_DESCRIPTION];
    NSString *price = [NSString stringWithFormat:@"$%@",[self.listing objectForKey:LISTING_PRICE]];
        
    CGFloat xOffset = imageView.frame.size.width + LABEL_PADDING;
    
    CGRect titleFrame = UIEdgeInsetsInsetRect(CGRectMake(xOffset, 0, self.bounds.size.width - xOffset - PRICE_PADDING, self.bounds.size.height / 2), borderInsets);
    _titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
    _titleLabel.text = title;
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    
    [_titleLabel setFont:[UIFont fontWithName:@"Rambla-BoldItalic" size:30]];
    
    CGRect priceRect = UIEdgeInsetsInsetRect(CGRectMake(self.bounds.size.width - PRICE_PADDING, 0, PRICE_PADDING - 5, self.bounds.size.height), borderInsets);
    _priceLabel = [[UILabel alloc] initWithFrame:priceRect];
    [_priceLabel setText:price];
    [_priceLabel setTextAlignment:NSTextAlignmentRight];
    [_priceLabel setTextColor:PRICE_COLOR];
    [_priceLabel setFont:[UIFont fontWithName:@"Rambla-BoldItalic" size:24]];
    
    _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(xOffset, self.bounds.size.height/2, self.bounds.size.width - xOffset - PRICE_PADDING, self.bounds.size.height / 2)];
    _descriptionLabel.text = [description substringToIndex:10];
    _descriptionLabel.font = [UIFont fontWithName:@"Rambla-BoldItalic" size:20];
    
    
    [self addSubview:_titleLabel];
    [self addSubview:imageView];
    [self addSubview:_descriptionLabel];
    [self addSubview:_priceLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
