//
//  BMRegistrationVC.h
//  BeautifulMinds
//
//  Created by Fishie Veggie on 1/2/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMRegistrationVC : BMBaseNavBarVC <FBSDKLoginButtonDelegate>

@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UIButton *actionBtn;
@property (nonatomic, strong) FBSDKLoginButton *facebookBtn;

@end
