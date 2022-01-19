//
//  UIImageView+HHCornerRadius.m
//  HHTool
//
//  Created by Henry on 2021/6/23.
//

#import "UIImageView+HHCornerRadius.h"
#import <objc/runtime.h>

const char hh_kProcessedImage;

@interface UIImageView ()

@property (assign, nonatomic) CGFloat hhRadius;
@property (assign, nonatomic) UIRectCorner hhRoundCorner;
@property (assign, nonatomic) CGFloat hhBorderWidth;
@property (strong, nonatomic) UIColor *hhBorderColor;
@property (assign, nonatomic) BOOL hhHadAddObserver;
@property (assign, nonatomic) BOOL hhIsRounding;

@end

@implementation UIImageView (HHCornerRadius)

- (instancetype)initWithCornerRadius:(CGFloat)cornerRadius rectCorner:(UIRectCorner)rectCorner {
    self = [super init];
    if (self) {
        [self hh_cornerRadius:cornerRadius rectCorner:rectCorner];
    }
    return self;
}

- (instancetype)initWithCornerRadius:(CGFloat)cornerRadius {
    self = [super init];
    if (self) {
        [self hh_cornerRadius:cornerRadius];
    }
    return self;
}

- (instancetype)initWithRoundRect {
    self = [super init];
    if (self) {
        [self hh_cornerRadiusRoundRect];
    }
    return self;
}

- (void)hh_cornerRadius:(CGFloat)cornerRadius rectCorner:(UIRectCorner)rectCorner {
    self.hhRadius = cornerRadius;
    self.hhRoundCorner = rectCorner;
    self.hhIsRounding = NO;
    if (!self.hhHadAddObserver) {
        [[self class] swizzleDealloc];
        [self addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
        self.hhHadAddObserver = YES;
    }
    //Xcode 8 xib 删除了控件的Frame信息，需要主动创造
    [self layoutIfNeeded];
}

- (void)hh_cornerRadius:(CGFloat)cornerRadius {
    if (cornerRadius < 0) {
        [self hh_cornerRadiusRoundRect];
        return;
    }
    [self hh_cornerRadius:cornerRadius rectCorner:UIRectCornerAllCorners];
}

- (void)hh_cornerRadiusRoundRect {
    self.hhIsRounding = YES;
    if (!self.hhHadAddObserver) {
        [[self class] swizzleDealloc];
        [self addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
        self.hhHadAddObserver = YES;
    }
    //Xcode 8 xib 删除了控件的Frame信息，需要主动创造
    [self layoutIfNeeded];
    
}

- (void)hh_borderWidth:(CGFloat)width color:(UIColor *)color {
    self.hhBorderWidth = width;
    self.hhBorderColor = color;
}

#pragma mark - Kernel

- (void)hh_cornerRadiusWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius rectCorner:(UIRectCorner)rectCorner {
    CGSize size = self.bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize cornerRadii = CGSizeMake(cornerRadius, cornerRadius);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    if (nil == currentContext) {
        return;
    }
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:cornerRadii];
    [cornerPath addClip];
    [self.layer renderInContext:currentContext];
    [self drawBorder:cornerPath];
    UIImage *processedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (processedImage) {
        objc_setAssociatedObject(processedImage, &hh_kProcessedImage, @(1), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.image = processedImage;
}

- (void)hh_cornerRadiusWithImage:(UIImage *)image cornerRadius:(CGFloat)cornerRadius rectCorner:(UIRectCorner)rectCorner backgroundColor:(UIColor *)backgroundColor {
    CGSize size = self.bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize cornerRadii = CGSizeMake(cornerRadius, cornerRadius);
    
    UIGraphicsBeginImageContextWithOptions(size, YES, scale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    if (nil == currentContext) {
        return;
    }
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:cornerRadii];
    UIBezierPath *backgroundRect = [UIBezierPath bezierPathWithRect:self.bounds];
    [backgroundColor setFill];
    [backgroundRect fill];
    [cornerPath addClip];
    [self.layer renderInContext:currentContext];
    [self drawBorder:cornerPath];
    UIImage *processedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (processedImage) {
        objc_setAssociatedObject(processedImage, &hh_kProcessedImage, @(1), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    self.image = processedImage;
}

#pragma mark - Private

- (void)drawBorder:(UIBezierPath *)path {
    if (0 != self.hhBorderWidth && nil != self.hhBorderColor) {
        [path setLineWidth:2 * self.hhBorderWidth];
        [self.hhBorderColor setStroke];
        [path stroke];
    }
}

- (void)hh_dealloc {
    if (self.hhHadAddObserver) {
        [self removeObserver:self forKeyPath:@"image"];
    }
    [self hh_dealloc];
}

- (void)validateFrame {
    if (self.frame.size.width == 0) {
        [self.class swizzleLayoutSubviews];
    }
}

+ (void)swizzleMethod:(SEL)oneSel anotherMethod:(SEL)anotherSel {
    Method oneMethod = class_getInstanceMethod(self, oneSel);
    Method anotherMethod = class_getInstanceMethod(self, anotherSel);
    method_exchangeImplementations(oneMethod, anotherMethod);
}

+ (void)swizzleDealloc {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:NSSelectorFromString(@"dealloc") anotherMethod:@selector(hh_dealloc)];
    });
}

+ (void)swizzleLayoutSubviews {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleMethod:@selector(layoutSubviews) anotherMethod:@selector(hh_LayoutSubviews)];
    });
}

