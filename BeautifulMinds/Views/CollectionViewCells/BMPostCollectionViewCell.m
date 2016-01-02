//
//  BMPostCollectionViewCell.m
//  BeautifulMinds
//
//  Created by Geman Wu on 1/2/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import "BMPostCollectionViewCell.h"

@implementation BMPostCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = [UIFont BMTitleFontBoldWithSize:26];
    self.titleLabel.textColor = [UIColor darkTextColor];
    self.titleLabel.numberOfLines = 0;
    [self addSubview:self.titleLabel];
    
    self.storyLabel = [[UILabel alloc]init];
    self.storyLabel.font = [UIFont BMTextFontWithSize:18];
    self.storyLabel.textColor = [UIColor darkTextColor];
    self.storyLabel.numberOfLines = 0;
    [self addSubview:self.storyLabel];
    
    UIView *spacing = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-10, CGRectGetWidth(self.frame), 10)];
    spacing.backgroundColor = [UIColor BMLightGrey];
    [self addSubview:spacing];
  }
  return self;
}

-(void)setupCellWithObject:(PFObject *)object {
  self.titleLabel.text = object[@"title"];
  self.storyLabel.text = object[@"story"];
  
  CGFloat titleHeight = 0;
  CGFloat storyHeight = 0;
  NSString *titleText = object[@"title"];
  NSString *storyText = object[@"story"];
  if (titleText.length > 0) {
    titleHeight = [BMUIManager getHeightForString:titleText font:[UIFont BMTitleFontBoldWithSize:26] restrictedWidth:CGRectGetWidth(self.bounds)-40];
  }
  if (storyText.length > 0) {
    storyHeight = [BMUIManager getHeightForString:storyText font:[UIFont BMTextFontWithSize:18] restrictedWidth:CGRectGetWidth(self.bounds)-40];
  }
  
  if (titleHeight > 130) {
    titleHeight = 130;
  }
  if (storyHeight > 200) {
    storyHeight = 200;
  }
  
  if (titleText.length > 0) {
    self.titleLabel.frame = CGRectMake(20, 20, CGRectGetWidth(self.bounds)-40, titleHeight);
  }
  
  if (storyText.length > 0) {
    self.storyLabel.frame = CGRectMake(20, 20 + CGRectGetMaxY(self.titleLabel.frame), CGRectGetWidth(self.bounds)-40, storyHeight - 20);
  }
}

@end
