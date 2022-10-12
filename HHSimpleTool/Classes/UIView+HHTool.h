//
//  UIView+HHTool.h
//  Pods
//
//  Created by Henry on 2022/10/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HHTool)

/// view截图
- (UIImage *)hh_screenshot;
- (UIImage *)hh_screenshot:(CGFloat)maxWidth;

@end

NS_ASSUME_NONNULL_END
