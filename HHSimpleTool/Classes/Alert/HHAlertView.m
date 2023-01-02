//
//  HHAlertView.m
//  Pods
//
//  Created by Henry on 2022/5/24.
//

#import "HHAlertView.h"
#import "HHUtilities.h"
#import <LSTPopView/LSTPopView.h>

#define HH_LINE_WIDTH 1.0 / [UIScreen mainScreen].scale
#define HH_ACTION_V 24
#define HH_ACTION_SHEET_V 30
#define HH_ACTION_TITLE_FONTSIZE 18

@interface HHColorStyle : NSObject

+ (UIColor *)backgroundColor;
+ (UIColor *)normalColor;
+ (UIColor *)selectedColor;
+ (UIColor *)lineColor;
+ (UIColor *)line2Color;
+ (UIColor *)lightLineColor;
+ (UIColor *)darkLineColor;
+ (UIColor *)lightWhite_DarkBlackColor;
+ (UIColor *)lightBlack_DarkWhiteColor;
+ (UIColor *)textViewBackgroundColor;
+ (UIColor *)alertRedColor;
+ (UIColor *)grayColor;

+ (UIColor *)colorPairsWithDynamicLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor;
+ (UIColor *)colorPairsWithStaticLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor;
@end

@implementation HHColorStyle

+ (UIColor *)backgroundColor {
    return [self colorPairsWithDynamicLightColor:[UIColor whiteColor] darkColor:[UIColor colorWithRed:44.0 / 255.0 green:44.0 / 255.0 blue:44.0 / 255.0 alpha:1.0]];
}

+ (UIColor *)normalColor {
    return [self colorPairsWithDynamicLightColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] darkColor:[UIColor colorWithRed:44.0 / 255.0 green:44.0 / 255.0 blue:44.0 / 255.0 alpha:1.0]];
}

+ (UIColor *)selectedColor {
    return [self colorPairsWithDynamicLightColor:[[UIColor grayColor] colorWithAlphaComponent:0.1] darkColor:[UIColor colorWithRed:55.0 / 255.0 green:55.0 / 255.0 blue:55.0 / 255.0 alpha:1.0]];
}

+ (UIColor *)lineColor {
    return [self colorPairsWithDynamicLightColor:[self lightLineColor] darkColor:[self darkLineColor]];
}

+ (UIColor *)line2Color {
    return [self colorPairsWithDynamicLightColor:[[UIColor grayColor] colorWithAlphaComponent:0.15] darkColor:[UIColor colorWithRed:29.0 / 255.0 green:29.0 / 255.0 blue:29.0 / 255.0 alpha:1.0]];
}

+ (UIColor *)lightWhite_DarkBlackColor {
    return [self colorPairsWithDynamicLightColor:[UIColor whiteColor] darkColor:[UIColor blackColor]];
}

+ (UIColor *)lightBlack_DarkWhiteColor {
    return [self colorPairsWithDynamicLightColor:[UIColor blackColor] darkColor:[UIColor whiteColor]];
}

+ (UIColor *)lightLineColor {
    return [[UIColor grayColor] colorWithAlphaComponent:0.3];
}

+ (UIColor *)darkLineColor {
    return [UIColor colorWithRed:60.0 / 255.0 green:60.0 / 255.0 blue:60.0 / 255.0 alpha:1.0];
}

+ (UIColor *)textViewBackgroundColor {
    return [self colorPairsWithDynamicLightColor:[UIColor colorWithRed:247.0 / 255.0 green:247.0 / 255.0 blue:247.0 / 255.0 alpha:1.0]
                                       darkColor:[UIColor colorWithRed:54.0 / 255.0 green:54.0 / 255.0 blue:54.0 / 255.0 alpha:1.0]];
}

+ (UIColor *)alertRedColor {
    return [UIColor systemRedColor];
}

+ (UIColor *)grayColor {
    return [UIColor grayColor];
}

+ (UIColor *)colorPairsWithDynamicLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor {
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if(traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return darkColor;
            } else {
                return lightColor;
            }
        }];
    } else {
        return lightColor;
    }
}

