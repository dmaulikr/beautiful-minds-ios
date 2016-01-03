//
//  BMNavBarView.h
//  BeautifulMinds
//
//  Created by Geman Wu on 1/2/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMNavBarView : UIView

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *centerBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UISegmentedControl *registrationSegment;

-(void)leftBtnIsBack;
-(void)setupForHomePage;
-(void)setupForWriteVC;
-(void)setupForRegiatrationVC;
-(void)rightBtnIsSubmit;

@end
