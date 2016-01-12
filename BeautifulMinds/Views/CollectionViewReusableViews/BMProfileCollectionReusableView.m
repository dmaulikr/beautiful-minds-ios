//
//  BMProfileCollectionReusableView.m
//  BeautifulMinds
//
//  Created by Fishie Veggie on 1/3/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import "BMProfileCollectionReusableView.h"

@implementation BMProfileCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.avatarImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/2-40, 60 , 80, 80)];
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.width/2;
        self.avatarImageView.layer.masksToBounds = YES;
        [self addSubview:self.avatarImageView];
        
        self.fullNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)/2-100,150, 200,40)];
        self.fullNameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.fullNameLabel];
        
        self.segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"My Stories",@"Liked"]];
        self.segmentControl.frame = CGRectMake(CGRectGetWidth(self.frame)/2-100,200, 200, 25);
        [self.segmentControl setSelectedSegmentIndex:0];
        [self addSubview:self.segmentControl];
    }
    return self;
}

@end
