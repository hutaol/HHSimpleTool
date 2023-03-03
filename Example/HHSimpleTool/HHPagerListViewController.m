//
//  HHPagerListViewController.m
//  HHSimpleTool_Example
//
//  Created by aa on 2023/3/3.
//  Copyright © 2023 1325049637@qq.com. All rights reserved.
//

#import "HHPagerListViewController.h"

@interface HHPagerListViewController ()

@end

@implementation HHPagerListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (UIView *)listView {
    return self.view;
}

- (UIScrollView *)listScrollView {
    return nil;
}


- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    
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
