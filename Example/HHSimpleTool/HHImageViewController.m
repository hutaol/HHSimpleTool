//
//  HHImageViewController.m
//  HHSimpleTool_Example
//
//  Created by Henry on 2022/10/11.
//  Copyright © 2022 1325049637@qq.com. All rights reserved.
//

#import "HHImageViewController.h"
#import <HHSimpleTool/HHTool.h>

@interface HHImageViewController ()

@end

@implementation HHImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *image1 = [UIImage hh_imageWithColor:[UIColor redColor]];
    UIImageView *imageView1 = [self imageView:image1];
    imageView1.frame = CGRectMake(10, 100, 100, 100);
    
    UIImage *image2 = [UIImage hh_imageWithColor:[UIColor redColor] size:CGSizeMake(100, 100) cornerRadius:20];
    UIImageView *imageView2 = [self imageView:image2];
    imageView2.frame = CGRectMake(120, 100, 100, 100);
    
    UIImage *image3 = [UIImage hh_setTintColorWithImage:[UIImage imageNamed:@"image1"] color:[UIColor redColor]];
    image3 = [UIImage hh_setCornerWithImage:image3 cornerRadius:20];
    UIImageView *imageView3 = [self imageView:image3];
    imageView3.contentMode = UIViewContentModeScaleAspectFit;
    imageView3.frame = CGRectMake(10, 220, 300, 200);
    
}

- (UIImageView *)imageView:(UIImage *)image {
    UIImageView *imageView1 = [[UIImageView alloc] init];
    imageView1.image = image;
    [self.view addSubview:imageView1];
    return imageView1;
}

@end
