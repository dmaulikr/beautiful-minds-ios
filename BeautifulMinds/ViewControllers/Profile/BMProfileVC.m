//
//  BMProfileVC.m
//  BeautifulMinds
//
//  Created by Geman Wu on 1/1/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import "BMProfileVC.h"
#import <UIImageView+AFNetworking.h>
#import "BMPostCollectionViewCell.h"
#import "BMProfileCollectionReusableView.h"

@interface BMProfileVC ()

@end

@implementation BMProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

}

-(void)getUserInfo {
    if ([[BMUserManager shared] isCurrentUser]) {
        [self setupCollectionView];
        [self getProfileStoryData];
        [self setupNavBar];
        [self setupSettingBtn];
        
    }
}

-(void)setupNavBar {
    self.navigationController.navigationBar.hidden = YES;

}

-(void)segmentValueChanged:(UISegmentedControl *)sender {
    dataArray = [NSMutableArray new];
    [self.storyCollectionView reloadData];
    
    if (sender.selectedSegmentIndex == 0) {
        [self getProfileStoryData];
    }
    else {
        [self getLikedData];
    }
}


-(void)setupCollectionView {
    if (self.storyCollectionView) {
        [self.storyCollectionView removeFromSuperview];
        self.storyCollectionView = nil;
    }
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    self.storyCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-20-50) collectionViewLayout:layout];
    self.storyCollectionView.delegate = self;
    self.storyCollectionView.dataSource = self;
    [self.storyCollectionView registerClass:[BMPostCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.storyCollectionView registerClass:[BMProfileCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    self.storyCollectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.storyCollectionView];
    
}


-(void)getProfileStoryData {
    PFQuery *query = [[PFQuery alloc]initWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"isApproved" equalTo:[NSNumber numberWithBool:YES]];
    [query whereKey:@"authorId" equalTo:[PFUser currentUser].objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        //    NSLog(@"%@", objects);
        dataArray = objects;
        
        [self.storyCollectionView reloadData];
    }];
}

-(void)getLikedData {
    PFQuery *query = [[PFQuery alloc]initWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query whereKey:@"isApproved" equalTo:[NSNumber numberWithBool:YES]];
    [query whereKey:@"objectId" containedIn:[PFUser currentUser][@"likedPosts"]];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        //    NSLog(@"%@", objects);
        dataArray = objects;
        
        [self.storyCollectionView reloadData];
    }];
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BMPostCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor BMLightGrey];
    PFObject *object = dataArray[indexPath.item];
    [cell setupCellWithObject:object];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return dataArray.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [[BMRoutingManager shared]goToStoryDetailVCFromProfileVC:dataArray[indexPath.item]];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    BMPostCollectionViewCell *cell = [BMPostCollectionViewCell new];
    PFObject *object = dataArray[indexPath.item];
    return CGSizeMake(CGRectGetWidth(self.view.bounds), [cell getCellHeightWithObject:object]);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    BMProfileCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    [headerView.avatarImageView setImageWithURL:[NSURL URLWithString:[PFUser currentUser][@"authorAvatarUrl"]]];
    headerView.fullNameLabel.text = [PFUser currentUser][@"displayName"];
    
    [headerView.segmentControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];

    return headerView;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(CGRectGetWidth(self.view.bounds), 230);
}

-(void)setupSettingBtn {
    self.settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.settingBtn.backgroundColor = [UIColor greenColor];
    self.settingBtn.frame = CGRectMake(CGRectGetWidth(self.view.bounds)-70, 50, 30, 30);
    [self.settingBtn addTarget:self action:@selector(settingBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.settingBtn];
}

-(void)settingBtnPressed
{
    NSLog(@"%s", "hellp");
    [[BMRoutingManager shared]goToProfileEditVCFromProfileVC];
}

@end
