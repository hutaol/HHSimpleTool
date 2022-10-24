//
//  HHCircularView.h
//  Pods
//
//  Created by Henry on 2022/10/24.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 阴影+圆角 指定UIView的根layer为CAShapeLayer类型，通过设置layer.path实现圆角
 只设置圆角建议使用`view.layer.cornerRadius=10`方法
 
 HHCircularView *view = [[HHCircularView alloc] init];
 view.frame = CGRectMake(100, 100, 100, 100);

 // 阴影
 view.layer.shadowColor = [UIColor blackColor].CGColor;
 view.layer.shadowOffset = CGSizeMake(0, 0);
 view.layer.shadowOpacity = 1.0;
 view.layer.shadowRadius = 5;
 
 // 圆角
 view.circulars = [HHCirculars allRadius:20];
 
 // 背景色
 view.radiusLayer.fillColor = [UIColor whiteColor].CGColor;
 // 边框颜色
 view.radiusLayer.strokeColor = [UIColor greenColor].CGColor;
 view.radiusLayer.lineWidth = 2;

 */

@interface HHCirculars : NSObject

@property (nonatomic, assign) CGFloat topLeft;
@property (nonatomic, assign) CGFloat topRight;
@property (nonatomic, assign) CGFloat bottomLeft;
@property (nonatomic, assign) CGFloat bottomRight;

- (instancetype)initWithTopLeft:(CGFloat)topLeft topRight:(CGFloat)topRight bottomLeft:(CGFloat)bottomLeft bottomRight:(CGFloat)bottomRight;
+ (instancetype)topLeft:(CGFloat)topLeft topRight:(CGFloat)topRight bottomLeft:(CGFloat)bottomLeft bottomRight:(CGFloat)bottomRight;

+ (instancetype)topRadius:(CGFloat)size;
+ (instancetype)bottomRadius:(CGFloat)size;
+ (instancetype)leftRadius:(CGFloat)size;
+ (instancetype)rightRadius:(CGFloat)size;
+ (instancetype)allRadius:(CGFloat)size;

@end

@interface HHCircularView : UIView

/// 背景色
/// !!!: 不能使用backgroundColor，否则圆角失效
@property (nonatomic, strong) UIColor *hh_backgroundColor;

/// Layer
@property (nonatomic, strong, readonly) CAShapeLayer *radiusLayer;

/// 圆角
@property (nonatomic, strong) HHCirculars *circulars;
/// 边框颜色
@property (nonatomic, strong) UIColor *borderColor;
/// 边框宽度
@property (nonatomic, assign) CGFloat borderWidth;


- (instancetype)initWithRadius:(CGFloat)radius;
- (instancetype)initWithCirculars:(HHCirculars *)circulars;

- (instancetype)initShadowColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius;

- (void)setShadowColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
