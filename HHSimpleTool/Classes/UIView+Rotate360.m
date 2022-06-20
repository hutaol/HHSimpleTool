//
//  UIView+Rotate360.m
//  BKLive
//
//  Created by Henry on 2022/3/16.
//

#import "UIView+Rotate360.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Rotate360)

- (void)rotate360WithDuration:(CGFloat)aDuration repeatCount:(CGFloat)aRepeatCount timingMode:(enum i7Rotate360TimingMode)aMode rotateDirection:(enum i7Rotate360RotateDirection)aDirection {
    CAKeyframeAnimation *theAnimation = [CAKeyframeAnimation animation];
    if (aDirection == i7Rotate360RotateDirectionClockwise) {
        theAnimation.values = [NSArray arrayWithObjects:
                                               [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 1)],
                                               [NSValue valueWithCATransform3D:CATransform3DMakeRotation(3.13, 0, 0, 1)],
                                               [NSValue valueWithCATransform3D:CATransform3DMakeRotation(6.26, 0, 0, 1)],
                                               nil];
    } else {
        theAnimation.values = [NSArray arrayWithObjects:
                                               [NSValue valueWithCATransform3D:CATransform3DMakeRotation(0, 0, 0, 1)],
                                               [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-3.13, 0, 0, 1)],
                                               [NSValue valueWithCATransform3D:CATransform3DMakeRotation(-6.26, 0, 0, 1)],
                                               nil];
    }

    theAnimation.cumulative = YES;
    theAnimation.duration = aDuration;
    theAnimation.repeatCount = aRepeatCount;
    theAnimation.removedOnCompletion = YES;
    
    if(aMode == i7Rotate360TimingModeEaseInEaseOut) {
        theAnimation.timingFunctions = [NSArray arrayWithObjects:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                        [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                        nil
                                        ];
    }
    [self.layer addAnimation:theAnimation forKey:@"transform"];
}

- (void)rotate360WithDuration:(CGFloat)aDuration timingMode:(enum i7Rotate360TimingMode)aMode {
    [self rotate360WithDuration:aDuration repeatCount:1 timingMode:aMode rotateDirection:i7Rotate360RotateDirectionClockwise];
}

- (void)rotate360WithDuration:(CGFloat)aDuration {
    [self rotate360WithDuration:aDuration repeatCount:1 timingMode:i7Rotate360TimingModeEaseInEaseOut rotateDirection:i7Rotate360RotateDirectionClockwise];
}

@end
