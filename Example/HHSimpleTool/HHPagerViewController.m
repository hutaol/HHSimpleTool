//
//  HHPagerViewController.m
//  HHSimpleTool_Example
//
//  Created by aa on 2023/3/3.
//  Copyright © 2023 1325049637@qq.com. All rights reserved.
//

#import "HHPagerViewController.h"
#import <Masonry/Masonry.h>
#import "HHPagerListViewController.h"

@interface HHPagerViewController ()

@end

@implementation HHPagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = @[@"pp", @"mm"].mutableCopy;
    
    HHPagerListViewController *vc = [HHPagerListViewController new];
    vc.view.backgroundColor = [UIColor redColor];
    
    HHPagerListViewController *vc1 = [HHPagerListViewController new];
    vc1.view.backgroundColor = [UIColor yellowColor];
    
    self.viewControllers = @[vc, vc1].mutableCopy;
    
    [self.view addSubview:self.pagerView];
    
    [self.pagerView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.edges.equalTo(self.view);
        }
    }];
    
    self.titleCategoryView.titles = self.titles;
    [self.titleCategoryView reloadData];
}

#pragma mark - JXPagerViewDelegate

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return 100;
}

- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor redColor];
    return view;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return 44;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor blueColor];
    return self.titleCategoryView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    return self.viewControllers.count;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    if (self.viewControllers.count > index) {
        return self.viewControllers[index];
    }
    return nil;
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    
}

#pragma mark - Getters && Setters

- (JXPagerView *)pagerView {
    if (!_pagerView) {
        _pagerView = [[JXPagerView alloc] initWithDelegate:self listContainerType:JXPagerListContainerType_CollectionView];
    }
    return _pagerView;
}

- (JXCategoryTitleView *)titleCategoryView {
    if (!_titleCategoryView) {
        _titleCategoryView = [[JXCategoryTitleView alloc] init];
        _titleCategoryView.delegate = self;
        
        // !!!: 将列表容器视图关联到 categoryView
        _titleCategoryView.listContainer = (id<JXCategoryViewListContainer>)self.pagerView.listContainerView;
    }
    return _titleCategoryView;
}

@end
