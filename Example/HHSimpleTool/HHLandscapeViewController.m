//
//  HHLandscapeViewController.m
//  HHSimpleTool_Example
//
//  Created by Henry on 2022/9/27.
//  Copyright © 2022 1325049637@qq.com. All rights reserved.
//

#import "HHLandscapeViewController.h"
#import <HHSimpleTool/HHTool.h>

@interface HHLandscapeViewController ()

@property (nonatomic, strong) UIView *leftView;
@property (nonatomic, strong) UIView *rightView;

@end

@implementation HHLandscapeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"viewDidLoad: %@", NSStringFromCGRect(self.view.frame));
    
    [self setupUI];
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSLog(@"viewDidLayoutSubviews: %@", NSStringFromCGRect(self.view.frame));
}

- (void)setupUI {
    CGFloat itemWidth = 44;
    
    CGFloat leftWidth = [HHUtilities hh_safeAreaInset].left;
    CGFloat rightWidth = [HHUtilities hh_safeAreaInset].right;
    
    leftWidth += itemWidth;
    rightWidth += itemWidth;
    CGRect leftFrame = CGRectMake(0, 0, leftWidth, self.view.height);
    CGRect rightFrame = CGRectMake(self.view.width - rightWidth, 0, rightWidth, self.view.height);
    self.leftView = [[UIView alloc] initWithFrame:leftFrame];
    self.leftView.backgroundColor = [UIColor redColor];
    
    self.rightView = [[UIView alloc] initWithFrame:rightFrame];
    self.rightView.backgroundColor = [UIColor redColor];

    [self.view addSubview:self.leftView];
    [self.view addSubview:self.rightView];
}

@end
