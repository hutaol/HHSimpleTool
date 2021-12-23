//
//  HHPopupListView.h
//  Pods
//
//  Created by Henry on 2021/5/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHPopupListView : UIView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) CGFloat defaultTableHeight;

@property (nonatomic, strong) UIColor *topBackgroundColor;
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, assign) NSTextAlignment titlePosition;

@property (nonatomic, assign) NSTextAlignment textPosition;

@property (nonatomic, assign) BOOL isExterTop;

@property (nonatomic, strong) void(^didRowBlock)(NSInteger index, NSString *text);


- (instancetype)initWithTitle:(NSString *)title dataArray:(NSArray *)dataArray;

- (instancetype)initWithTitle:(NSString *)title dataArray:(NSArray *)dataArray titlePosition:(NSTextAlignment)titlePosition textPosition:(NSTextAlignment)textPosition topView:(nullable UIView *)topView bottomView:(nullable UIView *)bottomView ;

@end

NS_ASSUME_NONNULL_END
