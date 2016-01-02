//
//  BMBaseNavBarVC.m
//  BeautifulMinds
//
//  Created by Geman Wu on 1/2/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import "BMBaseNavBarVC.h"

@implementation BMBaseNavBarVC

-(void)viewDidLoad {
  self.navBar = [[BMNavBarView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 64)];
  [self.view addSubview:self.navBar];
}

@end
