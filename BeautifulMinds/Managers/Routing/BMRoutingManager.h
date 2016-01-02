//
//  BMRoutingManager.h
//  BeautifulMinds
//
//  Created by Geman Wu on 1/1/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMRootVC.h"
#import <Parse.h>

@interface BMRoutingManager : NSObject

@property (nonatomic, strong) BMRootVC *rootVC;

+ (BMRoutingManager *)shared;

-(void)goToProfileVC;
-(void)goToWriteVC;
-(void)goToHomeVC;
-(void)goToStoryDetailVCFromHomeVC:(PFObject *)storyObject;

-(void)showTabBar:(BOOL)show;

@end
