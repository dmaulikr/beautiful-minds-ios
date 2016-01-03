//
//  BMNavBarView.m
//  BeautifulMinds
//
//  Created by Geman Wu on 1/2/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import "BMNavBarView.h"

@interface BMNavBarView ()

@end

@implementation BMNavBarView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftBtn setFrame:CGRectMake(0, 20, 88, 44)];
    [self addSubview:self.leftBtn];
    
    self.centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.centerBtn setFrame:CGRectMake(self.center.x-44, 20, 88, 44)];
    [self addSubview:self.centerBtn];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn setFrame:CGRectMake(CGRectGetWidth(self.frame)-88, 20, 88, 44)];
    [self addSubview:self.rightBtn];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63, CGRectGetWidth(self.frame), 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
  }
  return self;
}


-(void)leftBtnIsBack {
  [self.leftBtn setImage:[BMPaintCode imageOfIconBackBlack] forState:UIControlStateNormal];
}

-(void)setupForHomePage {
  [self.centerBtn setImage:[BMPaintCode imageOfIconOfLogo] forState:UIControlStateNormal];
}

-(void)setupForWriteVC {
  
  [self leftBtnIsBack];
  [self rightBtnIsSubmit];
  
}

-(void)setupForRegiatrationVC {
    self.registrationSegment = [[UISegmentedControl alloc]initWithItems:@[@"LOGIN",@"SIGN UP"]];
    self.registrationSegment.center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2+10);
    [self addSubview:self.registrationSegment];
    [self.registrationSegment setSelectedSegmentIndex:0];
    [self leftBtnIsBack];
}

-(void)rightBtnIsSubmit {
  [self.rightBtn setImage:[BMPaintCode imageOfIconSubmitBlack] forState:UIControlStateNormal];
}



@end
