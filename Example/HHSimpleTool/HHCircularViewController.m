//
//  HHCircularViewController.m
//  HHSimpleTool_Example
//
//  Created by Henry on 2022/10/24.
//  Copyright © 2022 1325049637@qq.com. All rights reserved.
//

#import "HHCircularViewController.h"
#import <HHSimpleTool/HHCircularView.h>

@interface HHCircularViewController () <UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation HHCircularViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = @[@"1", @"2", @"3", @"4", @"5"].mutableCopy;
    [self.view addSubview:self.collectionView];
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    HHCircularView *view = [[HHCircularView alloc] initWithFrame:CGRectMake(30, 30, 100, 100)];
    view.hh_backgroundColor = [UIColor redColor];
    
    if (indexPath.row == 0) {
        view.hh_backgroundColor = [UIColor redColor];
        view.circulars = [HHCirculars allRadius:20];
    } else if (indexPath.row == 1) {
        view.hh_backgroundColor = [UIColor redColor];
        view.circulars = [HHCirculars bottomRadius:20];
    } else if (indexPath.row == 2) {
        view.hh_backgroundColor = [UIColor whiteColor];
        view.circulars = [HHCirculars allRadius:20];
        [view setShadowColor:[UIColor blackColor] offset:CGSizeMake(0, 5) opacity:1 radius:5];
    } else if (indexPath.row == 3) {
        view.hh_backgroundColor = [UIColor whiteColor];
        view.circulars = [HHCirculars topRadius:20];
        view.borderWidth = 2;
        view.borderColor = [UIColor redColor];
    } else {
        view.hh_backgroundColor = [UIColor whiteColor];
        view.borderWidth = 2;
        view.borderColor = [UIColor redColor];
        view.circulars = [HHCirculars allRadius:20];
        [view setShadowColor:[UIColor blackColor] offset:CGSizeMake(10, 10) opacity:1 radius:10];
    }
    
    [cell.contentView addSubview:view];
    return cell;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(160, 160);
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        collectionView.dataSource = self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        _collectionView = collectionView;
    }
    return _collectionView;
}

@end
