//
//  HHPagerViewController.h
//  HHSimpleTool_Example
//
//  Created by aa on 2023/3/3.
//  Copyright © 2023 1325049637@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JXPagerView.h>
#import <JXCategoryView/JXCategoryView.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHPagerViewController : UIViewController <JXPagerViewDelegate, JXCategoryViewDelegate>

@property (nonatomic, strong) NSMutableArray<NSString *> *titles;
@property (nonatomic, strong) NSMutableArray<UIViewController<JXPagerViewListViewDelegate> *> *viewControllers;

@property (nonatomic, strong) JXPagerView *pagerView;
@property (nonatomic, strong) JXCategoryTitleView *titleCategoryView;

@end

NS_ASSUME_NONNULL_END
