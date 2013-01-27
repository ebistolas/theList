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

- (void)layoutSubviews {
    [self setupCell];
}

- (void)setupCell {
    [self.textLabel removeFromSuperview];
    
    if (!_scrollView) {
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
        
    }
    

    
    
    /*
    UIEdgeInsets borderInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    CGRect imageFrame = UIEdgeInsetsInsetRect(CGR
     
     ectMake(0, 0, self.bounds.size.height * 1.2, self.bounds.size.height), borderInsets);
    
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
    NSString *price = [NSString stringWithFormat:@"$%@",[self.listing objectForKey:LISTING_PRICE]];*/
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
