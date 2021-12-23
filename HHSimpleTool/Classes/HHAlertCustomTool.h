//
//  HHAlertCustomTool.h
//  HHTool
//
//  Created by Henry on 2020/11/3.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHAlertCustomTool : NSObject

+ (UIViewController *)topViewController;

/// 确定 警示框
/// @param message 提示信息
+ (void)alertWithMessage:(NSString *)message;

/// 取消，确定 警示框
/// @param message 提示信息
/// @param confirmBlock 确定回调
+ (void)alert2WithMessage:(NSString *)message confirmBlock:(nullable void(^)(NSInteger buttonIndex, NSString *buttonTitle))confirmBlock;

/// 警示框
/// @param title 标题
/// @param message 提示信息
/// @param cancelTitle 取消按钮
/// @param buttonTitles 其他按钮
/// @param actionsBlock 回调 buttonIndex 取消=-1，其他从0开始
+ (void)alertWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelTitle:(nullable NSString *)cancelTitle buttonTitles:(nullable NSArray <NSString *> *)buttonTitles actionsBlock:(nullable nullable void(^)(NSInteger buttonIndex, NSString *buttonTitle))actionsBlock;

/// Sheet提示框
/// @param title 标题
/// @param message 提示信息
/// @param cancelTitle 取消按钮
/// @param destructiveTitle 红警按钮
/// @param buttonTitles 其他按钮
/// @param actionsBlock 回调 buttonIndex 取消=-1  destructiveTitle=-2   其他从0开始
+ (void)sheetWithTitle:(nullable NSString *)title message:(nullable NSString *)message cancelTitle:(nullable NSString *)cancelTitle  destructiveTitle:(nullable NSString *)destructiveTitle buttonTitles:(nullable NSArray <NSString *> *)buttonTitles actionsBlock:(nullable nullable void(^)(NSInteger buttonIndex, NSString *buttonTitle))actionsBlock;

/// Sheet提示框 有取消
/// @param message 提示信息
/// @param buttonTitles 其他按钮
/// @param actionsBlock 回调 buttonIndex 从0开始
+ (void)sheetWithMessage:(nullable NSString *)message buttonTitles:(nullable NSArray <NSString *> *)buttonTitles actionsBlock:(nullable nullable void(^)(NSInteger buttonIndex, NSString *buttonTitle))actionsBlock;

/// Alert带多个输入框
/// @param title 标题
/// @param message 信息
/// @param placeholders 输入框占位符数组
/// @param cancelTitle 取消标题
/// @param buttonTitles 其他按钮
/// @param actionsBlock 回调 buttonIndex 取消=-1  其他从0开始
+ (void)inputWithTitle:(NSString *)title message:(NSString *)message placeholders:(NSArray<NSString *> *)placeholders cancelTitle:(NSString *)cancelTitle buttonTitles:(NSArray<NSString *> *)buttonTitles actionsBlock:(void (^)(NSInteger buttonIndex, NSString * buttonTitle, NSArray<UITextField *> *textFields))actionsBlock;

/// Alert带单个输入框
/// @param title 标题
/// @param message 信息
/// @param placeholder 输入框占位符
/// @param cancel 取消标题
/// @param confirm 确定标题
/// @param confirmBlock 确定回调
+ (void)inputWithTitle:(NSString *)title message:(NSString *)message placeholder:(NSString *)placeholder cancel:(NSString *)cancel confirm:(NSString *)confirm confirmBlock:(nullable void(^)(NSString *inputText))confirmBlock;

@end

NS_ASSUME_NONNULL_END
