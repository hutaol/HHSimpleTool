//
//  HHConfiguration.h
//  Pods
//
//  Created by Henry on 2020/11/16.
//

#import <Foundation/Foundation.h>
#import "HHDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHConfiguration : NSObject

+ (void)languageType:(HHLanguageType)type;

+ (HHLanguageType)getLanaguage;

@end

NS_ASSUME_NONNULL_END
