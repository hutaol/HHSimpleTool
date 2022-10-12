//
//  HHAlertPop.h
//  Pods
//
//  Created by Henry on 2022/5/25.
//

#import <LSTPopView/LSTPopView.h>
#import "HHAlertView.h"

NS_ASSUME_NONNULL_BEGIN

/// LSTPopView
@interface HHAlertPop : NSObject

#pragma mark - Alert

/// 警示框 确定
/// @param message 提示信息
+ (LSTPopView *)alertWithMessage:(nullable NSString *)message;

/// 警示框 确定
/// @param title 标题
/// @param message 内容
+ (LSTPopView *)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message;

/// 警示框 确定
/// @param title 标题
/// @param message 内容
/// @param confirmBlock 回调
+ (LSTPopView *)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message confirmBlock:(nullable void(^)(void))confirmBlock;

/// 警示框 取消，确定
/// @param title 标题
/// @param message 内容
/// @param confirmBlock 确定回调
+ (LSTPopView *)alert2WithTitle:(nullable NSString *)title message:(nullable NSString *)message confirmBlock:(nullable void(^)(void))confirmBlock;

/// 警示框 取消，确定
/// @param title 标题
/// @param message 内容
/// @param confirm 按钮
/// @param confirmBlock 确定回调
+ (LSTPopView *)alert2WithTitle:(nullable NSString *)title message:(nullable NSString *)message confirm:(nullable NSString *)confirm confirmBlock:(nullable void(^)(void))confirmBlock;

/// 警示框 2个按钮
/// @param title 标题
/// @param message 内容
/// @param first 按钮
/// @param last 按钮
/// @param actionBlock 回调
+ (LSTPopView *)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message first:(nullable NSString *)first last:(nullable NSString *)last actionBlock:(nullable void(^)(NSInteger buttonIndex, NSString *buttonTitle))actionBlock;

/// 警示框 自定义Action
/// @param title 标题
/// @param message 内容
/// @param configBlock 配置
+ (LSTPopView *)alertWithTitle:(NSString *)title message:(NSString *)message configBlock:(void (^)(HHAlertView *alertView, LSTPopView *popView))configBlock;

#pragma mark - Sheet

/// Sheet提示框 有取消
/// @param message 标题
/// @param buttonTitles 其他按钮
/// @param actionsBlock 回调 buttonIndex 从0开始
+ (LSTPopView *)sheetWithMessage:(nullable NSString *)message buttonTitles:(nullable NSArray <NSString *> *)buttonTitles actionsBlock:(nullable void(^)(NSInteger buttonIndex, NSString *buttonTitle))actionsBlock;

/// Sheet提示框 自定义Action
/// @param title 标题
/// @param message 内容
/// @param configBlock 配置
+ (LSTPopView *)sheetWithTitle:(nullable NSString *)title message:(nullable NSString *)message configBlock:(nullable void (^)(HHAlertView *alertView, LSTPopView *popView))configBlock;

#pragma mark - Input

/// Alert带单个输入框 取消和确定按钮
/// @param title 标题
/// @param message 内容
/// @param placeholder 输入框占位符
/// @param confirmBlock 回调 inputText
+ (LSTPopView *)inputWithTitle:(nullable NSString *)title message:(nullable NSString *)message placeholder:(nullable NSString *)placeholder confirmBlock:(nullable void (^)(NSString *inputText))confirmBlock;

@end

NS_ASSUME_NONNULL_END
