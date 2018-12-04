//
//  QJFileManager.m
//  QJFileManager
//
//  Created by xiaodong on 2018/12/4.
//  Copyright © 2018年 PSTHD. All rights reserved.
//

#import "QJFileManager.h"

@implementation QJFileManager

+ (NSString *)pathOfDocuments{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)pathOfLibrary{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
}

+ (NSString *)pathOfCache{
    return [NSString stringWithFormat:@"%@/Cache",[QJFileManager pathOfLibrary]];
}

+ (NSString *)pathOfCookies{
    return [NSString stringWithFormat:@"%@/Cookies",[QJFileManager pathOfLibrary]];
}

+ (NSString *)pathOfPreferences{
    return [NSString stringWithFormat:@"%@/Preferences",[QJFileManager pathOfLibrary]];
}

+ (NSString *)pathOfSystemData{
    return @"暂时用不到";
}

+ (NSString *)pathOfTmp{
    return NSTemporaryDirectory();
}

+ (BOOL)createDirectory:(NSString *)directoryPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if  (![fileManager fileExistsAtPath:directoryPath isDirectory:&isDir]) {//先判断目录是否存在，不存在才创建
        BOOL res=[fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
        return res;
    } else{
        return NO;
    };
    
}

+ (BOOL)deleteDirectory:(NSString *)directoryPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if  ([fileManager fileExistsAtPath:directoryPath isDirectory:&isDir]) {//先判断目录是否存在，存在才删除
        BOOL res=[fileManager removeItemAtPath:directoryPath error:nil];
        return res;
    } else{
        return YES;
    };
}


@end
