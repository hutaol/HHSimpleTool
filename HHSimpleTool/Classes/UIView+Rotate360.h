//
//  UIView+Rotate360.h
//  BKLive
//
//  Created by Henry on 2022/3/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

enum i7Rotate360TimingMode {
    i7Rotate360TimingModeEaseInEaseOut,
    i7Rotate360TimingModeLinear
};

enum i7Rotate360RotateDirection {
    i7Rotate360RotateDirectionClockwise,
    i7Rotate360RotateDirectionAntiClockwise
};

/// 360度旋转
@interface UIView (Rotate360)

- (void)rotate360WithDuration:(CGFloat)aDuration repeatCount:(CGFloat)aRepeatCount timingMode:(enum i7Rotate360TimingMode)aMode rotateDirection:(enum i7Rotate360RotateDirection)aDirection;
- (void)rotate360WithDuration:(CGFloat)aDuration timingMode:(enum i7Rotate360TimingMode)aMode;
- (void)rotate360WithDuration:(CGFloat)aDuration;

@end

NS_ASSUME_NONNULL_END
