//
//  HHLayerViewController.m
//  HHSimpleTool_Example
//
//  Created by Henry on 2022/6/6.
//  Copyright © 2022 1325049637@qq.com. All rights reserved.
//

#import "HHLayerViewController.h"
#import <HHSimpleTool/HHTool.h>

@interface HHLayerViewController ()

@end

@implementation HHLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    HHCircleLayer *circleLayer1 = [self addCircleLayer];
    circleLayer1.frame = CGRectMake(60, 100, 30, 30);
    
    HHCircleLayer *circleLayer2 = [self addCircleLayer];
    circleLayer2.frame = CGRectMake(120, 100, 30, 30);
    circleLayer2.clockwise = YES;
    circleLayer2.increase = NO;

    HHCircleLayer *circleLayer3 = [self addCircleLayer];
    circleLayer3.frame = CGRectMake(180, 100, 30, 30);
    circleLayer3.clockwise = NO;
    circleLayer3.increase = YES;

    HHCircleLayer *circleLayer4 = [self addCircleLayer];
    circleLayer4.frame = CGRectMake(240, 100, 30, 30);
    circleLayer4.clockwise = NO;
    circleLayer4.increase = NO;

}

- (HHCircleLayer *)addCircleLayer {
    HHCircleLayer *circleLayer = [HHCircleLayer layerWithStrokeColor:[UIColor redColor] lineWidth:3 radius:15];
    circleLayer.clockwise = NO;
    circleLayer.increase = NO;
    circleLayer.totalCountdown = 10;
    circleLayer.frame = CGRectMake(150, 100, 30, 30);
    [self.view.layer addSublayer:circleLayer];
    
    __block NSInteger count = 0;
    [HHGCDTimer timerStart:0 interval:1 repeats:YES async:NO task:^(NSString * _Nonnull timerName) {
        ++ count;
        
        [circleLayer showAnimationWithCountdown:count];
        
        if (count == circleLayer.totalCountdown) {
            [HHGCDTimer cancelTimer:timerName];
        }
    }];
    return circleLayer;
}

@end
