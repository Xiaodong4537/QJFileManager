//
//  QJFileManager.h
//  QJFileManager
//
//  Created by xiaodong on 2018/12/4.
//  Copyright © 2018年 PSTHD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//iOS文件管理
@interface QJFileManager : NSObject

/*
 * 应用初始化生成的目录的路径
 */
+ (NSString *)pathOfDocuments;
+ (NSString *)pathOfLibrary;
+ (NSString *)pathOfCache;
+ (NSString *)pathOfCookies;
+ (NSString *)pathOfPreferences;
+ (NSString *)pathOfSystemData;
+ (NSString *)pathOfTmp;

/*
 * 文件夹模块
 * 1.创建文件夹 2.删除文件夹 3.复制文件夹 4.移动文件夹 5.遍历文件夹 6.文件夹是否存在
 */
+ (BOOL)createDirectory:(NSString *)directoryPath; //创建文件夹
+ (BOOL)deleteDirectory:(NSString *)directoryPath; //删除文件夹
+ (BOOL)copyDirectory:(NSString *)sourcePath destinationPath:(NSString *)destinationPath; //复制文件夹
+ (BOOL)moveDirectory:(NSString *)sourcePath destinationPath:(NSString *)destinationPath; //移动文件夹
+ (BOOL)existsDirectory:(NSString *)directoryPath; //存在文件夹
//缺少遍历文件方法

/*
 * 文件夹操作
 * 1.创建文件 2.删除文件 3.复制文件 4.移动文件 5.文件是否存在
 */
+ (BOOL)createFileAtPath:(NSString *)atPath;
+ (BOOL)deleteFileAtPath:(NSString *)atPath;
+ (BOOL)copyFileAtPath:(NSString *)atPath toPath:(NSString *)toPath;
+ (BOOL)moveFileAtPath:(NSString *)atPath toPath:(NSString *)toPath;
+ (BOOL)existsFileAtPath:(NSString *)atPath;

/*
 * 保存文件
 */
+ (BOOL)saveString:(NSString *)fileContent filePath:(NSString *)filePath;
+ (BOOL)saveArray:(NSArray *)fileContent filePath:(NSString *)filePath;
+ (BOOL)saveDictionary:(NSDictionary *)fileContent filePath:(NSString *)filePath;
+ (BOOL)saveData:(NSData *)fileContent filePath:(NSString *)filePath;

/*
 * 读取文件
 */
+ (NSString *)readString:(NSString *)filePath;
+ (NSArray *)readArray:(NSString *)filePath;
+ (NSDictionary *)readDictionary:(NSString *)filePath;
+ (NSData *)readData:(NSString *)filePath;

/*
 * 归档解档
 */
+ (NSData *)archiveRootObject:(NSObject *)object;
+ (NSObject *)unArchiveRootObject:(NSData *)data class:(Class)class;
+ (NSObject *)unArchiveRootObject:(NSData *)data classes:(NSSet*)classes;




@end

NS_ASSUME_NONNULL_END