+ (UIColor *)colorPairsWithStaticLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor {
    if (@available(iOS 13.0, *)) {
        UIUserInterfaceStyle mode = UITraitCollection.currentTraitCollection.userInterfaceStyle;
        if (mode == UIUserInterfaceStyleDark) {
            return darkColor;
        } else if (mode == UIUserInterfaceStyleLight) {
            return lightColor;
        } else {
            return lightColor;
        }
    }
    return lightColor;
}

@end

@interface HHAlertAction()

@property (nonatomic, copy) void (^handler)(HHAlertAction *action);

@end

@implementation HHAlertAction

+ (instancetype)actionWithTitle:(NSString *)title handler:(void (^)(HHAlertAction * _Nonnull))handler {
    HHAlertAction *action = [[self alloc] initWithTitle:title handler:handler];
    return action;
}

- (instancetype)initWithTitle:(nullable NSString *)title handler:(void (^ __nullable)(HHAlertAction *action))handler {
    self = [self init];
    self.title = title;
    self.handler = handler;
    self.titleColor = [HHColorStyle lightBlack_DarkWhiteColor];
    self.titleFont = [UIFont systemFontOfSize:17];
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _enabled = YES; // 默认能点击
    _isClickDismiss = YES; // 默认移除
    _titleColor = [HHColorStyle lightBlack_DarkWhiteColor];
    _titleFont = [UIFont systemFontOfSize:17];
    _titleEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 16);
}

@end

@interface HHAlertActionView : UIView

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL methodAction;
@property (nonatomic, strong) HHAlertAction *action;
@property (nonatomic, weak) UIButton *actionButton;
@property (nonatomic, strong) NSMutableArray *actionButtonConstraints;
- (void)addTarget:(id)target action:(SEL)action;

@end

@implementation HHAlertActionView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [HHColorStyle lightWhite_DarkBlackColor];
    }
    return self;
}

- (void)setAction:(HHAlertAction *)action {
    _action = action;
    self.actionButton.titleLabel.font = action.titleFont;
    if (action.enabled) {
        [self.actionButton setTitleColor:action.titleColor forState:UIControlStateNormal];
    } else {
        [self.actionButton setTitleColor:[action.titleColor colorWithAlphaComponent:0.4] forState:UIControlStateNormal];
    }
    self.actionButton.contentEdgeInsets = action.titleEdgeInsets;
    self.actionButton.enabled = action.enabled;
    self.actionButton.tintColor = action.tintColor;
    
    if (action.attributedTitle) {
        [self.actionButton setTitleColor:[HHColorStyle normalColor] forState:UIControlStateNormal];
        if ([action.attributedTitle.string containsString:@"\n"] || [action.attributedTitle.string containsString:@"\r"]) {
            self.actionButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        }
        [self.actionButton setAttributedTitle:action.attributedTitle forState:UIControlStateNormal];
        [self.actionButton setTitleColor:action.titleColor forState:UIControlStateNormal];

    } else {
        if ([action.title containsString:@"\n"] || [action.title containsString:@"\r"]) {
            self.actionButton.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        }
        [self.actionButton setTitle:action.title forState:UIControlStateNormal];
    }
    [self.actionButton setImage:action.image forState:UIControlStateNormal];
    self.actionButton.titleEdgeInsets = UIEdgeInsetsMake(0, action.imageTitleSpacing, 0, -action.imageTitleSpacing);
    self.actionButton.imageEdgeInsets = UIEdgeInsetsMake(0, -action.imageTitleSpacing, 0, action.imageTitleSpacing);
}

- (void)addTarget:(id)target action:(SEL)methodAction {
    _target = target;
    _methodAction = methodAction;
}

- (void)touchUpInside:(UIButton *)sender {
    // 用函数指针实现_target调用_methodAction，相当于[_target performSelector:_methodAction withObject:self];但是后者会报警告
    SEL selector = _methodAction;
    IMP imp = [_target methodForSelector:selector];
    void (*func)(id, SEL, HHAlertActionView *) = (void *)imp;
    func(_target, selector, self);
    sender.backgroundColor = [HHColorStyle normalColor];
    
    // TODO: 移除popView
    if (self.action.isClickDismiss) {
        if (self.superview.superview.superview.superview && [self.superview.superview.superview.superview isKindOfClass:[LSTPopView class]]) {
            LSTPopView *view = (LSTPopView *)self.superview.superview.superview.superview;
            [view dismiss];
        } else if (self.superview.superview.superview && [self.superview.superview.superview isKindOfClass:[LSTPopView class]]) {
            LSTPopView *view = (LSTPopView *)self.superview.superview.superview;
            [view dismiss];
        }
    }
    
}

