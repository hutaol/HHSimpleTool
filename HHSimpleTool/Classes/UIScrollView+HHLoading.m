//
//  UIScrollView+HHLoading.m
//  Pods
//
//  Created by Henry on 2021/1/5.
//

#import "UIScrollView+HHLoading.h"
#import <objc/runtime.h>

static const BOOL loadingKey;
static const char loadedImageKey;
static const char loadedImageNameKey;
static const char descriptionTextKey;
static const char descriptionTitleKey;
static const char buttonTextKey;
static const char buttonNormalColorKey;
static const char buttonHighlightColorKey;
static const CGFloat dataVerticalOffsetKey;

id (^block)(void);

@implementation UIScrollView (HHLoading)

#pragma mark - 利用runtime 添加属性 set Mettod
- (void)setLoading:(BOOL)loading {
    if (self.loading == loading) {
        return;
    }
    
    objc_setAssociatedObject(self, &loadingKey, @(loading), OBJC_ASSOCIATION_ASSIGN);

    self.emptyDataSetSource = self;
    self.emptyDataSetDelegate = self;

    [self reloadEmptyDataSet];

}

- (void)setLoadedImage:(UIImage *)loadedImage {
    objc_setAssociatedObject(self, &loadedImageKey, loadedImage, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setLoadedImageName:(NSString *)loadedImageName {
    objc_setAssociatedObject(self, &loadedImageNameKey, loadedImageName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setDescriptionTitle:(NSString *)descriptionTitle {
    objc_setAssociatedObject(self, &descriptionTitleKey, descriptionTitle, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setDescriptionText:(NSString *)descriptionText {
    objc_setAssociatedObject(self, &descriptionTextKey, descriptionText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setButtonText:(NSString *)buttonText {
    objc_setAssociatedObject(self, &buttonTextKey, buttonText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setButtonNormalColor:(UIColor *)buttonNormalColor {
    objc_setAssociatedObject(self, &buttonNormalColorKey, buttonNormalColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setButtonHighlightColor:(UIColor *)buttonHighlightColor {
    objc_setAssociatedObject(self, &buttonHighlightColorKey, buttonHighlightColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setDataVerticalOffset:(CGFloat)dataVerticalOffset {
    objc_setAssociatedObject(self, &dataVerticalOffsetKey, @(dataVerticalOffset), OBJC_ASSOCIATION_RETAIN);
}

- (void)setLoadingClick:(LoadingBlock)loadingClick {
    objc_setAssociatedObject(self, &block, loadingClick, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

#pragma mark - 利用runtime 添加属性 get Mettod

- (BOOL)loading {
    id tmp = objc_getAssociatedObject(self, &loadingKey);
    NSNumber *number = tmp;
    return number.unsignedIntegerValue;
}

- (UIImage *)loadedImage {
    return objc_getAssociatedObject(self, &loadedImageKey);
}

- (NSString *)loadedImageName {
    return objc_getAssociatedObject(self, &loadedImageNameKey);
}

- (NSString *)descriptionTitle {
    return objc_getAssociatedObject(self, &descriptionTitleKey);
}

- (NSString *)descriptionText {
    return objc_getAssociatedObject(self, &descriptionTextKey);
}

- (NSString *)buttonText {
    return objc_getAssociatedObject(self, &buttonTextKey);
}

- (UIColor *)buttonNormalColor {
    return objc_getAssociatedObject(self, &buttonNormalColorKey);
}

- (UIColor *)buttonHighlightColor {
    return objc_getAssociatedObject(self, &buttonHighlightColorKey);
}

- (CGFloat)dataVerticalOffset {
    id temp = objc_getAssociatedObject(self, &dataVerticalOffsetKey);
    NSNumber *number = temp;
    return number.floatValue;
}

- (LoadingBlock)loadingClick {
    return objc_getAssociatedObject(self, &block);
}

- (void)onLoading:(LoadingBlock)block {
    if (self.loadingClick) {
        block = self.loadingClick;
    }
    self.loadingClick = block;
}

#pragma mark - DZNEmptyDataSetSource

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.loading) {
        UIActivityIndicatorView *activityView = nil;
        if (@available(iOS 13.0, *)) {
            activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleMedium];
        } else {
            activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        }
        [activityView startAnimating];
        return activityView;
    }
    return nil;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.loading) {
        return nil;
    } else {
        if (self.loadedImageName) {
            return [UIImage imageNamed:self.loadedImageName];
        }
        
        if (self.loadedImage) {
            return self.loadedImage;
        }
    }
    return nil;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.loading) {
        return nil;
    }
    
    NSString *text = self.descriptionTitle ?: @"";

    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;

    NSDictionary *attributes = @{ NSFontAttributeName: [UIFont systemFontOfSize:17.0f],
                                  NSForegroundColorAttributeName: [UIColor grayColor],
                                  NSParagraphStyleAttributeName: paragraph };

    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.loading) {
        return nil;
    }
    
    NSString *text = self.descriptionText ?: @"暂无数据";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0f],
                                 NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];

}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    if (self.loading) {
        return nil;
    }
    
    if (self.buttonText == nil) {
        self.buttonText = @" ";
    }
        
    UIColor *textColor = nil;
    // 某种状态下的颜色
    UIColor *colorOne = [UIColor colorWithRed:253/255.0f green:120/255.0f blue:76/255.0f alpha:1];
    UIColor *colorTow = [UIColor colorWithRed:247/255.0f green:188/255.0f blue:169/255.0f alpha:1];
    // 判断外部是否有设置
    colorOne = self.buttonNormalColor ? self.buttonNormalColor : colorOne;
    colorTow = self.buttonHighlightColor ? self.buttonHighlightColor : colorTow;
    textColor = state == UIControlStateNormal ? colorOne : colorTow;
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: textColor};
    
     return [[NSAttributedString alloc] initWithString:self.buttonText  attributes:attributes];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.dataVerticalOffset != 0) {
        return self.dataVerticalOffset;
    }
    return 0.f;
}

#pragma mark - DZNEmptyDataSetDelegate

// 返回是否显示空状态的所有组件，默认:YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}

// 返回是否允许交互，默认:YES
- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    // 只有非加载状态能交互
    return !self.loading;
}

// 返回是否允许滚动，默认:YES
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

// 返回是否允许空状态下的图片进行动画，默认:NO
- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
    return YES;
}

// 点击空状态下的view会调用
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    if (self.loadingClick) {
        self.loadingClick();
        [self reloadEmptyDataSet];
    }
}

// 点击空状态下的按钮会调用
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    if (self.loadingClick) {
        self.loadingClick();
        [self reloadEmptyDataSet];
    }
}

@end
