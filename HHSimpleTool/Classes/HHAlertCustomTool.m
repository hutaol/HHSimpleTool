//
//  HHAlertCustomTool.m
//  HHTool
//
//  Created by Henry on 2020/11/3.
//

#import "HHAlertCustomTool.h"
#import <SPAlertController/SPAlertController.h>
#import "UIWindow+HHHelper.h"
#import "HHDefine.h"

@implementation HHAlertCustomTool

+ (UIViewController *)topViewController {
    return [UIWindow topViewController];
}

// 确定 警示框
+ (void)alertWithMessage:(NSString *)message {
    [self alertWithTitle:HHGetLocalLanguageTextValue(@"Tips") message:message cancelTitle:nil buttonTitles:@[HHGetLocalLanguageTextValue(@"Done")] actionsBlock:nil];
}

// 取消，确定 警示框
+ (void)alert2WithMessage:(NSString *)message confirmBlock:(void (^)(NSInteger, NSString * _Nonnull))confirmBlock {
    [self alertWithTitle:HHGetLocalLanguageTextValue(@"Tips") message:message cancelTitle:HHGetLocalLanguageTextValue(@"Cancel") buttonTitles:@[HHGetLocalLanguageTextValue(@"Done")] actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
        if (buttonIndex == 0) {
            if (confirmBlock) {
                confirmBlock(buttonIndex, buttonTitle);
            }
        }
    }];
}

#pragma mark - Alert
+ (void)alertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle buttonTitles:(NSArray<NSString *> *)buttonTitles actionsBlock:(void (^)(NSInteger, NSString * _Nonnull))actionsBlock {
    
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:title message:message preferredStyle:SPAlertControllerStyleAlert];
    alertController.tapBackgroundViewDismiss = NO;
    
    if (cancelTitle) {
        SPAlertAction *action = [SPAlertAction actionWithTitle:cancelTitle style:SPAlertActionStyleCancel handler:^(SPAlertAction * _Nonnull action) {
            if (actionsBlock) {
                actionsBlock(-1, action.title);
            }
        }];
        [alertController addAction:action];
    }
    
    for (int i = 0; i < buttonTitles.count; i++) {
        SPAlertAction *action = [SPAlertAction actionWithTitle:[buttonTitles objectAtIndex:i] style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
            if (actionsBlock) {
                actionsBlock(i, action.title);
            }
        }];
        [alertController addAction:action];
    }

    [[self topViewController] presentViewController:alertController animated:YES completion:nil];

}

#pragma mark - Sheet
+ (void)sheetWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle destructiveTitle:(NSString *)destructiveTitle buttonTitles:(NSArray<NSString *> *)buttonTitles actionsBlock:(void (^)(NSInteger, NSString * _Nonnull))actionsBlock {
    
    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:title message:message preferredStyle:SPAlertControllerStyleActionSheet];
    
    for (int i = 0; i < buttonTitles.count; i++) {
        SPAlertAction *action = [SPAlertAction actionWithTitle:[buttonTitles objectAtIndex:i] style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
            if (actionsBlock) {
                actionsBlock(i, action.title);
            }
        }];
        [alertController addAction:action];
    }
    
    if (cancelTitle) {
        SPAlertAction *action = [SPAlertAction actionWithTitle:cancelTitle style:SPAlertActionStyleCancel handler:^(SPAlertAction * _Nonnull action) {
            if (actionsBlock) {
                actionsBlock(-1, action.title);
            }
        }];
        [alertController addAction:action];
    }
    
    if (destructiveTitle) {
        SPAlertAction *action = [SPAlertAction actionWithTitle:destructiveTitle style:SPAlertActionStyleDestructive handler:^(SPAlertAction * _Nonnull action) {
            if (actionsBlock) {
                actionsBlock(-2, action.title);
            }
        }];
        [alertController addAction:action];
    }

    UIViewController *curVC = [self topViewController];

    if (curVC) {
        
        UIDevice *currentDevice = [UIDevice currentDevice];
        // ipad
        if (currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad && [alertController respondsToSelector:@selector(popoverPresentationController)]) {
            alertController.popoverPresentationController.sourceView = curVC.view; // 必须加
        }
        [curVC presentViewController:alertController animated:YES completion:nil];
        
    }
}

+ (void)sheetWithMessage:(NSString *)message buttonTitles:(NSArray<NSString *> *)buttonTitles actionsBlock:(void (^)(NSInteger, NSString * _Nonnull))actionsBlock {
    [self sheetWithTitle:nil message:message cancelTitle:HHGetLocalLanguageTextValue(@"Cancel") destructiveTitle:nil buttonTitles:buttonTitles actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
        if (buttonIndex >= 0) {
            if (actionsBlock) {
                actionsBlock(buttonIndex, buttonTitle);
            }
        }
    }];
}

/// 带输入框
+ (void)inputWithTitle:(NSString *)title message:(NSString *)message placeholders:(NSArray<NSString *> *)placeholders cancelTitle:(NSString *)cancelTitle buttonTitles:(NSArray<NSString *> *)buttonTitles actionsBlock:(void (^)(NSInteger, NSString * _Nonnull, NSArray<UITextField *> * _Nonnull))actionsBlock {

    SPAlertController *alertController = [SPAlertController alertControllerWithTitle:title message:message preferredStyle:SPAlertControllerStyleAlert];
    alertController.tapBackgroundViewDismiss = NO;
    
    NSMutableArray *textArr = @[].mutableCopy;
    if (placeholders.count > 0) {
        [placeholders enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.keyboardType = UIKeyboardTypePhonePad;
                textField.placeholder = obj;
                [textArr addObject:textField];
            }];
        }];
    }
    
    if (cancelTitle) {
        SPAlertAction *action = [SPAlertAction actionWithTitle:cancelTitle style:SPAlertActionStyleCancel handler:^(SPAlertAction * _Nonnull action) {
            if (actionsBlock) {
                actionsBlock(-1, action.title, textArr);
            }
        }];
        [alertController addAction:action];
    }
    
    for (int i = 0; i < buttonTitles.count; i++) {
        SPAlertAction *action = [SPAlertAction actionWithTitle:[buttonTitles objectAtIndex:i] style:SPAlertActionStyleDefault handler:^(SPAlertAction * _Nonnull action) {
            if (actionsBlock) {
                actionsBlock(i, action.title, textArr);
            }
        }];
        [alertController addAction:action];
    }

    [[self topViewController] presentViewController:alertController animated:YES completion:nil];
    
}

+ (void)inputWithTitle:(NSString *)title message:(NSString *)message placeholder:(NSString *)placeholder cancel:(NSString *)cancel confirm:(NSString *)confirm confirmBlock:(void (^)(NSString * _Nonnull))confirmBlock {
    
    [self inputWithTitle:title message:message placeholders:@[placeholder] cancelTitle:cancel buttonTitles:@[confirm] actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle, NSArray<UITextField *> * _Nonnull textFields) {
        if (buttonIndex == 0) {
            if (confirmBlock && textFields.count > 0) {
                confirmBlock(textFields.firstObject.text);
            }
        }
    }];
}

@end
