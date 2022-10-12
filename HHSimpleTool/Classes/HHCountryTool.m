//
//  HHCountryTool.m
//  Pods
//
//  Created by Henry on 2020/12/29.
//

#import "HHCountryTool.h"
#import "HHConfiguration.h"


@implementation HHCountry : NSObject

- (instancetype)initWithName:(NSString *)name code:(NSString *)code phoneCode:(NSString *)phoneCode pinyin:(NSString *)pinyin {
    if (self = [super init]) {
        _countryName = name;
        _countryCode = code;
        _countryPinyin = pinyin;
        _phoneCode = phoneCode;
    }
    return self;
}

@end


@interface HHCountryTool()

@property (nonatomic, strong) NSArray<HHCountry *> *dataArray;
@property (nonatomic, assign) HHLanguageType languageType;

@end

@implementation HHCountryTool

static HHCountryTool *_sharedInstance = nil;
static dispatch_once_t onceToken = 0;

+ (instancetype)sharedInstance {
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

+ (void)attempDealloc {
    onceToken = 0;
    _sharedInstance = nil;
}

- (void)getCountryCompelete:(void (^)(NSArray<HHCountry *> * _Nonnull))compelete {
    
    // 有数组
    if (self.dataArray.count > 0) {
        HHLanguageType type = HHGetLanguageType();
        // 语言相同
        if (self.languageType == type) {
            if (compelete) {
                compelete(self.dataArray);
            }
            return;
        }
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        HHLanguageType type = HHGetLanguageType();
        self.languageType = type;
        NSData *data = nil;
        if (type == HHLanguageEnglish) {
            data = [NSData dataWithContentsOfFile:[NSBundle getToolFilePath:@"englishcountry" type:@"json"]];
        } else if (type == HHLanguageChineseSimplified) {
            data = [NSData dataWithContentsOfFile:[NSBundle getToolFilePath:@"chinesecountry" type:@"json"]];
        } else {
            data = [NSData dataWithContentsOfFile:[NSBundle getToolFilePath:@"chinesecountry" type:@"json"]];
        }
        
        if (!data) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (compelete) {
                    compelete(@[]);
                }
            });
            return;
        }

        NSError *error = nil;
        NSArray *arrayCode = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error) {
            return;
        }
        
        NSLog(@"%@", arrayCode);
        
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *dic in arrayCode) {
            HHCountry *country = [[HHCountry alloc] initWithName:dic[@"countryName"] code:dic[@"countryCode"]  phoneCode:dic[@"phoneCode"]  pinyin:dic[@"countryPinyin"]];
            
            [mArr addObject:country];
        }
        
        self.dataArray = mArr;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (compelete) {
                compelete(mArr);
            }
        });
        
    });
}

- (void)getCountrySectionCompelete:(void(^)(NSArray<HHCountry *> *dataArray, NSArray<HHCountry *> *sectionArray, NSArray<NSString *> *sectionTitlesArray))compelete {
    [self getCountrySection:NO compelete:compelete];
}

- (void)getCountrySection:(BOOL)showCurrent compelete:(void(^)(NSArray<HHCountry *> *dataArray, NSArray<HHCountry *> *sectionArray, NSArray<NSString *> *sectionTitlesArray))compelete {
    
    __weak typeof(self) ws = self;
    [self getCountryCompelete:^(NSArray<HHCountry *> * _Nonnull arrayCode) {
        [ws sortSection:arrayCode showCurrent:showCurrent compelete:compelete];
    }];
    
}

- (void)sortSection:(NSArray *)dataArray headerArray:(NSArray *)headerArray compelete:(void(^)(NSArray<HHCountry *> *dataArray, NSArray<HHCountry *> *sectionArray, NSArray<NSString *> *sectionTitlesArray))compelete {
    
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    NSUInteger numberOfSections = [[collation sectionTitles] count];
    NSMutableArray *newSectionArray = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < numberOfSections; index++) {
        [newSectionArray addObject:[[NSMutableArray alloc] init]];
    }
    
    // TODO 当前语言地区
    HHCountry *currentModel;
    NSString *currentLocale;

    if (headerArray.count > 0) {
        NSString *localeIdentifier = [[NSLocale currentLocale] objectForKey:NSLocaleIdentifier];
        NSArray *localeArr = [localeIdentifier componentsSeparatedByString:@"_"];
        if (localeArr.count >= 2) {
            currentLocale = localeArr[1];
        }
    }
    
    for (HHCountry *model in dataArray) {
        NSUInteger sectionIndex = [collation sectionForObject:model collationStringSelector:@selector(countryName)];
        [newSectionArray[sectionIndex] addObject:model];
        
        if (currentLocale) {
            if ([model.countryCode isEqualToString:currentLocale]) {
                currentModel = model;
            }
        }
        
    }
    
    for (NSUInteger index = 0; index < numberOfSections; index++) {
        NSMutableArray *personsForSection = newSectionArray[index];
        NSArray *sortedPersonsForSection = [collation sortedArrayFromArray:personsForSection collationStringSelector:@selector(countryName)];
        newSectionArray[index] = sortedPersonsForSection;
    }
    
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    NSMutableArray *sectionTitlesArray = [[NSMutableArray alloc] init];
    
    [newSectionArray enumerateObjectsUsingBlock:^(NSArray *arr, NSUInteger idx, BOOL *stop) {
        if (arr.count == 0) {
            [temp addObject:arr];
        } else {
            [sectionTitlesArray addObject:[collation sectionTitles][idx]];
        }
    }];
    
    [newSectionArray removeObjectsInArray:temp];
    
    if (currentModel) {
        NSMutableArray *operrationModels = [[NSMutableArray alloc] init];
        [operrationModels addObject:currentModel];

        [newSectionArray insertObject:operrationModels atIndex:0];
        [sectionTitlesArray insertObject:@"" atIndex:0];
    }

    if (compelete) {
        compelete(dataArray, newSectionArray, sectionTitlesArray);
    }
}

