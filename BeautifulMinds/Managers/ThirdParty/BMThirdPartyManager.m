//
//  BMThirdPartyManager.m
//  BeautifulMinds
//
//  Created by Geman Wu on 1/2/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import "BMThirdPartyManager.h"

@implementation BMThirdPartyManager

+ (BMThirdPartyManager *)shared {
  static BMThirdPartyManager *shared;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    shared = [[[self class] alloc] init];
  });
  return shared;
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    [self setupSVProgressView];
    [self setupParse];
  }
  return self;
}

-(void)setupSVProgressView {
  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
  [SVProgressHUD setFont:[UIFont BMTextFontWithSize:14]];
  [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
  [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
}

-(void)setupParse {
  [Parse setApplicationId:@"UW2qENqkZ3jlovlgqtAbuQQRdQlkvvvVVlbAcWx8"
                clientKey:@"pSHQlzfzteQMdu1xKQva2K2QNvfgBCsVov0N3dK3"];
}

@end
