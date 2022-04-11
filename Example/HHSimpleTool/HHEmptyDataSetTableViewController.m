//
//  HHEmptyDataSetTableViewController.m
//  HHTool_Example
//
//  Created by Henry on 2021/1/5.
//  Copyright © 2021 1325049637@qq.com. All rights reserved.
//

#import "HHEmptyDataSetTableViewController.h"
#import <HHSimpleTool/HHTool.h>

@interface HHEmptyDataSetTableViewController ()

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation HHEmptyDataSetTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.loading = YES;
    self.tableView.descriptionTitle = @"无数据";
    self.tableView.buttonText = @"点击刷新";
    self.tableView.loadedImageName = @"icon_no_data";
    self.tableView.descriptionTitleFont = [UIFont systemFontOfSize:30];
    self.tableView.descriptionTitleColor = [UIColor blueColor];
    self.tableView.descriptionTextFont = [UIFont systemFontOfSize:20];
    self.tableView.descriptionTextColor = [UIColor orangeColor];
    self.tableView.buttonTextFont = [UIFont systemFontOfSize:30];
    self.tableView.dataVerticalOffset = -100;
    self.tableView.dataSpaceHeight = 20;
    
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 1; i <= 6; i ++) {
        [arr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"refresh%d", i]]];
    }
    self.tableView.loadingImages = arr;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    __weak typeof(self) ws = self;
    self.tableView.loadingClick = ^{
        [ws setupData];
    };
    
    [self setupData];
    
}

- (void)setupData {
    self.tableView.loading = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.data = @[@"1", @"2", @"3"].mutableCopy;
        self.data = @[].mutableCopy;

        self.tableView.loading = NO;
        [self.tableView reloadData];
    });
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
