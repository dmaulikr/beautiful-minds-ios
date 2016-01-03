//
//  BMRoutingManager.m
//  BeautifulMinds
//
//  Created by Geman Wu on 1/1/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import "BMRoutingManager.h"
#import "BMHomeVC.h"
#import "BMWriteVC.h"
#import "BMProfileVC.h"
#import "BMStoryDetailVC.h"
#import "BMRegistrationVC.h"

@interface BMRoutingManager ()

@property (nonatomic, strong) UINavigationController *homeNavVC;
@property (nonatomic, strong) BMWriteVC *writeVC;
@property (nonatomic, strong) BMProfileVC *profileVC;

@end

@implementation BMRoutingManager

+ (BMRoutingManager *)shared {
  static BMRoutingManager *shared;
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
      [self initAllVCs];
    }
    return self;
}

-(void)initAllVCs {
  [self initRootVC];
  
  //Root VC must be first
  
  [self initProfileVC];
  [self initWriteVC];
  [self initHomeVC];
  
  [self goToHomeVC];
}

-(void)initRootVC {
  self.rootVC = [[BMRootVC alloc]init];
}

-(void)initHomeVC {
  BMHomeVC *homeVC = [[BMHomeVC alloc]init];
  self.homeNavVC = [[UINavigationController alloc]initWithRootViewController:homeVC];
  [self.rootVC addChildViewController:self.homeNavVC];
  [self.rootVC.view addSubview:self.homeNavVC.view];
}

-(void)initWriteVC {
  self.writeVC = [[BMWriteVC alloc]init];
  [self.rootVC addChildViewController:self.writeVC];
  [self.rootVC.view addSubview:self.writeVC.view];
}

-(void)initProfileVC {
  self.profileVC = [[BMProfileVC alloc]init];
  [self.rootVC addChildViewController:self.profileVC];
  [self.rootVC.view addSubview:self.profileVC.view];
}

-(void)goToProfileVC {
  if (self.profileVC) {
    [self.rootVC.view bringSubviewToFront:self.profileVC.view];
    [self.rootVC.view bringSubviewToFront:self.rootVC.tabBar];
    [self.rootVC.tabBar selectBtnWithIndex:2];
  }
}

-(void)goToHomeVC {
  if (self.homeNavVC) {
    [self.rootVC.view bringSubviewToFront:self.homeNavVC.view];
    [self.rootVC.view bringSubviewToFront:self.rootVC.tabBar];
    [self.rootVC.tabBar selectBtnWithIndex:0];
  }
}

-(void)goToWriteVC {
    
    if (![[BMUserManager shared]isCurrentUser]) {
        
        BMRegistrationVC *registrationVC = [BMRegistrationVC new];
        [self.rootVC presentViewController:registrationVC animated:YES completion:nil];
        return;
    }
    
    if (self.writeVC) {
        [[PFUser currentUser] fetchInBackground];
        [self.rootVC.view bringSubviewToFront:self.writeVC.view];
        [self.rootVC.view bringSubviewToFront:self.rootVC.tabBar];
        [self.rootVC.tabBar selectBtnWithIndex:1];
        [self.writeVC.bodyTextView becomeFirstResponder];
    }
}

-(void)goToStoryDetailVCFromHomeVC:(PFObject *)storyObject {
  BMStoryDetailVC *storyDetailVC = [[BMStoryDetailVC alloc]initWithStoryObject:storyObject];
  if (self.homeNavVC) {
    [self.homeNavVC pushViewController:storyDetailVC animated:YES];
    [self showTabBar:NO];
  }
}

-(void)showTabBar:(BOOL)show {
  self.rootVC.tabBar.hidden = !show;
}

@end
