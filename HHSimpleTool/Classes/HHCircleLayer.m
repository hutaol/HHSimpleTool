//
//  HHCircleLayer.m
//  Pods
//
//  Created by Henry on 2022/6/6.
//

#import "HHCircleLayer.h"

@implementation HHCircleLayer

+ (instancetype)layerWithStrokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)lineWidth radius:(CGFloat)radius {
    HHCircleLayer *shapeLayer = [HHCircleLayer layer];
    shapeLayer.strokeColor = strokeColor.CGColor;
    shapeLayer.lineWidth = lineWidth;
    shapeLayer.fillColor = [UIColor clearColor].CGColor; // 填充色为无色
    shapeLayer.lineCap = kCALineCapRound; // 指定线的边缘是圆的
    shapeLayer.totalCountdown = 1.0;
    shapeLayer.radius = radius;
    return shapeLayer;
}

- (void)showAnimationWithCountdown:(CGFloat)countDown {
    if (_totalCountdown <= 0) {
        NSAssert(NO, @"总计时不能为0");
        return;
    }
    [self showAnimationWithProgress:countDown * 1.0 / _totalCountdown];
}

- (void)showAnimationWithProgress:(CGFloat)progress {
    CGFloat startA = - M_PI_2;  // 设置进度条起点位置
    CGFloat endA;               // 设置进度条终点位置
    CGFloat clockwiseFlag = _clockwise ? 1 : -1;
    CGFloat progressFlag = _increase ? 1 : -1;
    CGFloat percent = _increase ? progress : (1 - progress);

    // 顺增、逆减，顺时针构建环形
    BOOL shouldClockwiseBulid = (clockwiseFlag * progressFlag > 0);
    
    endA = startA + M_PI * 2 * percent * clockwiseFlag * progressFlag;
            
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(_radius, _radius) radius:_radius startAngle:startA endAngle:endA clockwise:shouldClockwiseBulid]; // 构建环形
    self.path = [path CGPath];

    self.currentPoint = path.currentPoint;
    self.endAngle = endA;
    
}

@end
