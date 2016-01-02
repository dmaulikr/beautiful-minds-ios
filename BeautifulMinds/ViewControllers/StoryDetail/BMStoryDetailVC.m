//
//  BMStoryDetailVC.m
//  BeautifulMinds
//
//  Created by Geman Wu on 1/2/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import "BMStoryDetailVC.h"

@implementation BMStoryDetailVC

-(instancetype)initWithStoryObject:(PFObject *)object {
  self = [super init];
  if (self) {
    self.storyObject = object;
  }
  return self;
}

-(void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor whiteColor];
  
  [self setupNavBar];
  [self setupLabels];
}

-(void) setupNavBar {
  
  self.navigationController.navigationBar.hidden = YES;
  
  [self.navBar leftBtnIsBack];
  [self.navBar.leftBtn addTarget:self action:@selector(backBtnPressed) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setupLabels {
  UIScrollView *backgroundScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 84, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-84)];
  [self.view addSubview:backgroundScroll];
  
  NSString *titleText = self.storyObject[@"title"];
  NSString *storyText = self.storyObject[@"story"];
  
  if (titleText.length > 0) {
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, CGRectGetWidth(self.view.frame)-40, [BMUIManager getHeightForString:titleText font:[UIFont BMTitleFontBoldWithSize:26] restrictedWidth:CGRectGetWidth(self.view.frame)-40])];
    self.titleLabel.font = [UIFont BMTitleFontBoldWithSize:26];
    self.titleLabel.text = titleText;
    self.titleLabel.numberOfLines = 0;
    [backgroundScroll addSubview:self.titleLabel];
  }
  
  if (storyText.length > 0) {
    self.storyLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20+self.titleLabel.frame.size.height, CGRectGetWidth(self.view.frame)-40, [BMUIManager getHeightForString:storyText font:[UIFont BMTextFontWithSize:18] restrictedWidth:CGRectGetWidth(self.view.frame)-40])];
    self.storyLabel.text = storyText;
    self.storyLabel.font = [UIFont BMTextFontWithSize:18];
    self.storyLabel.numberOfLines = 0;
    [backgroundScroll addSubview:self.storyLabel];
  }
  
  [backgroundScroll setContentSize:CGSizeMake(CGRectGetWidth(backgroundScroll.bounds), CGRectGetMaxY(self.storyLabel.frame))];
}

-(void)backBtnPressed {
  [[BMRoutingManager shared] showTabBar:YES];
  [self.navigationController popViewControllerAnimated:YES];
}

@end
