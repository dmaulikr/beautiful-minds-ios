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
}
@property (nonatomic, strong) UICollectionView *mainCollectionView;

@end

@implementation BMHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  self.view.backgroundColor = [UIColor whiteColor];
  
  [self setupNavBar];
  [self setupCollectionView];
  [self getHomeData];
}

-(void)setupNavBar {
  self.navigationController.navigationBar.hidden = YES;
  [self.navBar setupForHomePage];
  
}

-(void)setupCollectionView {
  UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
  layout.minimumInteritemSpacing = 0;
  layout.minimumLineSpacing = 0;
  self.mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64-50) collectionViewLayout:layout];
  self.mainCollectionView.delegate = self;
  self.mainCollectionView.dataSource = self;
  [self.mainCollectionView registerClass:[BMPostCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
  self.mainCollectionView.backgroundColor = [UIColor whiteColor];
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
    NSLog(@"%@", objects);
    dataArray = objects;
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
