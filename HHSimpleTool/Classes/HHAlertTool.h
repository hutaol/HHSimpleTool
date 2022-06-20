//
//  HHAlertTool.h
//  HHTool
//
//  Created by Henry on 2020/11/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// UIAlertController
@interface HHAlertTool : NSObject

+ (UIViewController *)topViewController;

#pragma mark - Alert

/// 确定 警示框
/// @param message 提示信息
+ (UIAlertController *)alertWithMessage:(nullable NSString *)message;

/// 确定 警示框
/// @param title 标题
/// @param message 内容
+ (UIAlertController *)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message;

/// 确定 警示框
/// @param title 标题
/// @param message 内容
/// @param confirmBlock 回调
+ (UIAlertController *)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message confirmBlock:(nullable void(^)(void))confirmBlock;

/// 确定 警示框
/// @param title 标题
/// @param message 提示信息
/// @param button 确定文字
/// @param confirmBlock 确定回调
+ (UIAlertController *)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message button:(nullable NSString *)button confirmBlock:(nullable void(^)(void))confirmBlock;

/// 取消，确定 警示框
/// @param message 提示信息
/// @param confirmBlock 确定回调
+ (UIAlertController *)alert2WithMessage:(nullable NSString *)message confirmBlock:(nullable void(^)(NSInteger buttonIndex, NSString *buttonTitle))confirmBlock;

/// 自定义取消，确定 警示框
/// @param message 提示信息
/// @param cancel 取消文字
/// @param confirm 确定文字
/// @param confirmBlock 确定回调
+ (UIAlertController *)alert2WithMessage:(nullable NSString *)message cancel:(nullable NSString *)cancel confirm:(nullable NSString *)confirm confirmBlock:(nullable void(^)(NSInteger buttonIndex, NSString *buttonTitle))confirmBlock;

/// 警示框
/// @param title 标题
/// @param message 提示信息
/// @param cancelTitle 取消按钮
/// @param buttonTitles 其他按钮
/// @param actionsBlock 回调 buttonIndex 取消=-1，其他从0开始
+ (UIAlertController *)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelTitle:(nullable NSString *)cancelTitle buttonTitles:(nullable NSArray <NSString *> *)buttonTitles actionsBlock:(nullable void(^)(NSInteger buttonIndex, NSString *buttonTitle))actionsBlock;

#pragma mark - Sheet

/// Sheet提示框
/// @param title 标题
/// @param message 提示信息
/// @param cancelTitle 取消按钮
/// @param destructiveTitle 红警按钮
/// @param buttonTitles 其他按钮
/// @param actionsBlock 回调 buttonIndex 取消=-1  destructiveTitle=-2   其他从0开始
+ (UIAlertController *)sheetWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelTitle:(nullable NSString *)cancelTitle  destructiveTitle:(nullable NSString *)destructiveTitle buttonTitles:(nullable NSArray <NSString *> *)buttonTitles actionsBlock:(nullable void(^)(NSInteger buttonIndex, NSString *buttonTitle))actionsBlock;

/// Sheet提示框 有取消
/// @param message 标题
/// @param buttonTitles 其他按钮
/// @param actionsBlock 回调 buttonIndex 从0开始
+ (UIAlertController *)sheetWithMessage:(nullable NSString *)message buttonTitles:(nullable NSArray <NSString *> *)buttonTitles actionsBlock:(nullable void(^)(NSInteger buttonIndex, NSString *buttonTitle))actionsBlock;

#pragma mark - Input

/// Alert带多个输入框
/// @param title 标题
/// @param message 信息
/// @param placeholders 输入框占位符数组
/// @param cancelTitle 取消标题
/// @param buttonTitles 其他按钮
/// @param actionsBlock 回调 buttonIndex 取消=-1  其他从0开始
+ (UIAlertController *)inputWithTitle:(nullable NSString *)title message:(nullable NSString *)message placeholders:(nullable NSArray<NSString *> *)placeholders cancelTitle:(nullable NSString *)cancelTitle buttonTitles:(nullable NSArray<NSString *> *)buttonTitles actionsBlock:(nullable void (^)(NSInteger buttonIndex, NSString * buttonTitle, NSArray<UITextField *> *textFields))actionsBlock;

/// Alert带单个输入框
/// @param title 标题
/// @param message 信息
/// @param placeholder 输入框占位符
/// @param cancel 取消标题
/// @param confirm 确定标题
/// @param confirmBlock 确定回调
+ (UIAlertController *)inputWithTitle:(nullable NSString *)title message:(nullable NSString *)message placeholder:(nullable NSString *)placeholder cancel:(nullable NSString *)cancel confirm:(nullable NSString *)confirm confirmBlock:(nullable void(^)(NSString *inputText))confirmBlock;

/// Alert带单个输入框 取消和确定按钮
/// @param title 标题
/// @param message 信息
/// @param placeholder 输入框占位符
/// @param confirmBlock 确定回调
+ (UIAlertController *)inputWithTitle:(nullable NSString *)title message:(nullable NSString *)message placeholder:(nullable NSString *)placeholder confirmBlock:(nullable void(^)(NSString *inputText))confirmBlock;

@end

NS_ASSUME_NONNULL_END
