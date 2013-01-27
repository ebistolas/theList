//
//  SearchResultsImageCell.m
//  theList
//
//  Created by Eugene Bistolas on 1/26/13.
//  Copyright (c) 2013 Eugene Bistolas. All rights reserved.
//

#import "SearchResultsImageCell.h"

@implementation SearchResultsImageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier listing:(PFObject*)listing
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _listing = listing;
    }
    return self;
}

- (void)setListing:(PFObject *)listing {
    if (listing != _listing) {
        _listing = listing;
    }
}

- (void)drawRect:(CGRect)rect {
    [self setupCell];
}

- (void)setupCell {
    [self.textLabel removeFromSuperview];
    self.clipsToBounds = YES;
    
    //Nab image
    PFFile *image = [[self.listing objectForKey:LISTING_IMAGES] objectAtIndex:0];
    
    [image getDataInBackgroundWithBlock:^(NSData* data, NSError *error) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageWithData:data]];
        CGRect frame = self.bounds;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 1.0f;
        imageView.frame = frame;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        
        [self addSubview:imageView];
        [self bringSubviewToFront:_titleLabel];
        [self bringSubviewToFront:_priceLabel];
        
        imageView.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            imageView.alpha = 0.3;
        }];
        NSLog(@"|---Got image!");
    }];
    
    NSString *title = [self.listing objectForKey:LISTING_TITLE];
    NSLog(@"|--setting up the cell for %@", title);

    NSString *price = [NSString stringWithFormat:@"$%@",[self.listing objectForKey:LISTING_PRICE]];
    
    UIEdgeInsets insetPadding = UIEdgeInsetsMake(10, 10, 10, 10);
    CGRect titleRect = UIEdgeInsetsInsetRect(CGRectMake(0, self.bounds.size.height*0.75, self.bounds.size.width, self.bounds.size.height/4), insetPadding);
    _titleLabel = [[UILabel alloc] initWithFrame:titleRect];
    _titleLabel.text = title;
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.adjustsFontSizeToFitWidth = YES;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = TEXT_COLOR;
    _titleLabel.font = [UIFont fontWithName:@"SourceSansPro-Regular" size:25];
    
    CGRect priceRect = UIEdgeInsetsInsetRect(CGRectMake(0, self.bounds.size.height*0.75, self.bounds.size.width, self.bounds.size.height/4), insetPadding);
    _priceLabel = [[UILabel alloc] initWithFrame:priceRect];
    _priceLabel.text = price;
    _priceLabel.adjustsFontSizeToFitWidth = YES;
    _priceLabel.backgroundColor = [UIColor clearColor];
    _priceLabel.font = [UIFont fontWithName:@"SourceSansPro-BoldItalic" size:25];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.textColor = PRICE_COLOR;

    [self addSubview:_titleLabel];
    [self addSubview:_priceLabel];
    
}

-(void)setSelected:(BOOL)selected {
    
}

@end
