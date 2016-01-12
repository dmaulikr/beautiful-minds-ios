//
//  BMHomeVC.m
//  BeautifulMinds
//
//  Created by Geman Wu on 1/1/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import "BMHomeVC.h"
#import "BMPostCollectionViewCell.h"

@interface BMHomeVC () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
  NSArray *dataArray;
  UIRefreshControl *refresh;
  UIImageView *backgroundImageView;
}
@property (nonatomic, strong) UICollectionView *mainCollectionView;

@end

@implementation BMHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  self.view.backgroundColor = [UIColor whiteColor];
  
  [self addBackgroundBlurAnimation];
  [self setupNavBar];
  [self setupCollectionView];
  [self getHomeData];
}

-(void)addBackgroundBlurAnimation {
    backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds),CGRectGetHeight(self.view.bounds)*2)];
    backgroundImageView.image = [UIImage imageNamed:@"background.png"];
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:backgroundImageView];
    backgroundImageView.hidden = YES;
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurredView = [[UIVisualEffectView alloc]initWithEffect:effect];
    blurredView.frame = self.view.bounds;
    [self.view addSubview:blurredView];
    
    [self startBackgroundAnimation];
}

-(void)startBackgroundAnimation {
    [UIView animateWithDuration:25 animations:^{
        backgroundImageView.frame = CGRectMake(0, -CGRectGetHeight(self.view.bounds), CGRectGetWidth(self.view.bounds),CGRectGetHeight(self.view.bounds)*2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:25 animations:^{
            backgroundImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds),CGRectGetHeight(self.view.bounds)*2);
        } completion:^(BOOL finished) {
            [self startBackgroundAnimation];
        }];
    }];
}

-(void)setupNavBar {
  self.navigationController.navigationBar.hidden = YES;
  [self.navBar setupForHomePage];
    self.navBar.backgroundColor = [UIColor whiteColor];
    [self.view bringSubviewToFront:self.navBar];
  
}

-(void)setupCollectionView {
  UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
  layout.minimumInteritemSpacing = 0;
  layout.minimumLineSpacing = 0;
  self.mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64-50) collectionViewLayout:layout];
  self.mainCollectionView.delegate = self;
  self.mainCollectionView.dataSource = self;
  [self.mainCollectionView registerClass:[BMPostCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
  self.mainCollectionView.backgroundColor = [UIColor clearColor];
  [self.view addSubview:self.mainCollectionView];
  
  refresh = [[UIRefreshControl alloc]init];
  [refresh addTarget:self action:@selector(refreshValueChanged:) forControlEvents:UIControlEventValueChanged];
  [self.mainCollectionView addSubview:refresh];
}

-(void)refreshValueChanged:(UIRefreshControl *)sender {
  [self getHomeData];
}

-(void)getHomeData {
  PFQuery *query = [[PFQuery alloc]initWithClassName:@"Post"];
  [query orderByDescending:@"createdAt"];
  [query whereKey:@"isApproved" equalTo:[NSNumber numberWithBool:YES]];
  [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//    NSLog(@"%@", objects);
    dataArray = objects;
    
    backgroundImageView.hidden = NO;
    [self.mainCollectionView reloadData];
    [refresh endRefreshing];
  }];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  BMPostCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
  PFObject *object = dataArray[indexPath.item];
  [cell setupCellWithObject:object];
  return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return dataArray.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  [[BMRoutingManager shared]goToStoryDetailVCFromHomeVC:dataArray[indexPath.item]];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    BMPostCollectionViewCell *cell = [BMPostCollectionViewCell new];
    PFObject *object = dataArray[indexPath.item];
    return CGSizeMake(CGRectGetWidth(self.view.bounds), [cell getCellHeightWithObject:object]);
}

@end
