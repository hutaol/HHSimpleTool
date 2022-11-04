//
//  UIButton+HHTool.h
//  Pods
//
//  Created by Henry on 2022/10/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (HHTool)

/// 字符串标记
@property (nonatomic, copy) NSString *hh_tag;

/// 设置按钮额外热区
@property (nonatomic, assign) UIEdgeInsets hh_touchAreaInsets;

- (void)hh_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
