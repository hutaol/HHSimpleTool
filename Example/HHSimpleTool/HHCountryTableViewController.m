//
//  HHCountryTableViewController.m
//  HHTool_Example
//
//  Created by Henry on 2021/1/3.
//  Copyright © 2021 1325049637@qq.com. All rights reserved.
//

#import "HHCountryTableViewController.h"
#import <HHSimpleTool/HHTool.h>

@interface HHCountryTableViewController () <UISearchBarDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, strong) NSMutableArray *sectionTitlesArray;

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, assign) BOOL isSearch;


@end

@implementation HHCountryTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchResults = [NSMutableArray array];

    self.tableView.tableHeaderView = self.searchBar;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];

    [HHConfiguration languageType:HHLanguageChineseSimplified];
    
    [[HHCountryTool sharedInstance] getCountrySection:NO compelete:^(NSArray<HHCountry *> * _Nonnull dataArray, NSArray<HHCountry *> * _Nonnull sectionArray, NSArray<NSString *> * _Nonnull sectionTitlesArray) {
        self.dataArray = dataArray.mutableCopy;
        self.sectionArray = sectionArray.mutableCopy;
        self.sectionTitlesArray = sectionTitlesArray.mutableCopy;
        
        HHCountry *localeCountry = [[HHCountryTool sharedInstance] getlocaleCountry];
        HHCountry *chinaCountry = [[HHCountryTool sharedInstance] findCountry:@"CN"];
        
        NSMutableArray *operrationModels = [[NSMutableArray alloc] init];
        [operrationModels addObject:localeCountry];
        if (![localeCountry.countryCode isEqualToString:chinaCountry.countryCode] ) {
            [operrationModels addObject:chinaCountry];
        }

        [self.sectionArray insertObject:operrationModels atIndex:0];
        [self.sectionTitlesArray insertObject:@"" atIndex:0];
        
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isSearch) {
        return 1;
    }
    return self.sectionTitlesArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.isSearch) {
        return self.searchResults.count;
    }
    return [self.sectionArray[section] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    HHCountry *country = self.sectionArray[indexPath.section][indexPath.row];
    cell.textLabel.text = country.countryName;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.sectionTitlesArray objectAtIndex:section];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionTitlesArray;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return 0;
//    }
//    return 22.0;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HHCountry *country = self.sectionArray[indexPath.section][indexPath.row];
    NSLog(@"%@ %@", country.countryName, country.phoneCode);
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.isSearch = YES;
    [searchBar setShowsCancelButton:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO];
    searchBar.text = @"";
    self.isSearch = NO;
    [self.searchResults removeAllObjects];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"%@", searchText);
    
    if (self.searchResults.count > 0) {
        [self.searchResults removeAllObjects];
    }
    for (HHCountry *country in self.dataArray) {
        if ([country.countryName containsString:searchText]) {
            [self.searchResults addObject:country];
        }
    }
    
    [self.tableView reloadData];

}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
        _searchBar.placeholder = @"搜索";
        _searchBar.delegate = self;
    }
    return _searchBar;
}

@end
