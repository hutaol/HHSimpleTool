//
//  UIButton+HHTool.m
//  Pods
//
//  Created by Henry on 2022/10/12.
//

#import "UIButton+HHTool.h"
#import <objc/runtime.h>
#import "UIImage+HHTool.h"

@implementation UIButton (HHTool)

- (NSString *)hh_tag {
    return objc_getAssociatedObject(self, @selector(hh_tag));
}

- (void)setHh_tag:(NSString *)hh_tag {
    objc_setAssociatedObject(self, @selector(hh_tag), hh_tag, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIEdgeInsets)hh_touchAreaInsets {
    return [objc_getAssociatedObject(self, @selector(hh_touchAreaInsets)) UIEdgeInsetsValue];
}

- (void)setHh_touchAreaInsets:(UIEdgeInsets)touchAreaInsets {
    NSValue *value = [NSValue valueWithUIEdgeInsets:touchAreaInsets];
    objc_setAssociatedObject(self, @selector(hh_touchAreaInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    UIEdgeInsets touchAreaInsets = self.hh_touchAreaInsets;
    CGRect bounds = self.bounds;
    bounds = CGRectMake(bounds.origin.x - touchAreaInsets.left,
                        bounds.origin.y - touchAreaInsets.top,
                        bounds.size.width + touchAreaInsets.left + touchAreaInsets.right,
                        bounds.size.height + touchAreaInsets.top + touchAreaInsets.bottom);
    return CGRectContainsPoint(bounds, point);
}

- (void)hh_setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIImage hh_imageWithColor:backgroundColor] forState:state];
}

@end
