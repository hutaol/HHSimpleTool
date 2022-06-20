//
//  HHAlertTableViewController.m
//  HHTool_Example
//
//  Created by Henry on 2021/5/6.
//  Copyright © 2021 1325049637@qq.com. All rights reserved.
//

#import "HHAlertTableViewController.h"
#import <HHSimpleTool/HHTool.h>

@interface HHAlertTableViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation HHAlertTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提示框";
    
    self.dataArray = @[@"系统 无按钮", @"系统 取消和确定按钮", @"系统 多按钮",  @"系统 简易Sheet", @"系统 Sheet",
                       @"自定义 无按钮", @"自定义 取消和确定按钮", @"自定义 多按钮",  @"系统 简易Sheet", @"自定义 Sheet", @"系统 单个Input", @"系统 多个Input", @"自定义 单个Input", @"自定义 多个Input", @"PopView Alert", @"PopView Sheet", @"PopView Input"];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HHAlertTableViewControllerCell"];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HHAlertTableViewControllerCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = self.dataArray[indexPath.row];
    
    switch (indexPath.row) {
        case 0:
        {
            [HHAlertTool alertWithMessage:title];
        }
            break;
        case 1:
        {
            [HHAlertTool alert2WithMessage:title confirmBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
                [HHToastTool show:buttonTitle];
            }];
        }
            break;
        case 2:
        {
            [HHAlertTool alertWithTitle:title message:@"消息" cancelTitle:@"取消" buttonTitles:@[@"按钮1", @"按钮2"] actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
                [HHToastTool show:buttonTitle];
            }];
        }
            break;
        case 3:
        {
            [HHAlertTool sheetWithMessage:title buttonTitles:@[@"按钮1", @"按钮2"] actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
                [HHToastTool show:buttonTitle];
            }];
        }
            break;
        case 4:
        {
            [HHAlertTool sheetWithTitle:title message:@"消息" cancelTitle:@"取消" destructiveTitle:@"破坏" buttonTitles:@[@"按钮1", @"按钮2"] actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
                [HHToastTool show:buttonTitle];
            }];
        }
            break;
        case 5:
        {
            [HHAlertCustomTool alertWithMessage:title];
        }
            break;
        case 6:
        {
            [HHAlertCustomTool alert2WithMessage:title confirmBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
                [HHToastTool show:buttonTitle];
            }];
        }
            break;
        case 7:
        {
            [HHAlertCustomTool alertWithTitle:title message:@"消息" cancelTitle:@"取消" buttonTitles:@[@"按钮1", @"按钮2"] actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
                [HHToastTool show:buttonTitle];
            }];
        }
            break;
        case 8:
        {
            [HHAlertCustomTool sheetWithMessage:title buttonTitles:@[@"按钮1", @"按钮2"] actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
                [HHToastTool show:buttonTitle];
            }];
        }
            break;
        case 9:
        {
            [HHAlertCustomTool sheetWithTitle:title message:@"消息" cancelTitle:@"取消" destructiveTitle:@"破坏" buttonTitles:@[@"按钮1", @"按钮2"] actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
                [HHToastTool show:buttonTitle];
            }];
        }
            break;
        case 10:
        {
            [HHAlertTool inputWithTitle:title message:@"消息" placeholder:@"请输入" cancel:@"取消" confirm:@"确定" confirmBlock:^(NSString * _Nonnull inputText) {
                [HHToastTool show:inputText];
            }];
        }
            break;
        case 11:
        {
            [HHAlertTool inputWithTitle:title message:@"消息" placeholders:@[@"请输入1", @"请输入2"] cancelTitle:@"取消" buttonTitles:@[@"确定"] actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle, NSArray<UITextField *> * _Nonnull textFields) {
                NSString *title = [NSString stringWithFormat:@"%@ %@ - %@", buttonTitle, textFields[0].text, textFields[1].text];
                [HHToastTool show:title];
            }];
        }
            break;
        case 12:
        {
            [HHAlertCustomTool inputWithTitle:title message:@"消息" placeholder:@"请输入" cancel:@"取消" confirm:@"确定" confirmBlock:^(NSString * _Nonnull inputText) {
                [HHToastTool show:inputText];
            }];
        }
            break;
        case 13:
        {
            [HHAlertCustomTool inputWithTitle:title message:@"消息" placeholders:@[@"请输入1", @"请输入2"] cancelTitle:@"取消" buttonTitles:@[@"确定"] actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle, NSArray<UITextField *> * _Nonnull textFields) {
                NSString *title = [NSString stringWithFormat:@"%@ %@ - %@", buttonTitle, textFields[0].text, textFields[1].text];
                [HHToastTool show:title];
            }];
        }
            break;
        case 14:
        {
            [HHAlertPop alertWithTitle:title message:@"内容" configBlock:^(HHAlertView * _Nonnull alertView, LSTPopView * _Nonnull popView) {

                HHAlertAction *action = [HHAlertAction actionWithTitle:@"取消" handler:^(HHAlertAction * _Nonnull action) {
                    [HHToastTool show:action.title];
                }];
                action.titleColor = [UIColor blueColor];
                [alertView addAction:action];
                
                HHAlertAction *action2 = [HHAlertAction actionWithTitle:@"确定" handler:^(HHAlertAction * _Nonnull action) {
                    [HHToastTool show:action.title];
                }];
                action2.titleColor = [UIColor redColor];
                [alertView addAction:action2];
                
            }];

        }
            break;
        case 15:
        {
            [HHAlertPop sheetWithMessage:@"" buttonTitles:@[@"选项1", @"选项2"] actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
                [HHToastTool show:buttonTitle];
            }];
        }
            break;
        case 16:
        {
            [HHAlertPop inputWithTitle:@"" message:@"输入框" placeholder:@"请输入" confirmBlock:^(NSString * _Nonnull inputText) {
                [HHToastTool show:inputText];
            }];
        }
            break;
    }
}

@end
