//
//  HHMainViewController.m
//  HHTool_Example
//
//  Created by Henry on 2021/1/5.
//  Copyright © 2021 1325049637@qq.com. All rights reserved.
//

#import "HHMainViewController.h"
#import "HHEmptyDataSetTableViewController.h"
#import "HHAlertTableViewController.h"
#import "HHProgressHUDViewController.h"
#import "HHPopupTableViewController.h"
#import <UIWindow+HHHelper.h>
#import "HHAppDelegate.h"

#define kAPPDelegate ((HHAppDelegate*)[[UIApplication sharedApplication] delegate])

@interface HHMainViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation HHMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"例子";
    
    self.dataArray = @[
        @{@"title":@"EmptyDataSet", @"vc":@"HHEmptyDataSetTableViewController"},
        @{@"title":@"Alert", @"vc":@"HHAlertTableViewController"},
        @{@"title":@"加载提示框", @"vc":@"HHProgressHUDViewController"},
        @{@"title":@"Popup", @"vc":@"HHPopupTableViewController"},
        @{@"title":@"Layer动画", @"vc":@"HHLayerViewController"},
    ];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换横屏" style:UIBarButtonItemStylePlain target:self action:@selector(switchOrientation)];
}

- (void)switchOrientation {
    if ([UIWindow isLandscape]) {
        // 切换竖屏
        kAPPDelegate.orientationMask = UIInterfaceOrientationMaskPortrait;
        [UIWindow forcedOrientationPortrait];

        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换横屏" style:UIBarButtonItemStylePlain target:self action:@selector(switchOrientation)];

    } else {
        kAPPDelegate.orientationMask = UIInterfaceOrientationMaskLandscape;
        [UIWindow forcedOrientationLandscape];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换竖屏" style:UIBarButtonItemStylePlain target:self action:@selector(switchOrientation)];

    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArray[indexPath.row][@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *str = self.dataArray[indexPath.row][@"vc"];
    NSString *title = self.dataArray[indexPath.row][@"title"];
    UIViewController *vc = [[NSClassFromString(str) alloc] init];
    vc.title = title;
    [self.navigationController pushViewController:vc animated:YES];

}

@end
