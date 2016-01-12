//
//  BMRegistrationVC.m
//  BeautifulMinds
//
//  Created by Fishie Veggie on 1/2/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import "BMRegistrationVC.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <PFFacebookUtils.h>

@interface BMRegistrationVC ()

@end

@implementation BMRegistrationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavBar];
    [self setupTextFields];
    [self setupFacebookLoginAndSignUp];
}

-(void)setupNavBar {
    
    [self.navBar setupForRegiatrationVC];
    [self.navBar.leftBtn addTarget:self action:@selector(closeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.navBar.registrationSegment addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
}

-(void)setupTextFields {
    self.emailTextField = [[UITextField alloc]initWithFrame:CGRectMake(50, 84, CGRectGetWidth(self.view.frame)-100, 50)];
    self.emailTextField.placeholder = @"EMAIL";
    self.emailTextField.font = [UIFont BMTextFontWithSize:16];
    self.emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.emailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.view addSubview:self.emailTextField];
    
    UIView *underlineOne = [[UIView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.emailTextField.frame)-6, CGRectGetWidth(self.view.bounds)-100, 1)];
    underlineOne.backgroundColor = [UIColor BMLightGrey];
    [self.view addSubview:underlineOne];
    
    self.passwordTextField = [[UITextField alloc]initWithFrame:CGRectMake(50, 134, CGRectGetWidth(self.view.frame)-100, 50)];
    self.passwordTextField.placeholder = @"PASSWORD";
    self.passwordTextField.font = [UIFont BMTextFontWithSize:16];
    self.passwordTextField.secureTextEntry = YES;
    [self.view addSubview:self.passwordTextField];
    
    UIView *underlineTwo = [[UIView alloc]initWithFrame:CGRectMake(50, CGRectGetMaxY(self.passwordTextField.frame)-6, CGRectGetWidth(self.view.bounds)-100, 1)];
    underlineTwo.backgroundColor = [UIColor BMLightGrey];
    [self.view addSubview:underlineTwo];
    
    self.actionBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.actionBtn setTitle:@"LOGIN" forState:UIControlStateNormal];
    self.actionBtn.frame = CGRectMake(50, CGRectGetMaxY(self.passwordTextField.frame)+30, CGRectGetWidth(self.view.bounds)-100, 40);
    self.actionBtn.titleLabel.font = [UIFont BMTitleFontBoldWithSize:24];
    [self.actionBtn addTarget:self action:@selector(actionBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.actionBtn];
}

-(void)closeBtnPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)segmentValueChanged:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        [self.actionBtn setTitle:@"LOGIN" forState:UIControlStateNormal];
    }
    else {
        [self.actionBtn setTitle:@"SIGN UP" forState:UIControlStateNormal];
    }
}

-(void)actionBtnPressed:(UIButton *)sender {
    if (![self isValidEmail:self.emailTextField.text]) {
        [SVProgressHUD showErrorWithStatus:@"Please enter a valid email"];
    }
    else if (self.passwordTextField.text.length < 1) {
        [SVProgressHUD showErrorWithStatus:@"Please enter a valid password"];
    }
    else {
        sender.enabled = NO;
        if (self.navBar.registrationSegment.selectedSegmentIndex == 0) {
            [SVProgressHUD showWithStatus:@"Logging in"];
            [[BMUserManager shared]loginWithEmail:self.emailTextField.text password:self.passwordTextField.text returned:^(PFUser *user, NSError *error) {
                if (error) {
                    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                }
                else {
                    [SVProgressHUD showSuccessWithStatus:@"Logged in"];
                    [self closeBtnPressed];
                }
                sender.enabled = YES;
            }];
        }
        else {
            [SVProgressHUD showWithStatus:@"Signing up"];
            [[BMUserManager shared]signupWithEmail:self.emailTextField.text password:self.passwordTextField.text returned:^(PFUser *user, NSError *error) {
                if (error) {
                    [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                }
                else {
                    [SVProgressHUD showSuccessWithStatus:@"Welcome!"];
                    [self closeBtnPressed];
                }
                sender.enabled = YES;
            }];
        }
    }
}


- (BOOL)isValidEmail:(NSString *)string {
    if (!string || string.length > 0) {
        NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
        NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
        if ([emailTest evaluateWithObject:string] == YES) {
            return YES;
        }
        else {
            return NO;
        }
    }
    else
    {
        return NO;
    }
}

-(void)setupFacebookLoginAndSignUp {
    self.facebookBtn = [[FBSDKLoginButton alloc]init];
    self.facebookBtn.frame = CGRectMake(50, CGRectGetMaxY(self.actionBtn.frame)+30, CGRectGetWidth(self.view.bounds)-100, 40);
    self.facebookBtn.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    [self.view addSubview:self.facebookBtn];
    self.facebookBtn.delegate = self;
}

- (void)  loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
                error:(NSError *)error {
    
    if(error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        return;
    }
    
    [self loginToParseFBWithToken:result.token];
    
}

-(void)loginToParseFBWithToken: (FBSDKAccessToken *)accessToken {
    
    // Log In (create/update currentUser) with FBSDKAccessToken
    [PFFacebookUtils logInInBackgroundWithAccessToken:accessToken
                                                block:^(PFUser *user, NSError *error) {
                                                    if (!user) {
                                                        NSLog(@"Uh oh. There was an error logging in.");
                                                    } else {
                                                        NSLog(@"User logged in through Facebook!");
                                                    }
                                                }];
}
-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton {
    
}

@end