- (void)touchDown:(UIButton *)sender {
    sender.backgroundColor = [HHColorStyle selectedColor];
}

- (void)touchDragExit:(UIButton *)sender {
    sender.backgroundColor = [HHColorStyle normalColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.actionButton.frame = self.bounds;
}

- (UIButton *)actionButton {
    if (!_actionButton) {
        UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        actionButton.backgroundColor = [HHColorStyle normalColor];
        actionButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        actionButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        actionButton.titleLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        actionButton.titleLabel.minimumScaleFactor = 0.5;
        [actionButton addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside]; // 手指按下然后在按钮有效事件范围内抬起
        [actionButton addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown | UIControlEventTouchDragInside]; // 手指按下或者手指按下后往外拽再往内拽
        [actionButton addTarget:self action:@selector(touchDragExit:) forControlEvents:UIControlEventTouchDragExit | UIControlEventTouchUpOutside | UIControlEventTouchCancel]; // 手指被迫停止、手指按下后往外拽或者取消，取消的可能性:比如点击的那一刻突然来电话
        [self addSubview:actionButton];
        _actionButton = actionButton;
    }
    return _actionButton;
}

@end

@interface HHAlertView ()

@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *messageLabel;

@property (nonatomic, weak) UIStackView *textFieldView;
@property (nonatomic) NSMutableArray<UITextField *> *textFields;

@property (nonatomic, weak) UIView *separatorView;
@property (nonatomic) NSMutableArray<HHAlertAction *> *actions;

@property (nonatomic, weak) UIStackView *actionView;

@property (nonatomic, weak) UIView *cancelView;
@property (nonatomic, weak) HHAlertActionView *cancelActionView;
@property (nonatomic, assign) BOOL hasCancelAction;

@property (nonatomic, assign) HHAlertStyle preferredStyle;

@end

@implementation HHAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [HHColorStyle backgroundColor];
    }
    return self;
}

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(HHAlertStyle)preferredStyle {
    return [[self alloc] initWithTitle:title message:message preferredStyle:preferredStyle];
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message preferredStyle:(HHAlertStyle)preferredStyle {
    self = [self init];
    _preferredStyle = preferredStyle;
    self.title = title;
    self.message = message;
    
    if (preferredStyle == HHAlertStyleAlert) {
        self.frame = CGRectMake(0, 0, 275, 0);
    } else {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0);
    }
    
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _edgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
    _titleFont = [UIFont boldSystemFontOfSize:18];
    _titleColor = [HHColorStyle lightBlack_DarkWhiteColor];
    _messageFont = [UIFont systemFontOfSize:17];
    _messageColor = [HHColorStyle grayColor];
}

- (void)addCancelAction:(HHAlertAction *)action {
    _hasCancelAction = YES;
    self.cancelActionView.action = action;
    [self.cancelActionView addTarget:self action:@selector(buttonClickedInActionView:)];
}

- (void)addAction:(HHAlertAction *)action {
    [self.actions addObject:action];

    HHAlertActionView *currentActionView = [[HHAlertActionView alloc] init];
    currentActionView.action = action;
    [currentActionView addTarget:self action:@selector(buttonClickedInActionView:)];

    [self.actionView addArrangedSubview:currentActionView];

    if (self.preferredStyle == HHAlertStyleAlert) {
        currentActionView.bounds = CGRectMake(0, 0, self.frame.size.width/self.actions.count, action.titleFont.lineHeight + HH_ACTION_V);
        
        // 添加分割线
        if (self.actionView.arrangedSubviews.count > 1) {
            UIView *lineView = [self addLineForStackView:self.actionView];
            CGFloat left = currentActionView.frame.size.width*(self.actions.count-1);
            lineView.frame = CGRectMake(left, 0, HH_LINE_WIDTH, currentActionView.frame.size.height);
        }
        
    } else {
        currentActionView.bounds = CGRectMake(0, 0, self.frame.size.width, action.titleFont.lineHeight + HH_ACTION_SHEET_V);
        
        // 添加分割线
        if (self.actionView.arrangedSubviews.count > 1) {
            UIView *lineView = [self addLineForStackView:self.actionView];
            CGFloat top = currentActionView.frame.size.height*(self.actions.count-1);
            lineView.frame = CGRectMake(0, top, currentActionView.frame.size.width, HH_LINE_WIDTH);
        }
    }
}

