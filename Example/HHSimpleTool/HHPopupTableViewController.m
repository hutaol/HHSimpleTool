//
//  HHPopupTableViewController.m
//  HHTool_Example
//
//  Created by Henry on 2021/5/6.
//  Copyright © 2021 1325049637@qq.com. All rights reserved.
//

#import "HHPopupTableViewController.h"
#import <HHSimpleTool/HHTool.h>

@interface HHPopupTableViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation HHPopupTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"弹出框";

    self.dataArray = @[@"菜单弹出框", @"底部List弹出框", @"中心List弹出框"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HHPopupTableViewControllerCell"];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HHPopupTableViewControllerCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArray[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title = self.dataArray[indexPath.row];
    
    switch (indexPath.row) {
        case 0:
        {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            [HHPopupTool showInView:cell titles:@[@"111", @"2223334343434"] action:^(NSInteger index, YBPopupMenu * _Nonnull popupMenu) {
                [HHToastTool show:popupMenu.titles[index]];
            }];
        }
            break;
        case 1:
        {
            NSArray *arr = @[@"1", @"2", @"3", @"4", @"1", @"2", @"3", @"4"];
            
            [HHPopupTool showPopupBottomListTitle:title dataArray:arr action:^(NSInteger index, NSString * _Nonnull text) {
                [HHToastTool show:text];

            }];
            
        }
            break;
        case 2:
        {
            NSArray *arr = @[@"1", @"2", @"3", @"1", @"2", @"3", @"4"];
            
            [HHPopupTool showPopupCenterListTitle:title dataArray:arr action:^(NSInteger index, NSString * _Nonnull text) {
                [HHToastTool show:text];

            }];
        }
            break;
        default:
            break;
    }
    
}

@end
