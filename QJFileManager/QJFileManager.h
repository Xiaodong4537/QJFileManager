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
 * 文件夹操作
 */
+ (BOOL)createDirectory:(NSString *)directoryPath;
+ (BOOL)deleteDirectory:(NSString *)directoryPath;

/*
 * 复制文件夹
 */



/*
 * 剪切文件夹
 */



/*
 * 重命名文件夹
 */






@end

NS_ASSUME_NONNULL_END
