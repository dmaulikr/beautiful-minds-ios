//
//  BMRootVC.m
//  BeautifulMinds
//
//  Created by Geman Wu on 1/1/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import "BMRootVC.h"

@interface BMRootVC ()

@end

@implementation BMRootVC

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setupTabBar];
}

- (void)setupTabBar {
  CGFloat tabBarHeight = 50;
  self.tabBar = [[BMTabBarVIew alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-tabBarHeight, CGRectGetWidth(self.view.frame), tabBarHeight)];
  [self.view addSubview:self.tabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
