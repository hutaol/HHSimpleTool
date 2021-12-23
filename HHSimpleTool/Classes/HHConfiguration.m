//
//  HHConfiguration.m
//  Pods
//
//  Created by Henry on 2020/11/16.
//

#import "HHConfiguration.h"

@implementation HHConfiguration

+ (void)languageType:(HHLanguageType)languageType {
    [[NSUserDefaults standardUserDefaults] setValue:@(languageType) forKey:HHLanguageTypeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [NSBundle hhResetLanguage];
}

+ (HHLanguageType)getLanaguage {
    HHLanguageType type = [[[NSUserDefaults standardUserDefaults] valueForKey:HHLanguageTypeKey] integerValue];
    return type;
}

@end
