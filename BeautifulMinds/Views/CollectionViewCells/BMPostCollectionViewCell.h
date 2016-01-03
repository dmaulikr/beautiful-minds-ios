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
@property (nonatomic, strong) UILabel *readMoreLabel;
@property (nonatomic, strong) UILabel *createdAtLabel;
@property (nonatomic, strong) UIView *spacingView;
@property (nonatomic, readwrite) CGFloat margin;

-(void)setupCellWithObject:(PFObject *)object;
-(CGFloat)getCellHeightWithObject:(PFObject *)object;

@end