- (void)sortSection:(NSArray *)dataArray showCurrent:(BOOL)showCurrent compelete:(void(^)(NSArray<HHCountry *> *dataArray, NSArray<HHCountry *> *sectionArray, NSArray<NSString *> *sectionTitlesArray))compelete {
    
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    NSUInteger numberOfSections = [[collation sectionTitles] count];
    NSMutableArray *newSectionArray = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < numberOfSections; index++) {
        [newSectionArray addObject:[[NSMutableArray alloc] init]];
    }
    
    // TODO 当前语言地区
    HHCountry *currentModel;
    NSString *currentLocale;

    if (showCurrent) {
        NSString *localeIdentifier = [[NSLocale currentLocale] objectForKey:NSLocaleIdentifier];
        NSArray *localeArr = [localeIdentifier componentsSeparatedByString:@"_"];
        if (localeArr.count >= 2) {
            currentLocale = localeArr[1];
        }
    }
    
    for (HHCountry *model in dataArray) {
        NSUInteger sectionIndex = [collation sectionForObject:model collationStringSelector:@selector(countryName)];
        [newSectionArray[sectionIndex] addObject:model];
        
        if (currentLocale) {
            if ([model.countryCode isEqualToString:currentLocale]) {
                currentModel = model;
            }
        }
        
    }
    
    for (NSUInteger index = 0; index < numberOfSections; index++) {
        NSMutableArray *personsForSection = newSectionArray[index];
        NSArray *sortedPersonsForSection = [collation sortedArrayFromArray:personsForSection collationStringSelector:@selector(countryName)];
        newSectionArray[index] = sortedPersonsForSection;
    }
    
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    NSMutableArray *sectionTitlesArray = [[NSMutableArray alloc] init];
    
    [newSectionArray enumerateObjectsUsingBlock:^(NSArray *arr, NSUInteger idx, BOOL *stop) {
        if (arr.count == 0) {
            [temp addObject:arr];
        } else {
            [sectionTitlesArray addObject:[collation sectionTitles][idx]];
        }
    }];
    
    [newSectionArray removeObjectsInArray:temp];
    
    if (currentModel) {
        NSMutableArray *operrationModels = [[NSMutableArray alloc] init];
        [operrationModels addObject:currentModel];

        [newSectionArray insertObject:operrationModels atIndex:0];
        [sectionTitlesArray insertObject:@"" atIndex:0];
    }

    if (compelete) {
        compelete(dataArray, newSectionArray, sectionTitlesArray);
    }
}

- (HHCountry *)getlocaleCountry {
    HHCountry *currentModel;

    NSString *localeIdentifier = [[NSLocale currentLocale] objectForKey:NSLocaleIdentifier];
    NSArray *localeArr = [localeIdentifier componentsSeparatedByString:@"_"];
    NSString *currentLocale;
    if (localeArr.count >= 2) {
        currentLocale = localeArr[1];
    }
    for (HHCountry *model in self.dataArray) {
        if (currentLocale) {
            if ([model.countryCode isEqualToString:currentLocale]) {
                currentModel = model;
                break;
            }
        }
    }
    return currentModel;
}

- (HHCountry *)findCountry:(NSString *)code {
    HHCountry *country;
    for (HHCountry *model in self.dataArray) {
        if (code) {
            if ([model.countryCode isEqualToString:code]) {
                country = model;
                break;
            }
        }
    }
    return country;
}

- (void)getlocaleCountryCompelete:(void (^)(HHCountry * _Nonnull))compelete {
    if (self.dataArray.count == 0) {
        __weak typeof(self) weakSelf = self;
        [self getCountryCompelete:^(NSArray<HHCountry *> * _Nonnull dataArray) {
            HHCountry *country = [weakSelf getlocaleCountry];
            if (compelete) {
                compelete(country);
            }
        }];
    } else {
        HHCountry *country = [self getlocaleCountry];
        if (compelete) {
            compelete(country);
        }
    }
}

- (void)findCountry:(NSString *)code Compelete:(void (^)(HHCountry * _Nonnull))compelete {
    if (self.dataArray.count == 0) {
        __weak typeof(self) weakSelf = self;
        [self getCountryCompelete:^(NSArray<HHCountry *> * _Nonnull dataArray) {
            HHCountry *country = [weakSelf findCountry:code];
            if (compelete) {
                compelete(country);
            }
        }];
    } else {
        HHCountry *country = [self findCountry:code];
        if (compelete) {
            compelete(country);
        }
    }
}

@end

