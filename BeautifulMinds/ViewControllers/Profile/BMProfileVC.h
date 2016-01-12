//
//  BMProfileVC.h
//  BeautifulMinds
//
//  Created by Geman Wu on 1/1/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMProfileVC : UIViewController<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

{
    NSArray *dataArray;


}
@property (nonatomic, strong) UICollectionView *storyCollectionView;
@property (nonatomic, strong) UIButton *settingBtn;


-(void)getUserInfo;
-(void)settingBtnPressed;
@end
