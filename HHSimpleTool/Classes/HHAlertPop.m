//
//  HHAlertPop.m
//  Pods
//
//  Created by Henry on 2022/5/25.
//

#import "HHAlertPop.h"
#import "HHDefine.h"

@implementation HHAlertPop

+ (LSTPopView *)alertWithMessage:(NSString *)message {
    return [self alertWithTitle:nil message:message];
}

+ (LSTPopView *)alertWithTitle:(NSString *)title message:(NSString *)message {
    return [self alertWithTitle:title message:message confirmBlock:nil];
}

+ (LSTPopView *)alertWithTitle:(NSString *)title message:(NSString *)message confirmBlock:(void (^)(void))confirmBlock {
    return [self alertWithTitle:title message:message first:HHGetLocalLanguageTextValue(@"Done") last:nil actionBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
        if (confirmBlock) {
            confirmBlock();
        }
    }];
}

+ (LSTPopView *)alert2WithTitle:(NSString *)title message:(NSString *)message confirmBlock:(void (^)(void))confirmBlock {
    return [self alertWithTitle:title message:message first:HHGetLocalLanguageTextValue(@"Cancel") last:HHGetLocalLanguageTextValue(@"Done") actionBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
        if (buttonIndex == 1) {
            if (confirmBlock) {
                confirmBlock();
            }
        }
    }];
}

+ (LSTPopView *)alert2WithTitle:(NSString *)title message:(NSString *)message confirm:(NSString *)confirm confirmBlock:(void (^)(void))confirmBlock {
    return [self alertWithTitle:title message:message first:HHGetLocalLanguageTextValue(@"Cancel") last:confirm actionBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
        if (buttonIndex == 1) {
            if (confirmBlock) {
                confirmBlock();
            }
        }
    }];
}

+ (LSTPopView *)alertWithTitle:(NSString *)title message:(NSString *)message first:(NSString *)first last:(NSString *)last actionBlock:(void (^)(NSInteger, NSString * _Nonnull))actionBlock {
    LSTPopView *popView = [self alertWithTitle:title message:message configBlock:^(HHAlertView * _Nonnull alertView, LSTPopView * _Nonnull popView) {
        
        if (first) {
            HHAlertAction *action = [HHAlertAction actionWithTitle:first handler:^(HHAlertAction * _Nonnull action) {
                if (actionBlock) {
                    actionBlock(0, action.title);
                }
            }];
            [alertView addAction:action];
        }
        
        if (last) {
            HHAlertAction *action = [HHAlertAction actionWithTitle:last handler:^(HHAlertAction * _Nonnull action) {
                if (actionBlock) {
                    actionBlock(1, action.title);
                }
            }];
            [alertView addAction:action];
        }
        
    }];
    return popView;
}

+ (LSTPopView *)alertWithTitle:(NSString *)title message:(NSString *)message configBlock:(void (^)(HHAlertView * _Nonnull, LSTPopView * _Nonnull))configBlock {

    HHAlertView *alertView = [HHAlertView alertWithTitle:title message:message preferredStyle:HHAlertStyleAlert];

    LSTPopView *popView = [LSTPopView initWithCustomView:alertView popStyle:LSTPopStyleFade dismissStyle:LSTDismissStyleFade];
    popView.cornerRadius = 6;
    popView.isClickBgDismiss = NO;
    
    if (configBlock) {
        configBlock(alertView, popView);
    }
    
    [popView pop];
    return popView;
}

#pragma mark - Sheet

+ (LSTPopView *)sheetWithMessage:(NSString *)message buttonTitles:(NSArray<NSString *> *)buttonTitles actionsBlock:(void (^)(NSInteger, NSString * _Nonnull))actionsBlock {
    return [self sheetWithTitle:nil message:message configBlock:^(HHAlertView * _Nonnull alertView, LSTPopView * _Nonnull popView) {
        for (int i = 0; i < buttonTitles.count; i++) {
            HHAlertAction *action = [HHAlertAction actionWithTitle:[buttonTitles objectAtIndex:i] handler:^(HHAlertAction * _Nonnull action) {
                if (actionsBlock) {
                    actionsBlock(i, action.title);
                }
            }];
            [alertView addAction:action];
        }
    }];
}

+ (LSTPopView *)sheetWithTitle:(NSString *)title message:(NSString *)message configBlock:(void (^)(HHAlertView * _Nonnull, LSTPopView * _Nonnull))configBlock {
    HHAlertView *alertView = [HHAlertView alertWithTitle:title message:message preferredStyle:HHAlertStyleActionSheet];
    LSTPopView *popView = [LSTPopView initWithCustomView:alertView popStyle:LSTPopStyleSmoothFromBottom dismissStyle:LSTDismissStyleSmoothToBottom];
    popView.hemStyle = LSTHemStyleBottom;
    popView.rectCorners = UIRectCornerTopLeft | UIRectCornerTopRight;
    popView.cornerRadius = 12;
    popView.isClickBgDismiss = YES;
    
    if (configBlock) {
        configBlock(alertView, popView);
    }
    
    // 取消
    HHAlertAction *cancelAction = [HHAlertAction actionWithTitle:HHGetLocalLanguageTextValue(@"Cancel") handler:nil];
    [alertView addCancelAction:cancelAction];
    
    [popView pop];
    return popView;
}

#pragma mark - Input

+ (LSTPopView *)inputWithTitle:(NSString *)title message:(NSString *)message placeholder:(NSString *)placeholder confirmBlock:(void (^)(NSString * _Nonnull))confirmBlock {
    
    return [self alertWithTitle:title message:message configBlock:^(HHAlertView * _Nonnull alertView, LSTPopView * _Nonnull popView) {
        
        NSString *cancel = HHGetLocalLanguageTextValue(@"Cancel");
        NSString *confirm = HHGetLocalLanguageTextValue(@"Done");
        
        [alertView addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = placeholder;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }];
        
        HHAlertAction *action = [HHAlertAction actionWithTitle:cancel handler:nil];
        [alertView addAction:action];
        
        HHAlertAction *action2 = [HHAlertAction actionWithTitle:confirm handler:^(HHAlertAction * _Nonnull action) {
            if (confirmBlock) {
                NSString *text = @"";
                if (alertView.textFields.count > 0) {
                    text = alertView.textFields.firstObject.text;
                }
                confirmBlock(text);
            }
        }];
        [alertView addAction:action2];
        
    }];
}

@end
