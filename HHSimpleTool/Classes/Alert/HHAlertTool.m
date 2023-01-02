//
//  HHAlertTool.m
//  HHTool
//
//  Created by Henry on 2020/11/3.
//

#import "HHAlertTool.h"
#import "UIWindow+HHHelper.h"
#import "HHDefine.h"

@implementation HHAlertTool

+ (UIViewController *)topViewController {
    return [UIWindow topViewController];
}

#pragma mark - Alert

+ (UIAlertController *)alertWithMessage:(NSString *)message {
    return [self alertWithTitle:HHGetLocalLanguageTextValue(@"Tips") message:message cancelTitle:nil buttonTitles:@[HHGetLocalLanguageTextValue(@"Done")] actionsBlock:nil];
}

+ (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message {
    return [self alertWithTitle:title message:message confirmBlock:nil];
}

+ (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message confirmBlock:(void (^)(void))confirmBlock {
    return [self alertWithTitle:title message:message button:HHGetLocalLanguageTextValue(@"Done") confirmBlock:confirmBlock];
}

+ (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message button:(NSString *)button confirmBlock:(void (^)(void))confirmBlock {
    if (button.length == 0) {
        button = HHGetLocalLanguageTextValue(@"Done");
    }
    return [self alertWithTitle:title message:message cancelTitle:nil buttonTitles:@[button] actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
        if (confirmBlock) {
            confirmBlock();
        }
    }];
}

+ (UIAlertController *)alert2WithMessage:(NSString *)message confirmBlock:(void (^)(NSInteger, NSString * _Nonnull))confirmBlock {
    return [self alertWithTitle:HHGetLocalLanguageTextValue(@"Tips") message:message cancelTitle:HHGetLocalLanguageTextValue(@"Cancel") buttonTitles:@[HHGetLocalLanguageTextValue(@"Done")] actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
        if (buttonIndex == 0) {
            if (confirmBlock) {
                confirmBlock(0, buttonTitle);
            }
        }
    }];
}

+ (UIAlertController *)alert2WithMessage:(NSString *)message cancel:(NSString *)cancel confirm:(NSString *)confirm confirmBlock:(void (^)(NSInteger, NSString * _Nonnull))confirmBlock {
    return [self alertWithTitle:HHGetLocalLanguageTextValue(@"Tips") message:message cancelTitle:cancel buttonTitles:@[confirm] actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
        if (buttonIndex == 0) {
            if (confirmBlock) {
                confirmBlock(0, buttonTitle);
            }
        }
    }];
}

+ (UIAlertController *)alertWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle buttonTitles:(NSArray<NSString *> *)buttonTitles actionsBlock:(void (^)(NSInteger, NSString * _Nonnull))actionsBlock {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

    if (cancelTitle) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            if (actionsBlock) {
                actionsBlock(-1, action.title);
            }
        }];
        [alertController addAction:action];
    }
    
    for (int i = 0; i < buttonTitles.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:[buttonTitles objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (actionsBlock) {
                actionsBlock(i, action.title);
            }
        }];
        [alertController addAction:action];
    }

    [[self topViewController] presentViewController:alertController animated:YES completion:nil];

    return alertController;
}

#pragma mark - Sheet

+ (UIAlertController *)sheetWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle destructiveTitle:(NSString *)destructiveTitle buttonTitles:(NSArray<NSString *> *)buttonTitles actionsBlock:(void (^)(NSInteger, NSString * _Nonnull))actionsBlock {
        
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int i = 0; i < buttonTitles.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:[buttonTitles objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (actionsBlock) {
                actionsBlock(i, action.title);
            }
        }];
        [alertController addAction:action];
    }
    
    if (cancelTitle) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            if (actionsBlock) {
                actionsBlock(-1, action.title);
            }
        }];
        [alertController addAction:action];
    }
    
    if (destructiveTitle) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:destructiveTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
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
    
    return alertController;
}

+ (UIAlertController *)sheetWithMessage:(NSString *)message buttonTitles:(NSArray<NSString *> *)buttonTitles actionsBlock:(void (^)(NSInteger, NSString * _Nonnull))actionsBlock {
    return [self sheetWithTitle:nil message:message cancelTitle:HHGetLocalLanguageTextValue(@"Cancel") destructiveTitle:nil buttonTitles:buttonTitles actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle) {
        if (buttonIndex >= 0) {
            if (actionsBlock) {
                actionsBlock(buttonIndex, buttonTitle);
            }
        }
    }];
}

#pragma mark - Input

+ (UIAlertController *)inputWithTitle:(NSString *)title message:(NSString *)message placeholders:(NSArray<NSString *> *)placeholders cancelTitle:(NSString *)cancelTitle buttonTitles:(NSArray<NSString *> *)buttonTitles actionsBlock:(void (^)(NSInteger, NSString * _Nonnull, NSArray<UITextField *> * _Nonnull))actionsBlock {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

    NSMutableArray *textArr = @[].mutableCopy;
    if (placeholders.count > 0) {
        [placeholders enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = obj;
                textField.clearButtonMode = UITextFieldViewModeWhileEditing;
                [textArr addObject:textField];
            }];
        }];
    }
    
    if (cancelTitle) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            if (actionsBlock) {
                actionsBlock(-1, action.title, textArr);
            }
        }];
        [alertController addAction:action];
    }
    
    for (int i = 0; i < buttonTitles.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:[buttonTitles objectAtIndex:i] style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if (actionsBlock) {
                actionsBlock(i, action.title, textArr);
            }
        }];
        [alertController addAction:action];
    }

    [[self topViewController] presentViewController:alertController animated:YES completion:nil];
    
    return alertController;
}

+ (UIAlertController *)inputWithTitle:(NSString *)title message:(NSString *)message placeholder:(NSString *)placeholder cancel:(NSString *)cancel confirm:(NSString *)confirm confirmBlock:(void (^)(NSString * _Nonnull))confirmBlock {
    if (!placeholder) placeholder = @"";
    if (!confirm) confirm = HHGetLocalLanguageTextValue(@"Done");
    
    return [self inputWithTitle:title message:message placeholders:@[placeholder] cancelTitle:cancel buttonTitles:@[confirm] actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle, NSArray<UITextField *> * _Nonnull textFields) {
        if (buttonIndex == 0) {
            if (confirmBlock && textFields.count > 0) {
                confirmBlock(textFields.firstObject.text);
            }
        }
    }];
}

+ (UIAlertController *)inputWithTitle:(NSString *)title message:(NSString *)message placeholder:(nullable NSString *)placeholder confirmBlock:(nullable void(^)(NSString *inputText))confirmBlock {
    if (!placeholder) placeholder = @"";
    
    NSString *cancel = HHGetLocalLanguageTextValue(@"Cancel");
    NSString *confirm = HHGetLocalLanguageTextValue(@"Done");
    return [self inputWithTitle:title message:message placeholders:@[placeholder] cancelTitle:cancel buttonTitles:@[confirm] actionsBlock:^(NSInteger buttonIndex, NSString * _Nonnull buttonTitle, NSArray<UITextField *> * _Nonnull textFields) {
        if (buttonIndex == 0) {
            if (confirmBlock && textFields.count > 0) {
                confirmBlock(textFields.firstObject.text);
            }
        }
    }];
}

@end
