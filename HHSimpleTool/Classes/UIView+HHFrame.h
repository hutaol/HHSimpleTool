//
//  UIView+HHFrame.h
//  HHTool
//
//  Created by Henry on 2020/11/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HHFrame)

@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat top;

@property (nonatomic) CGFloat right;

@property (nonatomic) CGFloat bottom;

@property (nonatomic) CGFloat width;

@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;

@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGPoint origin;

@property (nonatomic) CGSize size;

/// 安全边距
@property (nonatomic, readonly) CGFloat safeBottom;
@property (nonatomic, readonly) CGFloat safeTop;
@property (nonatomic, readonly) UIEdgeInsets safeInsets;

/// 基于superview
@property (nonatomic, readonly) CGFloat screenX;
@property (nonatomic, readonly) CGFloat screenY;
@property (nonatomic, readonly) CGRect screenFrame;

/// 基于superview 包括UIScrollView的contentOffset
@property (nonatomic, readonly) CGFloat screenContentX;
@property (nonatomic, readonly) CGFloat screenContentY;
@property (nonatomic, readonly) CGRect screenContentFrame;

/// 基于keyWindow位置
@property (nonatomic, readonly) CGFloat windowX;
@property (nonatomic, readonly) CGFloat windowY;
@property (nonatomic, readonly) CGRect windowFrame;

@end

NS_ASSUME_NONNULL_END
