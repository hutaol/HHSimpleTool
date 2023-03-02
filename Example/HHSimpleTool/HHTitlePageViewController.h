//
//  HHTitlePageViewController.h
//  HHSimpleTool_Example
//
//  Created by Henry on 2023/3/2.
//  Copyright © 2023 1325049637@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JXCategoryView/JXCategoryView.h>
#import <JXCategoryView/JXCategoryListContainerView.h>

NS_ASSUME_NONNULL_BEGIN

/// 更多参考: https://github.com/pujiaxin33/JXCategoryView
@interface HHTitlePageViewController : UIViewController <JXCategoryListContainerViewDelegate, JXCategoryViewDelegate>

@property (nonatomic, strong) NSMutableArray<NSString *> *titles;
@property (nonatomic, strong) NSMutableArray<UIViewController<JXCategoryListContentViewDelegate> *> *viewControllers;

@property (nonatomic, strong) JXCategoryTitleView *titleCategoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

/// 当前显示的UIViewController
@property (nonatomic, strong, readonly) UIViewController *currentViewController;

/// listContainer 是否能够滚动，默认滚动
@property (nonatomic, assign) BOOL scrollEnabled;

/// 选中的index
@property (nonatomic, assign) int selectIndex;

- (CGFloat)preferredCategoryViewHeight;

- (void)reloadData;

@end

NS_ASSUME_NONNULL_END