// 为stackView添加分割线
- (UIView *)addLineForStackView:(UIStackView *)stackView {
    UIView *actionLine = [[UIView alloc] init];
    actionLine.backgroundColor = [HHColorStyle lineColor];
    [stackView addSubview:actionLine];
    return actionLine;
}

- (void)buttonClickedInActionView:(HHAlertActionView *)actionView {
    if (actionView.action.handler) {
        actionView.action.handler(actionView.action);
    }
}

- (void)addTextField:(UITextField *)textField {
    [self.textFieldView addArrangedSubview:textField];
    textField.bounds = CGRectMake(0, 0, self.frame.size.width-40, 30);
}

- (void)addTextFieldWithConfigurationHandler:(void (^)(UITextField * _Nonnull))configurationHandler {
    UITextField *textField = [[UITextField alloc] init];
    textField.layer.borderWidth = HH_LINE_WIDTH;
    textField.layer.cornerRadius = 5;
    textField.backgroundColor = [HHColorStyle textViewBackgroundColor];
    textField.layer.borderColor = [HHColorStyle colorPairsWithStaticLightColor:[HHColorStyle lineColor] darkColor:[HHColorStyle darkLineColor]].CGColor;

    textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 0)];
    textField.leftView.userInteractionEnabled = NO;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.font = [UIFont systemFontOfSize:14];
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;

    NSMutableArray *array = self.textFields.mutableCopy;
    [array addObject:textField];
    self.textFields = array;
    [self addTextField:textField];

    if (configurationHandler) {
        configurationHandler(textField);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = self.frame;
    
    CGFloat top = self.edgeInsets.top;
    CGFloat left = self.edgeInsets.left;
    CGFloat right = self.edgeInsets.right;
    
    if (self.title.length > 0) {
        self.titleLabel.frame = CGRectMake(left, top, self.frame.size.width-left-left, self.titleLabel.frame.size.height);
        top += (self.titleLabel.frame.size.height + 5);
    }
    if (self.message.length > 0) {
        self.messageLabel.frame = CGRectMake(left, top, self.frame.size.width-left-left, self.messageLabel.frame.size.height+1);
        top += (self.messageLabel.frame.size.height + self.edgeInsets.top);
    } else {
        top += self.edgeInsets.top;
    }
    if (self.textFields.count > 0) {
        CGFloat height = 0;
        for (UITextField *textField in self.textFields) {
            height += textField.frame.size.height;
        }
        self.textFieldView.frame = CGRectMake(left, top, self.frame.size.width-left-right, height);
        top += (height + self.edgeInsets.top);
    }
    
    self.headerView.frame = CGRectMake(0, 0, self.frame.size.width, top);
    
    self.separatorView.frame = CGRectMake(0, top, self.frame.size.width, HH_LINE_WIDTH);
    top += HH_LINE_WIDTH;
    
    if (self.actions.count > 0) {
        HHAlertAction *action = self.actions.firstObject;
        CGFloat height = action.titleFont.lineHeight + HH_ACTION_V;
        
        if (self.preferredStyle == HHAlertStyleActionSheet) {
            CGFloat itemHeight = action.titleFont.lineHeight + HH_ACTION_SHEET_V;
            height = itemHeight * self.actions.count;
            
            if (self.title.length == 0 && self.message.length == 0) {
                top = 0;
                self.separatorView.hidden = YES;
            }
        } else {
            
        }
        self.actionView.frame = CGRectMake(0, top, self.frame.size.width, height);
        top += height;
    }
    
    if (self.hasCancelAction) {
        CGFloat itemHeight = self.cancelActionView.action.titleFont.lineHeight + HH_ACTION_SHEET_V;
        self.cancelView.frame = CGRectMake(0, top, self.frame.size.width, itemHeight + 10);
        self.cancelActionView.frame = CGRectMake(0, 10, self.frame.size.width, itemHeight);
        top += itemHeight+10;
    }
    
    if (self.preferredStyle == HHAlertStyleActionSheet) {
        top += [HHUtilities hh_bottomSafeHeight];
    }
    frame.size.height = top;
    self.frame = frame;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
}