- (void)hh_LayoutSubviews {
    [self hh_LayoutSubviews];
    if (self.hhIsRounding) {
        [self hh_cornerRadiusWithImage:self.image cornerRadius:self.frame.size.width/2 rectCorner:UIRectCornerAllCorners];
    } else if (0 != self.hhRadius && 0 != self.hhRoundCorner && nil != self.image) {
        [self hh_cornerRadiusWithImage:self.image cornerRadius:self.hhRadius rectCorner:self.hhRoundCorner];
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"image"]) {
        UIImage *newImage = change[NSKeyValueChangeNewKey];
        if ([newImage isMemberOfClass:[NSNull class]]) {
            return;
        } else if ([objc_getAssociatedObject(newImage, &hh_kProcessedImage) intValue] == 1) {
            return;
        }
        [self validateFrame];
        if (self.hhIsRounding) {
            [self hh_cornerRadiusWithImage:newImage cornerRadius:self.frame.size.width/2 rectCorner:UIRectCornerAllCorners];
        } else if (0 != self.hhRadius && 0 != self.hhRoundCorner && nil != self.image) {
            [self hh_cornerRadiusWithImage:newImage cornerRadius:self.hhRadius rectCorner:self.hhRoundCorner];
        }
    }
}

#pragma mark - Property

- (CGFloat)hhBorderWidth {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setHhBorderWidth:(CGFloat)hhBorderWidth {
    objc_setAssociatedObject(self, @selector(hhBorderWidth), @(hhBorderWidth), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)hhBorderColor {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHhBorderColor:(UIColor *)hhBorderColor {
    objc_setAssociatedObject(self, @selector(hhBorderColor), hhBorderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)hhHadAddObserver {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setHhHadAddObserver:(BOOL)hhHadAddObserver {
    objc_setAssociatedObject(self, @selector(hhHadAddObserver), @(hhHadAddObserver), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)hhIsRounding {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setHhIsRounding:(BOOL)hhIsRounding {
    objc_setAssociatedObject(self, @selector(hhIsRounding), @(hhIsRounding), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIRectCorner)hhRoundCorner {
    return [objc_getAssociatedObject(self, _cmd) unsignedLongValue];
}
    
- (void)setHhRoundCorner:(UIRectCorner)hhRoundCorner {
    objc_setAssociatedObject(self, @selector(hhRoundCorner), @(hhRoundCorner), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)hhRadius {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setHhRadius:(CGFloat)hhRadius {
    objc_setAssociatedObject(self, @selector(hhRadius), @(hhRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
