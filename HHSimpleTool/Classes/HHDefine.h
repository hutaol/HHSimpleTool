//
//  HHDefine.h
//  Pods
//
//  Created by Henry on 2020/11/16.
//

#ifndef HHDefine_h
#define HHDefine_h

#import "NSBundle+HHTool.h"

typedef NS_ENUM(NSUInteger, HHLanguageType) {
    //跟随系统语言，默认
    HHLanguageSystem,
    //中文简体
    HHLanguageChineseSimplified,
    //中文繁体
    HHLanguageChineseTraditional,
    //英文
    HHLanguageEnglish,
    //日文
    HHLanguageJapanese,
};

#define HHLanguageTypeKey @"HHLanguageTypeKey"


static inline NSString *HHGetLocalLanguageTextValue(NSString *key) {
    return [NSBundle hhLocalizedStringForKey:key];
}

static inline UIImage *HHGetImageWithName(NSString *name) {
    return [NSBundle getImageForHHTool:name];
}

static inline HHLanguageType HHGetLanguageType() {
    return (HHLanguageType)[NSBundle HHGetLanguageType];
}

#endif /* HHDefine_h */