- (void)setMessage:(NSString *)message {
    _message = message;
    self.messageLabel.text = message;
    [self.messageLabel sizeToFit];
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    self.titleLabel.font = titleFont;
    [self.messageLabel sizeToFit];
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.titleLabel.textColor = titleColor;
}

- (void)setMessageFont:(UIFont *)messageFont {
    _messageFont = messageFont;
    self.messageLabel.font = messageFont;
    [self.messageLabel sizeToFit];
}

- (void)setMessageColor:(UIColor *)messageColor {
    _messageColor = messageColor;
    self.messageLabel.textColor = messageColor;
}

- (NSMutableArray *)textFields {
    if (!_textFields) {
        _textFields = [[NSMutableArray alloc] init];
    }
    return _textFields;
}

- (NSMutableArray *)actions {
    if (!_actions) {
        _actions = [[NSMutableArray array] init];
    }
    return _actions;
}

#pragma mark - Getters

- (UIView *)headerView {
    if (!_headerView) {
        UIView *headerView = [[UIView alloc] init];
        headerView.backgroundColor = [HHColorStyle normalColor];
        [self addSubview:headerView];
        _headerView = headerView;
    }
    return _headerView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 275-40, 0)];
        titleLabel.font = self.titleFont;
        titleLabel.textColor = self.titleColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = 0;
        [self.headerView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 275-40, 0)];
        messageLabel.font = self.messageFont;
        messageLabel.textColor = self.messageColor;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.numberOfLines = 0;
        [self.headerView addSubview:messageLabel];
        _messageLabel = messageLabel;
    }
    return _messageLabel;
}

- (UIStackView *)textFieldView {
    if (!_textFieldView) {
        UIStackView *textFieldView = [[UIStackView alloc] init];
        textFieldView.distribution = UIStackViewDistributionFillEqually;
        textFieldView.axis = UILayoutConstraintAxisVertical;
        if (self.textFields.count) {
            [self.headerView addSubview:textFieldView];
        }
        _textFieldView = textFieldView;
    }
    return _textFieldView;
}

- (UIStackView *)actionView {
    if (!_actionView) {
        UIStackView *stackView = [[UIStackView alloc] init];
        stackView.distribution = UIStackViewDistributionFillEqually;
        stackView.spacing = HH_LINE_WIDTH; // 该间距腾出来的空间显示分割线
        stackView.backgroundColor = [HHColorStyle backgroundColor];
        if (self.actions.count) {
            
            if (self.preferredStyle == HHAlertStyleActionSheet) {
                stackView.axis = UILayoutConstraintAxisVertical;
            } else {
                stackView.axis = UILayoutConstraintAxisHorizontal;
            }
            
            [self addSubview:stackView];
        }
        _actionView = stackView;
    }
    return _actionView;
}

- (HHAlertActionView *)cancelActionView {
    if (!_cancelActionView) {
        HHAlertActionView *view = [[HHAlertActionView alloc] init];
        view.backgroundColor = [HHColorStyle lightWhite_DarkBlackColor];
        [self.cancelView addSubview:view];
        _cancelActionView = view;
    }
    return _cancelActionView;
}

- (UIView *)cancelView {
    if (!_cancelView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [HHColorStyle line2Color];
        [self addSubview:view];
        _cancelView = view;
    }
    return _cancelView;
}

- (UIView *)separatorView {
    if (!_separatorView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [HHColorStyle lineColor];
        [self addSubview:view];
        _separatorView = view;
    }
    return _separatorView;
}

- (void)dealloc {
    NSLog(@"销毁");
}

@end
