//
//  HHCircleLayer.h
//  Pods
//
//  Created by Henry on 2022/6/6.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

// TODO: 待优化进度流畅
/// 圆形进度
@interface HHCircleLayer : CAShapeLayer

+ (instancetype)layerWithStrokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)lineWidth radius:(CGFloat)radius;

/// 是否为顺时针
@property (nonatomic, assign) BOOL clockwise;
/// 是否递增动画
@property (nonatomic, assign) BOOL increase;
/// 圆的半径
@property (nonatomic, assign) CGFloat radius;
/// 当前进度点
@property (nonatomic, assign) CGPoint currentPoint;
/// 端点
@property (nonatomic, assign) CGFloat endAngle;

- (void)showAnimationWithProgress:(CGFloat)progress;

/// 总计时
@property (nonatomic, assign) CGFloat totalCountdown;

- (void)showAnimationWithCountdown:(CGFloat)countDown;

@end

NS_ASSUME_NONNULL_END
