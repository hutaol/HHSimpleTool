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

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) HHCircleLayer *circleLayer;
@property (nonatomic, strong) NSString *timerName;

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
    
    _circleLayer = [HHCircleLayer layerWithStrokeColor:[UIColor greenColor] lineWidth:3 radius:15];
    _circleLayer.clockwise = NO;
    _circleLayer.increase = NO;
    _circleLayer.totalCountdown = 10;
    _circleLayer.frame = CGRectMake(150, 200, 30, 30);
    [self.view.layer addSublayer:_circleLayer];
    
    _timerName = [HHGCDTimer timerStart:0 interval:1 repeats:YES async:NO target:self selector:@selector(event)];

}

- (HHCircleLayer *)addCircleLayer {
    HHCircleLayer *circleLayer = [HHCircleLayer layerWithStrokeColor:[UIColor redColor] lineWidth:3 radius:15];
    circleLayer.clockwise = NO;
    circleLayer.increase = NO;
    circleLayer.totalCountdown = 10;
    circleLayer.frame = CGRectMake(150, 100, 30, 30);
    [self.view.layer addSublayer:circleLayer];
    
    __block NSInteger count = 0;
    [HHGCDTimer timerStart:0 interval:1 repeats:YES async:NO target:self task:^(NSString * _Nonnull timerName) {
        ++ count;
        NSLog(@"%@ %ld", timerName, count);
        [circleLayer showAnimationWithCountdown:count];

        if (count == circleLayer.totalCountdown) {
            [HHGCDTimer cancelTimer:timerName];
        }
    }];
    return circleLayer;
}

- (void)event {
    ++ _count;
    NSLog(@"%@ %ld", _timerName, _count);
    [_circleLayer showAnimationWithCountdown:_count];
    
    if (_count == _circleLayer.totalCountdown) {
        [HHGCDTimer cancelTimer:_timerName];
    }
}

- (void)dealloc {
    NSLog(@"dealloc");
}

@end
