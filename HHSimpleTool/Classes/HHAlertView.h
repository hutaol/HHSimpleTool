//
//  HHAlertView.h
//  Pods
//
//  Created by Henry on 2022/5/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HHAlertStyle) {
    HHAlertStyleAlert,          // 从中间弹出
    HHAlertStyleActionSheet,    // 从底部弹出
};

@interface HHAlertAction : NSObject

+ (instancetype)actionWithTitle:(nullable NSString *)title handler:(void (^ __nullable)(HHAlertAction *action))handler;

/// action的标题
@property (nullable, nonatomic, copy) NSString *title;
/// action的富文本标题
@property (nullable, nonatomic, copy) NSAttributedString *attributedTitle;
/// action的图标，位于title的左边
@property (nullable, nonatomic, copy) UIImage *image;
/// title跟image之间的间距
@property (nonatomic, assign) CGFloat imageTitleSpacing;

/// 是否能点击,默认为YES
@property (nonatomic, getter=isEnabled) BOOL enabled;

/// 是否能点击移除，默认为YES
@property (nonatomic, assign) BOOL isClickDismiss;

/// action的标题颜色,这个颜色只是普通文本的颜色，富文本颜色需要用NSForegroundColorAttributeName
@property (nonatomic, strong) UIColor *titleColor;

/// action的标题字体,如果文字太长显示不全，会自动改变字体自适应按钮宽度，最多压缩文字为原来的0.5倍封顶
@property (nonatomic, strong) UIFont *titleFont;

/// action的标题的内边距，如果在不改变字体的情况下想增大action的高度，可以设置该属性的top和bottom值,默认UIEdgeInsetsMake(0, 15, 0, 15)
@property (nonatomic, assign) UIEdgeInsets titleEdgeInsets;

@property (nonatomic, strong) UIColor *tintColor;

@end

@interface HHAlertView : UIView

/// 主标题
@property (nullable, nonatomic, copy) NSString *title;
/// 副标题
@property (nullable, nonatomic, copy) NSString *message;
/// 主标题(富文本)
@property (nullable, nonatomic, copy) NSAttributedString *attributedTitle;
/// 副标题(富文本)
@property (nullable, nonatomic, copy) NSAttributedString *attributedMessage;

/// 主标题颜色
@property (nonatomic, strong) UIColor *titleColor;
/// 主标题字体,默认18,加粗
@property (nonatomic, strong) UIFont *titleFont;
/// 副标题颜色
@property (nonatomic, strong) UIColor *messageColor;
/// 副标题字体,默认16,未加粗
@property (nonatomic, strong) UIFont *messageFont;
/// 对齐方式(包括主标题和副标题)
@property (nonatomic, assign) NSTextAlignment textAlignment;
///
@property (nonatomic) UILayoutConstraintAxis actionAxis;
/// 圆角
@property (nonatomic, assign) CGFloat cornerRadius;
/// UIEdgeInsetsMake(16, 20, 16, 20)
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

- (void)addAction:(HHAlertAction *)action;
@property (nonatomic, readonly) NSMutableArray<HHAlertAction *> *actions;

- (void)addTextFieldWithConfigurationHandler:(void (^ __nullable)(UITextField *textField))configurationHandler;
@property (nullable, nonatomic, readonly) NSMutableArray<UITextField *> *textFields;

// sheet
- (void)addCancelAction:(HHAlertAction *)action;

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(HHAlertStyle)preferredStyle;

@end

NS_ASSUME_NONNULL_END
