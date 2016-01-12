//
//  BMProfileCollectionReusableView.h
//  BeautifulMinds
//
//  Created by Fishie Veggie on 1/3/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMProfileCollectionReusableView : UICollectionReusableView

@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *fullNameLabel;
@property (nonatomic, strong) UISegmentedControl *segmentControl;

@end
