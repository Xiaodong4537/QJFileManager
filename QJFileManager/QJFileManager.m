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

+ (BOOL)deleteDirectoryOrFile:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if  ([fileManager fileExistsAtPath:path isDirectory:&isDir]) {//先判断目录是否存在，存在才删除
        BOOL res=[fileManager removeItemAtPath:path error:nil];
        return res;
    } else{
        return YES;
    };
}

//判断文件是否存在于路径中
+ (BOOL)directoryOrFileIsExists:(NSString *)path
{
    BOOL flag = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        flag = YES;
    } else {
        flag = NO;
    }
    return flag;
}

+ (BOOL)createFileWithPath:(NSString *)filePath{
    //1.文件管理单例
    BOOL flag = YES;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //2.验证文件是否存在
    BOOL tmp = [fileManager fileExistsAtPath:filePath];
    if (tmp) {
        return YES;
    }
    
    //3.创建文件的路径，即文件夹
    NSError *error;
    //stringByDeletingLastPathComponent删除最后一个路径节点
    NSString *dirPath = [filePath stringByDeletingLastPathComponent];
    flag = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (error) {
        NSLog(@"create file failed. error info: %@",error);
    }
    if (!flag) {
        return flag;
    }
    
    //4.万事具备，只欠东风-创建文件，前3步是准备工作
    flag = [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    return flag;
    
}

+ (BOOL)saveString:(NSString *)fileContent filePath:(NSString *)filePath{
    NSError *error;
    BOOL flag = YES;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //stringByDeletingLastPathComponent删除最后一个路径节点
    NSString *dirPath = [filePath stringByDeletingLastPathComponent];
    flag = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (!flag) {
        NSLog(@"error info:%@",error);
        return flag;
    }
    
    flag = [fileContent writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"save string is failed. error info:%@",error);
    }
    return flag;
}

+ (BOOL)saveArray:(NSArray *)fileContent filePath:(NSString *)filePath{
    BOOL flag = [fileContent writeToFile:filePath atomically:YES];
    return flag;
}

+ (BOOL)saveDictionary:(NSDictionary *)fileContent filePath:(NSString *)filePath{
    BOOL flag = [fileContent writeToFile:filePath atomically:YES];
    return flag;
}

+ (BOOL)saveData:(NSData *)fileContent filePath:(NSString *)filePath{
    BOOL flag = [fileContent writeToFile:filePath atomically:YES];
    return flag;
}


+ (NSString *)readString:(NSString *)filePath{
    NSError *error;
    NSString *file = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"read string is failed. error info:%@",error);
    }
    return file;
}

+ (NSArray *)readArray:(NSString *)filePath{
    NSArray *result = [NSArray arrayWithContentsOfFile:filePath];
    return result;
}

+ (NSDictionary *)readDictionary:(NSString *)filePath{
    NSDictionary *result = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return result;
}

+ (NSData *)readData:(NSString *)filePath{
    NSData *result = [NSData dataWithContentsOfFile:filePath];
    return result;
}

+ (NSData *)archiveRootObject:(NSObject *)object filePath:(NSString *)filePath{
    NSError *error;
    NSData *result = [NSKeyedArchiver archivedDataWithRootObject:object requiringSecureCoding:YES error:&error];
    if (error) {
        NSLog(@"archive is failed. error info:%@",error);
    }
    return result;
}

+ (NSObject *)unArchiveRootObject:(NSData *)data class:(Class)class{
    NSError *error;
    NSObject *result = [NSKeyedUnarchiver unarchivedObjectOfClass:class fromData:data error:&error];
    if (error) {
        NSLog(@"unarchiver is failed.error info:%@",error);
    }
    return result;
}



@end
