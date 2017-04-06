//
//  FirstViewController.m
//  seperate
//
//  Created by liufei on 2017/2/13.
//  Copyright © 2017年 Facebook. All rights reserved.
//

#import "DemoViewController.h"
#import "BridgeManager.h"
#import "ReactNativeViewController.h"


@interface DemoViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation DemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 200, 600)];
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
  [self.view addSubview: self.tableView];
}

#pragma mark - TableView Delegate & DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
  switch (indexPath.row) {
      case 0:
      {
          tableViewCell.textLabel.text = @"bisiness1";
      }
      break;
      case 1:
      {
          tableViewCell.textLabel.text = @"buniness2";
      }
      break;
    default:
      break;
  }
  return tableViewCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  switch (indexPath.row) {
      case 0:
    {
      ReactNativeViewController *vc = [[ReactNativeViewController alloc]init];
      vc.moduleName = @"ReactExample";
      vc.bridgeName = @"bisiness1";
      [self.navigationController pushViewController:vc animated:YES];
    }
      break;
      case 1:
    {
      ReactNativeViewController *vc = [[ReactNativeViewController alloc]init];
      vc.moduleName = @"seperate";
      vc.bridgeName = @"bisiness2";
      [self.navigationController pushViewController:vc animated:YES];
    }
      break;
    default:
      break;
  }
  
}

@end
