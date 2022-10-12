//
//  HHTestViewController.m
//  HHSimpleTool_Example
//
//  Created by Henry on 2022/9/27.
//  Copyright © 2022 1325049637@qq.com. All rights reserved.
//

#import "HHTestViewController.h"
#import <HHTool.h>

@interface HHTestViewController ()

@property (nonatomic, strong) UIVisualEffectView *effectView;

@end

@implementation HHTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];
    
    [self.view addSubview:self.effectView];

    self.effectView.frame = CGRectMake(100, 100, 100, 100);
    
    for (UIView *subview in _effectView.subviews) {
        [self setRoundedCorners:UIRectCornerTopLeft|UIRectCornerTopRight radius:5 view:subview];
    }

}

- (void)setRoundedCorners:(UIRectCorner)corners radius:(CGFloat)radius view:(UIView *)view {
    CGRect rect = view.bounds;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    
    view.layer.mask = maskLayer;
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = view.bounds;
    borderLayer.path = maskPath.CGPath;
    borderLayer.lineWidth = 1;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.strokeColor = [UIColor whiteColor].CGColor;
    [view.layer addSublayer:borderLayer];
}

- (UIVisualEffectView *)effectView {
    if (!_effectView) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        _effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//        for (UIView *subview in _effectView.subviews) {
//            subview.layer.cornerRadius = 5;
//            subview.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
//            subview.layer.borderWidth = 1;
//            subview.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.3].CGColor;
//        }
    }
    return _effectView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
