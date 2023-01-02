//
//  HHCountryTool.m
//  Pods
//
//  Created by Henry on 2020/12/29.
//

#import "HHCountryTool.h"

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

NSString * const HHLangZHCN = @"zhcn";
NSString * const HHLangEN = @"en";

@interface HHCountryTool ()

@property (nonatomic, strong) NSArray<HHCountry *> *dataArray;
@property (nonatomic) HHLang lang;

@end

@implementation HHCountryTool

static HHCountryTool *_sharedInstance = nil;
static dispatch_once_t onceToken = 0;

+ (instancetype)sharedInstance {
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
        _sharedInstance.lang = @"en";
    });
    return _sharedInstance;
}

+ (void)attempDealloc {
    onceToken = 0;
    _sharedInstance = nil;
}

- (NSData *)getData:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [[bundle resourcePath] stringByAppendingPathComponent:name];
    return [NSData dataWithContentsOfFile:path];
}

- (void)getCountryWithLang:(HHLang)lang compelete:(HHCountryArrayCompelete)compelete {
    if ([lang isEqualToString:self.lang] && self.dataArray.count > 0) {
        if (compelete) compelete(self.dataArray);
        return;
    }
    _lang = lang;
    // 异步
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSData *data = nil;
        if (lang == HHLangZHCN) {
            data = [self getData:@"chinesecountry.json"];
        } else {
            data = [self getData:@"englishcountry.json"];
        }
        
        if (!data) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (compelete) compelete(@[]);
            });
            return;
        }
        
        NSError *error = nil;
        NSArray *arrayCode = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (compelete) compelete(@[]);
            });
            return;
        }
        
        NSMutableArray *mArr = [NSMutableArray array];
        for (NSDictionary *dic in arrayCode) {
            HHCountry *country = [[HHCountry alloc] initWithName:dic[@"countryName"] code:dic[@"countryCode"]  phoneCode:dic[@"phoneCode"]  pinyin:dic[@"countryPinyin"]];
            
            [mArr addObject:country];
        }
        
        self.dataArray = mArr;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (compelete) compelete(mArr);
        });
    });
    
}

- (void)getCountryCompelete:(HHCountryArrayCompelete)compelete {
    [self getCountryWithLang:_lang compelete:compelete];
}

- (void)getCountrySectionCompelete:(HHCountrySectionCompelete)compelete {
    [self getCountrySectionWithLang:_lang compelete:compelete];
}

- (void)getCountrySectionWithLang:(HHLang)lang compelete:(HHCountrySectionCompelete)compelete {
    __weak typeof(self) ws = self;
    [self getCountryWithLang:lang compelete:^(NSArray<HHCountry *> * _Nonnull dataArray) {
        [ws sortSection:dataArray compelete:compelete];
    }];
}

- (void)sortSection:(NSArray *)dataArray compelete:(HHCountrySectionCompelete)compelete {
    UILocalizedIndexedCollation *collation = [UILocalizedIndexedCollation currentCollation];
    NSUInteger numberOfSections = [[collation sectionTitles] count];
    NSMutableArray *newSectionArray = [[NSMutableArray alloc] init];
    for (NSUInteger index = 0; index < numberOfSections; index++) {
        [newSectionArray addObject:[[NSMutableArray alloc] init]];
    }
    
    for (HHCountry *model in dataArray) {
        NSUInteger sectionIndex = [collation sectionForObject:model collationStringSelector:@selector(countryName)];
        [newSectionArray[sectionIndex] addObject:model];
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
            if ([model.countryCode isEqualToString:[code uppercaseString]]) {
                country = model;
                break;
            }
        }
    }
    return country;
}

- (void)getlocaleCountryCompelete:(HHCountryCompelete)compelete {
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

- (void)findCountry:(NSString *)code compelete:(HHCountryCompelete)compelete {
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

