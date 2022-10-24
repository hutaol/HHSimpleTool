//
//  HHCircularView.m
//  Pods
//
//  Created by Henry on 2022/10/24.
//

#import "HHCircularView.h"

@implementation HHCirculars

- (instancetype)initWithTopLeft:(CGFloat)topLeft topRight:(CGFloat)topRight bottomLeft:(CGFloat)bottomLeft bottomRight:(CGFloat)bottomRight {
    if (self = [super init]) {
        _topLeft = topLeft;
        _topRight = topRight;
        _bottomLeft = bottomLeft;
        _bottomRight = bottomRight;
    }
    return self;
}

+ (instancetype)topLeft:(CGFloat)topLeft topRight:(CGFloat)topRight bottomLeft:(CGFloat)bottomLeft bottomRight:(CGFloat)bottomRight {
    return [[self alloc] initWithTopLeft:topLeft topRight:topRight bottomLeft:bottomLeft bottomRight:bottomRight];
}

+ (instancetype)topRadius:(CGFloat)size {
    return [[self alloc] initWithTopLeft:size topRight:size bottomLeft:0 bottomRight:0];
}

+ (instancetype)bottomRadius:(CGFloat)size {
    return [[self alloc] initWithTopLeft:0 topRight:0 bottomLeft:size bottomRight:size];
}

+ (instancetype)leftRadius:(CGFloat)size {
    return [[self alloc] initWithTopLeft:size topRight:0 bottomLeft:size bottomRight:0];
}

+ (instancetype)rightRadius:(CGFloat)size {
    return [[self alloc] initWithTopLeft:0 topRight:size bottomLeft:0 bottomRight:size];
}

+ (instancetype)allRadius:(CGFloat)size {
    return [[self alloc] initWithTopLeft:size topRight:size bottomLeft:size bottomRight:size];
}

@end

@implementation HHCircularView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = nil;
    }
    return self;
}

- (instancetype)initWithRadius:(CGFloat)radius {
    self = [super init];
    if (self) {
        _circulars = [HHCirculars allRadius:radius];
    }
    return self;
}

- (instancetype)initWithCirculars:(HHCirculars *)circulars {
    self = [super init];
    if (self) {
        _circulars = circulars;
    }
    return self;
}

- (instancetype)initShadowColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius {
    self = [super init];
    if (self) {
        self.layer.shadowColor = color.CGColor;
        self.layer.shadowOffset = offset;
        self.layer.shadowOpacity = opacity;
        self.layer.shadowRadius = radius;
    }
    return self;
}

- (void)setShadowColor:(UIColor *)color offset:(CGSize)offset opacity:(CGFloat)opacity radius:(CGFloat)radius {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
}

+ (Class)layerClass {
    return ([CAShapeLayer class]);
}

- (CAShapeLayer *)radiusLayer {
    return (CAShapeLayer *)self.layer;
}

- (CGPathRef)addRadiusRectangle:(HHCirculars *)circulars bounds:(CGRect)bounds {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(circulars.topLeft, 0)];
    [path addLineToPoint:CGPointMake(bounds.size.width-circulars.topRight, 0)];
    [path addQuadCurveToPoint:CGPointMake(bounds.size.width, circulars.topRight) controlPoint:CGPointMake(bounds.size.width, 0)];
    [path addLineToPoint:CGPointMake(bounds.size.width, bounds.size.height-circulars.bottomRight)];
    [path addQuadCurveToPoint:CGPointMake(bounds.size.width-circulars.bottomRight, bounds.size.height) controlPoint:CGPointMake(bounds.size.width, bounds.size.height)];
    [path addLineToPoint:CGPointMake(circulars.bottomLeft, bounds.size.height)];
    [path addQuadCurveToPoint:CGPointMake(0, bounds.size.height-circulars.bottomLeft) controlPoint:CGPointMake(0, bounds.size.height)];
    [path addLineToPoint:CGPointMake(0, circulars.topLeft)];
    [path addQuadCurveToPoint:CGPointMake(circulars.topLeft, 0) controlPoint:CGPointMake(0, 0)];
    [path closePath];
    return path.CGPath;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGPathRef path = [self addRadiusRectangle:self.circulars bounds:self.bounds];
    self.radiusLayer.path = path;
    self.radiusLayer.shadowPath = path;
}

- (void)setHh_backgroundColor:(UIColor *)hh_backgroundColor {
    _hh_backgroundColor = hh_backgroundColor;
    self.radiusLayer.fillColor = hh_backgroundColor.CGColor;
}

- (void)setCirculars:(HHCirculars *)circulars {
    _circulars = circulars;
    [self setNeedsLayout];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.radiusLayer.strokeColor = borderColor.CGColor;
} 

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.radiusLayer.lineWidth = borderWidth;
}

@end
