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
 * 文件(夹)操作
 */
+ (BOOL)createDirectory:(NSString *)directoryPath; //创建文件夹
+ (BOOL)createFileWithPath:(NSString *)filePath;//创建文件
+ (BOOL)deleteDirectoryOrFile:(NSString *)path; //删除文件夹
+ (BOOL)directoryOrFileIsExists:(NSString *)path; //文件(夹)是否存在

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
+ (NSData *)archiveRootObject:(NSObject *)object filePath:(NSString *)filePath;
+ (NSObject *)unArchiveRootObject:(NSData *)data class:(Class)class;





@end

NS_ASSUME_NONNULL_END
