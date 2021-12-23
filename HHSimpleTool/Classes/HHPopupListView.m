//
//  HHPopupListView.m
//  Pods
//
//  Created by Henry on 2021/5/6.
//

#import "HHPopupListView.h"
#import "UIWindow+HHHelper.h"
#import "UIView+HHFrame.h"

@implementation HHPopupListView

- (instancetype)initWithTitle:(NSString *)title dataArray:(NSArray *)dataArray {
    return [self initWithTitle:title dataArray:dataArray titlePosition:NSTextAlignmentLeft textPosition:NSTextAlignmentCenter topView:nil bottomView:nil];
}

- (instancetype)initWithTitle:(NSString *)title dataArray:(NSArray *)dataArray titlePosition:(NSTextAlignment)titlePosition textPosition:(NSTextAlignment)textPosition topView:(UIView *)topView bottomView:(UIView *)bottomView {
    self = [super init];
    if (self) {
        self.title = title.copy;
        self.dataArray = dataArray.copy;
        self.titlePosition = titlePosition;
        self.textPosition = textPosition;
        
        if (topView) {
            self.isExterTop = YES;
            self.topView = topView;
        } else {
            self.isExterTop = NO;
        }
        self.bottomView = bottomView;
        
        [self _defaultConfig];
        [self initView];
    }
    return self;
}

- (void)_defaultConfig {
    self.backgroundColor = [UIColor whiteColor];

    self.defaultTableHeight = 44*4;
    self.topBackgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
    self.titleColor = [UIColor blackColor];
}

- (void)initView {
    
    [self addSubview:self.tableView];
    [self addSubview:self.topView];

    if (self.bottomView) {
        [self addSubview:self.bottomView];
    }
    
    if (self.isExterTop) {
        self.titleLabel.hidden = YES;
    } else {
        self.titleLabel.hidden = NO;
        [self.topView addSubview:self.titleLabel];
    }
    
    CGFloat safeBottom = [UIWindow topViewController].view.safeBottom;
    CGFloat viewHeight = self.defaultTableHeight + self.topView.frame.size.height + (self.bottomView?self.bottomView.frame.size.height:0) + safeBottom;
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, viewHeight);
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect topRect = self.topView.frame;
    topRect.size.width = self.frame.size.width;
    self.topView.frame = topRect;

    CGFloat tableTop = topRect.size.height;
    
    if (self.bottomView) {
        CGRect bottomRect = self.bottomView.frame;
        self.bottomView.frame = CGRectMake(0, tableTop + self.defaultTableHeight, self.frame.size.width, bottomRect.size.height);
    }
    
    self.tableView.frame = CGRectMake(0, tableTop, self.frame.size.width, self.defaultTableHeight);

    if (!self.isExterTop) {
        self.titleLabel.frame = CGRectMake(10, 0, self.topView.frame.size.width-20, self.topView.frame.size.height);
    }
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HHPopupListViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.textAlignment = self.textPosition;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didRowBlock) {
        NSString *text = self.dataArray[indexPath.row];
        self.didRowBlock(indexPath.row, text);
    }
}

#pragma mark - Setters

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    self.titleLabel.textColor = titleColor;
}

- (void)setTitlePosition:(NSTextAlignment)titlePosition {
    _titlePosition = titlePosition;
    self.titleLabel.textAlignment = titlePosition;
}

- (void)setTopBackgroundColor:(UIColor *)topBackgroundColor {
    _topBackgroundColor = topBackgroundColor;
    self.topView.backgroundColor = topBackgroundColor;
}

#pragma mark - Getters

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.rowHeight = 44;
        tableView.backgroundColor = [UIColor whiteColor];

        tableView.tableFooterView = [[UIView alloc] init];
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HHPopupListViewCell"];
        _tableView = tableView;
    }
    return _tableView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
    }
    return _topView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

@end
