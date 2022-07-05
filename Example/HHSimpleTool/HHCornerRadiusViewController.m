//
//  HHCornerRadiusViewController.m
//  HHTool_Example
//
//  Created by Henry on 2021/10/12.
//  Copyright © 2021 1325049637@qq.com. All rights reserved.
//

#import "HHCornerRadiusViewController.h"
#import <HHSimpleTool/HHTool.h>


@interface HHCornerRadiusViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation HHCornerRadiusViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.frame = self.bounds;

        [self.contentView addSubview:self.imageView];
    }
    return self;
}

@end

@interface HHCornerRadiusViewController ()

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation HHCornerRadiusViewController

static NSString * const reuseIdentifier = @"Cell";

- (instancetype)init
{
    self = [super init];
    if (self) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat width = ([UIScreen mainScreen].bounds.size.width-40)/3;
        layout.itemSize = CGSizeMake(width, width);
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 10;

        return [super initWithCollectionViewLayout:layout];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self.collectionView registerClass:[HHCornerRadiusViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    self.dataArray = @[@"-1", @"20", @"0",
                       @"20", @"20", @"20",
                       @"20", @"20", @"20",
                       @"20", @"20", @"20"];
    
}

#pragma mark - UICollectionView data source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HHCornerRadiusViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    CGFloat value = [self.dataArray[indexPath.row] floatValue];
    
    if (indexPath.row < 3) {
        [cell.imageView hh_backgroundColor:[UIColor redColor]];
        [cell.imageView hh_cornerRadius:value];
    } else if (indexPath.row == 3) {
        [cell.imageView hh_cornerRadius:value rectCorner:UIRectCornerTopLeft];
    } else if (indexPath.row == 4) {
        [cell.imageView hh_cornerRadius:value rectCorner:UIRectCornerTopRight];
    } else if (indexPath.row == 5) {
        [cell.imageView hh_cornerRadius:value rectCorner:UIRectCornerBottomLeft];
    } else if (indexPath.row == 6) {
        [cell.imageView hh_cornerRadius:value rectCorner:UIRectCornerBottomLeft | UIRectCornerTopLeft];
    } else if (indexPath.row == 7) {
        [cell.imageView hh_cornerRadius:value rectCorner:UIRectCornerBottomLeft | UIRectCornerTopRight];
    } else if (indexPath.row == 8) {
        [cell.imageView hh_cornerRadius:value rectCorner:UIRectCornerTopLeft | UIRectCornerBottomRight];
    } else if (indexPath.row == 9) {
        [cell.imageView hh_cornerRadius:20 rectCorner:UIRectCornerTopLeft | UIRectCornerBottomRight];
        [cell.imageView hh_borderWidth:2 color:[UIColor redColor]];
    } else if (indexPath.row == 10) {
        [cell.imageView hh_cornerRadiusRoundRect];
        [cell.imageView hh_borderWidth:2 color:[UIColor redColor]];
    } else if (indexPath.row == 11) {
        [cell.imageView hh_cornerRadius:20];
        [cell.imageView hh_borderWidth:2 color:[UIColor redColor]];
    }
    
    /// 后设置才有效
    cell.imageView.image = [UIImage imageNamed:@"image2"];

    return cell;
}

@end
