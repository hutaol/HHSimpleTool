//
//  HHProgressHUDViewController.m
//  HHTool_Example
//
//  Created by Henry on 2021/10/10.
//  Copyright © 2021 1325049637@qq.com. All rights reserved.
//

#import "HHProgressHUDViewController.h"
#import <HHSimpleTool/HHTool.h>

@interface HHProgressHUDViewController ()

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HHProgressHUDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray array];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    self.dataArray = @[
        @"成功提示",
        @"失败提示",
        @"信息提示",
        @"加载中",
    ].mutableCopy;
}

#pragma mark - Table vieew data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = self.dataArray[indexPath.row];
    switch (indexPath.row) {
        case 0:
            [MBProgressHUD hh_showSuccess:title view:self.view];
            break;
        case 1:
            [MBProgressHUD hh_showError:title view:self.view];
            break;
        case 2:
            [MBProgressHUD hh_showInfo:title view:self.view];
            break;
        case 3:
            [MBProgressHUD hh_show:title view:self.view];
            break;
            
        default:
            break;
    }
}

@end
