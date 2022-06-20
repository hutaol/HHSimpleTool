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
#define HH_BG_ACTION_COLOR [UIColor colorWithRed:220.0 / 255.0 green:220.0 / 255.0 blue:220.0 / 255.0 alpha:1.0]
#define HH_BG_INPUT_COLOR [UIColor colorWithRed:240.0 / 255.0 green:240.0 / 255.0 blue:240.0 / 255.0 alpha:1.0]
#define HH_ACTION_TITLE_FONTSIZE 18

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
    self.titleColor = [UIColor blackColor];
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
    _titleColor = [UIColor blackColor];
    _titleFont = [UIFont systemFontOfSize:17];
    _titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
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
        [self.actionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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
    sender.backgroundColor = [UIColor whiteColor];
    
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
    sender.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
}

- (void)touchDragExit:(UIButton *)sender {
    sender.backgroundColor = [UIColor whiteColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.actionButton.frame = self.bounds;
}

- (UIButton *)actionButton {
    if (!_actionButton) {
        UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        actionButton.backgroundColor = [UIColor whiteColor];
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
        self.backgroundColor = [UIColor whiteColor];
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
    } else {
        currentActionView.bounds = CGRectMake(0, 0, self.frame.size.width, action.titleFont.lineHeight + HH_ACTION_SHEET_V);
    }
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
    textField.layer.borderColor = HH_BG_ACTION_COLOR.CGColor;
    textField.layer.cornerRadius = 5;
    textField.backgroundColor = HH_BG_INPUT_COLOR;
    
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
    
    CGFloat margin = 20.0;
    CGFloat top = margin;
    if (self.title.length > 0) {
        self.titleLabel.frame = CGRectMake(margin, top, self.frame.size.width-margin-margin, self.titleLabel.frame.size.height);
        top += (self.titleLabel.frame.size.height + 5);
    }
    if (self.message.length > 0) {
        self.messageLabel.frame = CGRectMake(margin, top, self.frame.size.width-margin-margin, self.messageLabel.frame.size.height);
        top += (self.messageLabel.frame.size.height + 20);
    } else {
        top += 20;
    }
    if (self.textFields.count > 0) {
        CGFloat height = 30*self.textFields.count;
        self.textFieldView.frame = CGRectMake(margin, top, self.frame.size.width-margin-margin, height);
        top += (height + 20);
    }
    
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

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 275-40, 0)];
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = 0;
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 275-40, 0)];
        messageLabel.font = [UIFont systemFontOfSize:17];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.numberOfLines = 0;
        [self addSubview:messageLabel];
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
            [self addSubview:textFieldView];
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
        stackView.backgroundColor = HH_BG_ACTION_COLOR;
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
        view.backgroundColor = HH_BG_ACTION_COLOR;
        [self.cancelView addSubview:view];
        _cancelActionView = view;
    }
    return _cancelActionView;
}

- (UIView *)cancelView {
    if (!_cancelView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = HH_BG_INPUT_COLOR;
        [self addSubview:view];
        _cancelView = view;
    }
    return _cancelView;
}

- (UIView *)separatorView {
    if (!_separatorView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = HH_BG_ACTION_COLOR;
        [self addSubview:view];
        _separatorView = view;
    }
    return _separatorView;
}

- (void)dealloc {
    NSLog(@"销毁");
}

@end
