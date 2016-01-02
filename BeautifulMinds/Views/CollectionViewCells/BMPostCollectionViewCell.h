//
//  BMPostCollectionViewCell.h
//  BeautifulMinds
//
//  Created by Geman Wu on 1/2/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMPostCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *storyLabel;

-(void)setupCellWithObject:(PFObject *)object;

@end
