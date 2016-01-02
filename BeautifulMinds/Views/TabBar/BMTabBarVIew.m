//
//  BMTabBarVIew.m
//  BeautifulMinds
//
//  Created by Geman Wu on 1/1/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import "BMTabBarVIew.h"

@interface BMTabBarVIew()

@property (nonatomic, readwrite) int numberOfBtns;
@property (nonatomic, strong) NSMutableArray *imageViewsArray;

@end

@implementation BMTabBarVIew

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      self.imageViewsArray = [NSMutableArray new];
      self.numberOfBtns = 3;
      self.backgroundColor = [UIColor whiteColor];
      
      [self createBtnWithIndex:0 text:@"Home" iconImage:nil action:@selector(homeBtnPressed:)];
      [self createBtnWithIndex:1 text:@"Write" iconImage:nil action:@selector(writeBtnPressed:)];
      [self createBtnWithIndex:2 text:@"Profile" iconImage:nil action:@selector(profileBtnPressed:)];
      
      [self selectBtnWithIndex:0];
    }
    return self;
}

-(void)createBtnWithIndex:(NSInteger)index text:(NSString *)text iconImage:(UIImage *)iconImage action:(SEL)action {
  CGFloat btnHeight = CGRectGetHeight(self.frame);
  CGFloat btnWidth = CGRectGetWidth(self.frame)/self.numberOfBtns;
  
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
  btn.frame = CGRectMake(index*btnWidth, 0, btnWidth, btnHeight);
  [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
  btn.tag = index;
  [self addSubview:btn];
  
  CGFloat imageOffset = 10;
  
  UIImageView *iconImageView = [[UIImageView alloc]initWithFrame:CGRectInset(btn.bounds, btnWidth/2-btnHeight/2+imageOffset, imageOffset)];
  iconImageView.tag = index;
  [btn addSubview:iconImageView];
  
  [self.imageViewsArray addObject:iconImageView];
}

-(void)homeBtnPressed:(UIButton *)sender {
  [[BMRoutingManager shared]goToHomeVC];
}

-(void)writeBtnPressed:(UIButton *)sender {
  [[BMRoutingManager shared]goToWriteVC];
}

-(void)profileBtnPressed:(UIButton *)sender {
  [[BMRoutingManager shared]goToProfileVC];
}

-(void)selectBtnWithIndex:(NSInteger)index {
  
  [self resetAllBtnImages];
  
  for (UIImageView *imageView in self.imageViewsArray) {
    if (imageView.tag == 0 && index == 0) {
      imageView.image = [BMPaintCode imageOfIconHomeSelected];
    }
    else if (imageView.tag == 1 && index == 1) {
      imageView.image = [BMPaintCode imageOfIconWriteSelected];
    }
    else if (imageView.tag == 2 && index == 2) {
      imageView.image = [BMPaintCode imageOfIconProfileSelected];
    }
  }
}

-(void)resetAllBtnImages {
  for (UIImageView *imageView in self.imageViewsArray) {
    if (imageView.tag == 0) {
      imageView.image = [BMPaintCode imageOfIconHomeBlack];
    }
    else if (imageView.tag == 1) {
      imageView.image = [BMPaintCode imageOfIconWriteBlack];
    }
    else if (imageView.tag == 2) {
      imageView.image = [BMPaintCode imageOfIconProfileBlack];
    }
  }
}

@end
