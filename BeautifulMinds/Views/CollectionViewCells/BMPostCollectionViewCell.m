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
      
      self.margin = 20;
      
      self.createdAtLabel = [[UILabel alloc]init];
      self.createdAtLabel.font = [UIFont BMTextFontWithSize:12];
      self.createdAtLabel.textColor = [UIColor lightGrayColor];
      [self addSubview:self.createdAtLabel];

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
      
      self.readMoreLabel = [[UILabel alloc]init];
      self.readMoreLabel.font = [UIFont BMTextFontWithSize:18];
      self.readMoreLabel.textColor = [UIColor grayColor];
      self.readMoreLabel.text = @"Read more...";
      self.readMoreLabel.hidden = YES;
      [self addSubview:self.readMoreLabel];
    
    self.spacingView = [[UIView alloc]init];
    self.spacingView.backgroundColor = [UIColor BMLightGrey];
    [self addSubview:self.spacingView];
  }
  return self;
}

-(void)setupCellWithObject:(PFObject *)object {
    
    NSDate *createdAtDate = object.createdAt;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSString *createdAtText = [dateFormatter stringFromDate:createdAtDate];
    NSString *titleText = object[@"title"];
    NSString *storyText = object[@"story"];

    self.createdAtLabel.text = createdAtText;
    self.titleLabel.text = titleText;
    self.storyLabel.text = storyText;
  
    self.createdAtLabel.frame = CGRectMake(self.margin, self.margin, CGRectGetWidth(self.bounds)-self.margin*2, 20);
    
    CGFloat createdLabelHeight = 30;
    
    self.titleLabel.frame = CGRectMake(self.margin, self.margin+createdLabelHeight, CGRectGetWidth(self.bounds)-self.margin*2, [self getTitleHeight:titleText]);
    
    self.storyLabel.frame = CGRectMake(self.margin, self.margin + self.margin + createdLabelHeight+ [self getTitleHeight:titleText], CGRectGetWidth(self.bounds)-self.margin*2, [self getStoryHeight:storyText]);
    
    if ([self getStoryHeight:storyText] == 200) {
        self.readMoreLabel.hidden = NO;
        self.readMoreLabel.frame = CGRectMake(self.margin, CGRectGetHeight(self.bounds)-self.margin*2-10, 100, 20);
    }
    else {
        self.readMoreLabel.hidden = YES;
    }
    
    self.spacingView.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-10, CGRectGetWidth(self.frame), 10);
}

-(CGFloat)getCellHeightWithObject:(PFObject *)object {
    CGFloat readMoreLabelHeight = 0;
    if ([self getStoryHeight:object[@"story"]] == 200) {
        readMoreLabelHeight = 40;
    }
    
    CGFloat allMarginHeight = self.margin*2;
    
    if ([self getStoryHeight:object[@"story"]] > 0) {
        allMarginHeight = allMarginHeight + self.margin;
    }
    
    CGFloat heightOfTimeStamp = 30;
    
    return heightOfTimeStamp + [self getTitleHeight:object[@"title"]] + [self getStoryHeight:object[@"story"]] + readMoreLabelHeight + allMarginHeight + 10;
}

-(CGFloat)getTitleHeight:(NSString *)titleText {
    
    CGFloat titleHeight = 0;
    
    if (titleText.length > 0) {
        titleHeight = [BMUIManager getHeightForString:titleText font:[UIFont BMTitleFontBoldWithSize:26] restrictedWidth:[[UIScreen mainScreen] bounds].size.width-self.margin*2];
    }
    
    if (titleHeight > 130) {
        titleHeight = 130;
    }
    
    return titleHeight;
}

-(CGFloat)getStoryHeight:(NSString *)storyText {
    CGFloat storyHeight = 0;
    
    if (storyText.length > 0) {
        storyHeight = [BMUIManager getHeightForString:storyText font:[UIFont BMTextFontWithSize:18] restrictedWidth:[[UIScreen mainScreen] bounds].size.width-self.margin*2];
    }
    
    if (storyHeight > 200) {
        storyHeight = 200;
    }
    
    return storyHeight;
}

@end
