//
//  BMProfileEditVC.m
//  BeautifulMinds
//
//  Created by Fishie Veggie on 1/11/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import "BMProfileEditVC.h"

@interface BMProfileEditVC () <UITableViewDataSource, UITableViewDelegate>
{
    NSDictionary *dataDict;
}
@end

@implementation BMProfileEditVC 

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavBar];
    
    dataDict = @{@"Account":@[@"Edit profile",@"Log out"],@"Feedback":@[@"Send feedback",@"Rate this app"]};
    [self setupTableView];
}

-(void)setupNavBar{
    [self.navBar setupForProfileEditVC];
}

-(void)setupTableView {
    
    UITableView *settingTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 80, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)-80) style:UITableViewStyleGrouped];
    settingTableView.delegate = self;
    settingTableView.dataSource = self;
    [settingTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:settingTableView];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *dataArray = dataDict.allValues[section];
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *) indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    NSArray *dataArray = dataDict.allValues[indexPath.section];
    cell.textLabel.text = dataArray[indexPath.item];
    
    return cell;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return dataDict.allKeys.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return dataDict.allKeys[section];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
