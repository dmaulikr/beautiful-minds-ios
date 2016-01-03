//
//  BMWriteVC.m
//  BeautifulMinds
//
//  Created by Geman Wu on 1/1/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import "BMWriteVC.h"

@interface BMWriteVC () <UITextViewDelegate>

@end

@implementation BMWriteVC

- (void)viewDidLoad {
    [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  
  [self setupNavBar];
  [self setupTextViews];
  
}

-(void)setupNavBar {
  
  [self.navBar setupForWriteVC];
  [self.navBar.leftBtn addTarget:self action:@selector(closeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
  [self.navBar.rightBtn addTarget:self action:@selector(saveBtnPressed) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setupTextViews {
  self.placeHolderLabelOne = [[UILabel alloc]initWithFrame:CGRectMake(23, 84, CGRectGetWidth(self.view.frame)-20, 50)];
  self.placeHolderLabelOne.text = @"Title";
  self.placeHolderLabelOne.font = [UIFont BMTitleFontBoldWithSize:26];
  self.placeHolderLabelOne.textColor = [UIColor lightGrayColor];
  [self.view addSubview:self.placeHolderLabelOne];
  
  self.titleTextView = [[UITextView alloc]initWithFrame:CGRectMake(15, 84, CGRectGetWidth(self.view.frame)-20, 60)];
  self.titleTextView.font = [UIFont BMTitleFontBoldWithSize:26];
  self.titleTextView.backgroundColor = [UIColor clearColor];
  self.titleTextView.tag = 0;
  self.titleTextView.delegate = self;
  [self.view addSubview:self.titleTextView];
  
  self.placeHolderLabelTwo = [[UILabel alloc]initWithFrame:CGRectMake(23, 148, CGRectGetWidth(self.view.frame)-20, 30)];
  self.placeHolderLabelTwo.text = @"How were you helped by someone";
  self.placeHolderLabelTwo.font = [UIFont BMTextFontWithSize:18];
  self.placeHolderLabelTwo.textColor = [UIColor lightGrayColor];
  self.placeHolderLabelTwo.numberOfLines = 0;
  [self.view addSubview:self.placeHolderLabelTwo];
  
  self.bodyTextView = [[UITextView alloc]initWithFrame:CGRectMake(15, 144, CGRectGetWidth(self.view.frame)-20, CGRectGetHeight(self.view.frame)-124-286)];
  self.bodyTextView.font = [UIFont BMTextFontWithSize:18];
  self.bodyTextView.backgroundColor = [UIColor clearColor];
  self.bodyTextView.delegate = self;
  self.bodyTextView.tag = 1;
  [self.view addSubview:self.bodyTextView];
}

-(void)textViewDidChange:(UITextView *)textView {
  if (textView.tag == 0) {
    if (textView.text.length > 0) {
      self.placeHolderLabelOne.hidden = YES;
    }
    else {
      self.placeHolderLabelOne.hidden = NO;
    }
  }
  
  if (textView.tag == 1) {
    if (textView.text.length > 0) {
      self.placeHolderLabelTwo.hidden = YES;
    }
    else {
      self.placeHolderLabelTwo.hidden = NO;
    }
  }
}

-(void)closeBtnPressed {
  [self.view endEditing:YES];
  [[BMRoutingManager shared]goToHomeVC];
}

-(void)saveBtnPressed {
  if (self.bodyTextView.text.length < 1) {
    [SVProgressHUD showErrorWithStatus:@"Please enter a story"];
  }
  else {
    PFObject *postObject = [PFObject objectWithClassName:@"Post"];
    postObject[@"story"] = self.bodyTextView.text;
    postObject[@"title"] = self.titleTextView.text.length > 0 ? self.titleTextView.text : @"";
    postObject[@"isApproved"] = @NO;
    postObject[@"ordinalValue"] = @0;
    postObject[@"tags"] = @[];
    PFUser *user = [PFUser currentUser];
    postObject[@"authorId"] = user.objectId;
    postObject[@"authorDisplayName"] = user[@"displayName"] ? : @"";
    postObject[@"authorAvatarUrl"] = user[@"authorAvatarUrl"] ? : @"";
    postObject[@"comments"] = @[];
    postObject[@"likedBy"] = @[];
      
    [SVProgressHUD showWithStatus:@"Submitting"];
    [postObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
      if (error) {
        
      }
      else {
        [SVProgressHUD showSuccessWithStatus:@"Your story has been submitted for us to review, we will post it as soon as we see that it passes Apple's guidelines for contents"];
        self.titleTextView.text = @"";
        self.bodyTextView.text = @"";
        [self.view endEditing:YES];
        [[BMRoutingManager shared]goToHomeVC];
      }
    }];
  }
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
