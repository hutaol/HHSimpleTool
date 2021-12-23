//
//  UIScrollView+HHLoading.h
//  Pods
//
//  Created by Henry on 2021/1/5.
//

#import <UIKit/UIKit.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^LoadingBlock)(void);

@interface UIScrollView (HHLoading) <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

/// 是否在加载 YES:转菊花 or NO:立即空界面
/// 设置了这个相当于开启了代理
/// PS:在加载数据前设置为YES(必需)，随后根据数据调整为NO(可选)
@property (nonatomic, assign) BOOL loading;

/// 不加载状态下的图片(loading = NO)
/// PS:空状态下显示图片
@property (nonatomic, strong) UIImage *loadedImage;
@property (nonatomic, copy) NSString *loadedImageName;

/// 空状态下的文字
@property (nonatomic, copy) NSString *descriptionTitle;
@property (nonatomic, copy) NSString *descriptionText;

/// 空状态 刷新按钮
@property (nonatomic, copy) NSString *buttonText;
@property (nonatomic, strong) UIColor *buttonNormalColor;
@property (nonatomic, strong) UIColor *buttonHighlightColor;

/// 视图的垂直位置
/// PS:tableView中心点为基准点,(基准点＝0)
@property (nonatomic, assign) CGFloat dataVerticalOffset;

/// 点击回调block的属性
@property (nonatomic,copy) LoadingBlock loadingClick;

- (void)onLoading:(LoadingBlock)block;

@end

NS_ASSUME_NONNULL_END
