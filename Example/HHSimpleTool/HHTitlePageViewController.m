//
//  HHTitlePageViewController.m
//  HHSimpleTool_Example
//
//  Created by Henry on 2023/3/2.
//  Copyright © 2023 1325049637@qq.com. All rights reserved.
//

#import "HHTitlePageViewController.h"
#import <Masonry/Masonry.h>

@interface HHTitlePageViewController ()

@property (nonatomic, strong) UIViewController *currentViewController;

@end

@implementation HHTitlePageViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollEnabled = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.titleCategoryView];
    [self.view addSubview:self.listContainerView];
    
    [self.titleCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.height.equalTo(@([self preferredCategoryViewHeight]));
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.equalTo(self.view);
        }
    }];
    [self.listContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.titleCategoryView.mas_bottom);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.equalTo(self.view);
        }
    }];
}

- (CGFloat)preferredCategoryViewHeight {
    return 44;
}

- (void)reloadData {
    self.titleCategoryView.titles = self.titles;
    [self.titleCategoryView reloadData];
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    if (self.viewControllers.count > index) {
        self.currentViewController = self.viewControllers[index];
    }

    // 侧滑手势处理
    if (self.scrollEnabled) {
        self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
    }
    
}

#pragma mark - JXCategoryListContainerViewDelegate

- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    return self.titles.count;
}

- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    if (self.viewControllers.count > index) {
        if (index == self.titleCategoryView.selectedIndex) {
            self.currentViewController = self.viewControllers[index];
        }
        return self.viewControllers[index];
    }
    return nil;
}


#pragma mark - Getters && Setters

- (void)setSelectIndex:(int)selectIndex {
    _selectIndex = selectIndex;
    self.titleCategoryView.defaultSelectedIndex = selectIndex;
}

- (void)setScrollEnabled:(BOOL)scrollEnabled {
    _scrollEnabled = scrollEnabled;
    self.listContainerView.scrollView.scrollEnabled = scrollEnabled;
}

- (JXCategoryTitleView *)titleCategoryView {
    if (!_titleCategoryView) {
        _titleCategoryView = [[JXCategoryTitleView alloc] init];
        _titleCategoryView.delegate = self;
        
        // !!!: 将列表容器视图关联到 categoryView
        _titleCategoryView.listContainer = self.listContainerView;
    }
    return _titleCategoryView;
}

- (JXCategoryListContainerView *)listContainerView {
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    }
    return _listContainerView;
}

- (NSMutableArray<NSString *> *)titles {
    if (!_titles) {
        _titles = [NSMutableArray array];
    }
    return _titles;
}

- (NSMutableArray<UIViewController<JXCategoryListContentViewDelegate> *> *)viewControllers {
    if (!_viewControllers) {
        _viewControllers = [NSMutableArray array];
    }
    return _viewControllers;
}

@end
