//
//  HHPathTool.h
//  Pods
//
//  Created by Henry on 2020/11/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHPathTool : NSObject

/// 获取文档目录路径
+ (NSString *)getDocumentPath;
/// 获取cache目录路径
+ (NSString *)getCachePath;
/// 获取tem目录路径
+ (NSString *)getTemporaryPath;

/// 获取文件的文档目录路径
+ (NSString *)getFileDocumentPath:(NSString *)fileName;
/// 获取文件在cache目录的路径
+ (NSString *)getFileCachePath:(NSString *)fileName;
/// 获取资源文件的路径
+ (NSString *)getFileResourcePath:(NSString *)fileName;

/// 判断一个文件是否存在于document目录下
+ (BOOL)isExistFileInDocument:(NSString *)fileName;
/// 判断一个文件是否存在于cache目录下
+ (BOOL)isExistFileInCache:(NSString *)fileName;
/// 判断一个文件是否存在于resource目录下
+ (BOOL)isExistFileInResource:(NSString *)fileName;
/// 判断一个全路径文件是否存在
+ (BOOL)isExistFile:(NSString *)aFilePath;

/// 在document目录下创建一个目录
+ (BOOL)createDirectoryAtDocument:(NSString *)dirName;
/// 在cache目录下创建一个目录
+ (BOOL)createDirectoryAtCache:(NSString *)dirName;
/// 在tem目录下创建一个目录
+ (BOOL)createDirectoryAtTemporary:(NSString *)dirName;
/// 创建文件
+ (BOOL)createDirectory:(NSString *)filePath;

/// 删除document目录下的一个文件夹
+ (BOOL)removeFolderInDocumet:(NSString *)aFolderNameInDoc;
/// 删除cache目录下的一个文件夹
+ (BOOL)removeFolderInCache:(NSString *)aFolderNameInCache;
/// 删除文件
+ (BOOL)deleteFileAtPath:(NSString *)filePath;

/// 拷贝文件
+ (BOOL)copySourceFile:(NSString *)sourceFile toDesPath:(NSString *)desPath;
/// 移动文件
+ (BOOL)moveSourceFile:(NSString *)sourceFile toDesPath:(NSString *)desPath;

/// 获取文件的属性集合
+ (NSDictionary *)getFileAttributsAtPath:(NSString *)filePath;
/// 获取文件大小
+ (long long)getFileSize:(NSString *)filePath;
/// 计算文件夹大小
+ (unsigned long long int)folderSize:(NSString *)folderPath;
/// 获取磁盘剩余空间的大小
+ (long long)getFreeSpaceOfDisk;

@end

NS_ASSUME_NONNULL_END
