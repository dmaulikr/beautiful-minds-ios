//
//  BMStoryDetailVC.h
//  BeautifulMinds
//
//  Created by Geman Wu on 1/2/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMStoryDetailVC : BMBaseNavBarVC

-(instancetype)initWithStoryObject:(PFObject *)object;

@property (nonatomic, strong) PFObject *storyObject;

@property (nonatomic, strong) UILabel *createdAtLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *storyLabel;

@end
