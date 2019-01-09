//
//  QJFileManager.m
//  QJFileManager
//
//  Created by xiaodong on 2018/12/4.
//  Copyright © 2018年 PSTHD. All rights reserved.
//

#import "QJFileManager.h"

@implementation QJFileManager
+ (NSString *)pathOfHome{
    return NSHomeDirectory();
}
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
    BOOL isDir = NO;
    BOOL isExists = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
    if (isExists == YES && isDir == YES) {
        NSLog(@"文件夹已存在.%s",__func__);
        return YES;
    }else{
        NSError *error;
        BOOL flag = [fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            NSLog(@"error info:%@,%s",error, __func__);
        }
        return flag;
    }
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
+ (BOOL)copySourceDirectory:(NSString *)sourcePath destinationPath:(NSString *)destinationPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    BOOL flag = [fileManager fileExistsAtPath:sourcePath isDirectory:&isDir];
    if (flag&isDir) {
        
        NSError *error;
        //stringByDeletingLastPathComponent删除最后一个路径节点
        NSString *dirPath = [destinationPath stringByDeletingLastPathComponent];
        
        //目标路径若不存在，则创建
        if (![QJFileManager existsDirectory:dirPath]) {
            BOOL flag = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
            if (error) {
                NSLog(@"create directory failed. error info: %@",error);
                return flag;
            }
        }
        
        BOOL res = [fileManager copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        if(error){
            NSLog(@"error info:%@",error);
        }
        return res;
        
    }else{
        NSLog(@"源路径路径不存在或不是文件夹|%s",__func__);
        return NO;
    }
}
+ (BOOL)moveSourceDirectory:(NSString *)sourcePath destinationPath:(NSString *)destinationPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    NSError *error;
    BOOL flag = [fileManager fileExistsAtPath:sourcePath isDirectory:&isDir];
    if (flag&isDir) {
        
        NSString *dirPath = [destinationPath stringByDeletingLastPathComponent];
        if (![QJFileManager existsDirectory:dirPath]) {
            flag = [fileManager createDirectoryAtPath:destinationPath withIntermediateDirectories:YES attributes:nil error:&error];
            if (error) {
                NSLog(@"create directory failed,error info:%@|%s",error,__func__);
                return flag;
            }
        }
        BOOL res = [fileManager moveItemAtPath:sourcePath toPath:destinationPath error:&error];
        if(error){
            NSLog(@"error info:%@|%s",error,__func__);
            return NO;
        }
        return res;
    }else{
        NSLog(@"路径不存在或不是文件夹|%s",__func__);
        return NO;
    }
}
+ (BOOL)existsDirectory:(NSString *)directoryPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    BOOL res = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
    if (res&&isDir) {
        return YES;
    }else{
        NSLog(@"路径不存在或者不是文件夹|%s",__func__);
        return NO;
    }
}

+ (NSArray *)getFileNameListAtPath:(NSString *)path
                          fileType:(NSString *)filetype{
    //创建可变数组，用来存储返回的数据
    NSMutableArray *filenamelist = [NSMutableArray arrayWithCapacity:10];
    //从文件中回去的临时列表-不会自动递归，只检查一层
    NSArray *tmplist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    for (NSString *filename in tmplist) {
        //将tmplist中的文件拼接全路径
        NSString *fullpath = [path stringByAppendingPathComponent:filename];
        //文件是否存在-理论上来说这一步不必要，因为路径都是根据文件夹中已有的文件i名称拼接而成的
        if ([self existsFileAtPath:fullpath]) {
            //文件后缀名h和要求的相等，则添加到返回数据列表中
            if ([[filename pathExtension] isEqualToString:filetype]) {
                [filenamelist addObject:filename];
            }
        }
    }
    //返回数据
    return filenamelist;
}

//递归读取路径下所有的.*文件夹 -- bug：不能再方法中生命数组来保存文件路径，每次d递归会重新生成新的数组，导致返回的数组为空，解决方案：属性、将数组声明放到方法外部、增加数组类型的参数
+ (NSArray *)showAllFileAtPath:(NSString *)path fileType:(NSString *)type{
    NSMutableArray *fileNameList = [NSMutableArray array];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if (isExist) {
        if (isDir) {
            NSArray *dirArray = [fileManager contentsOfDirectoryAtPath:path error:nil];
            NSString *subPath = nil;
            for (NSString *str in dirArray) {
                subPath = [path stringByAppendingPathComponent:str];
                [self showAllFileAtPath:subPath fileType:type];
            }
        }else{
            NSString *fileName = [[path componentsSeparatedByString:@"/"] lastObject];
            if ([fileName hasSuffix:type]) {
                [fileNameList addObject:fileName];
                NSLog(@"%@",path);
            }
        }
    }else{
        NSLog(@"this path is not exist!%s", __func__);
    }
    
    return fileNameList;
}

+ (void)getFileNameListAtPath:(NSString *)path fileType:(NSString *)type fileListArray:(NSMutableArray **)array{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isExist = [fileManager fileExistsAtPath:path isDirectory:&isDir];
    if (isExist) {
        if (isDir) {
            NSArray *dirArray = [fileManager contentsOfDirectoryAtPath:path error:nil];
            NSString *subPath = nil;
            for (NSString *str in dirArray) {
                subPath = [path stringByAppendingPathComponent:str];
                [self getFileNameListAtPath:subPath fileType:type fileListArray:array];
            }
        }else{
            NSString *fileName = [[path componentsSeparatedByString:@"/"] lastObject];
            if ([fileName hasSuffix:type]) {
                [*array addObject:path];
            }
        }
    }else{
        NSLog(@"this path is not exist!%s", __func__);
    }
}

+ (void)getAllFileAndDirectoryAtPath:(NSString *)dirPath fileListArray:(NSMutableArray **)fileArray directoryListArray:(NSMutableArray **)directoryArray isAllDirectories:(BOOL)isAllDirectories;{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (isAllDirectories) {
        //遍历包含子目录
        NSDirectoryEnumerator *directoryEnumerator = [fileManager enumeratorAtPath:dirPath];
        for (NSString *path in directoryEnumerator.allObjects) {
            [self differentiateFileOrDirectoryAtDirectoryPath:dirPath filePath:path fileListArray:fileArray directoryListArray:directoryArray];
        }
    
    }else{
        //遍历最上层目录
        NSError *error;
        NSArray *result = [fileManager contentsOfDirectoryAtPath:dirPath error:&error];
        for (NSString *path in result) {
            [self differentiateFileOrDirectoryAtDirectoryPath:dirPath filePath:path fileListArray:fileArray directoryListArray:directoryArray];
        }
    }
}

+ (void)differentiateFileOrDirectoryAtDirectoryPath:(NSString *)directoryPath filePath:(NSString *)path fileListArray:(NSMutableArray **)fileArray directoryListArray:(NSMutableArray **)directoryArray{
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/%@",directoryPath,path] isDirectory:&isDir];
    if (isDir) {
        [*directoryArray addObject:path];
        
    }else{
        if (![path containsString:@".DS_Store"]) {
            [*fileArray addObject:path];
        }
    }
}

//====================文件====================//
+ (BOOL)createFileAtPath:(NSString *)atPath{
    //1.文件管理单例
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //2.验证文件是否存在
    BOOL tmp = [fileManager fileExistsAtPath:atPath];
    if (tmp) {
        return YES;
    }
    
    //3.创建文件的路径，即文件夹
    BOOL flag = YES;
    NSError *error;
    //stringByDeletingLastPathComponent删除最后一个路径节点
    NSString *dirPath = [atPath stringByDeletingLastPathComponent];
    flag = [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:&error];
    if (error) {
        NSLog(@"create file failed. error info: %@",error);
    }
    if (!flag) {
        return flag;
    }
    
    //4.万事具备，只欠东风-创建文件，前3步是准备工作
    flag = [fileManager createFileAtPath:atPath contents:nil attributes:nil];
    return flag;
    
}
+ (BOOL)deleteFileAtPath:(NSString *)atPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //验证文件是否存在
    BOOL tmp = [fileManager fileExistsAtPath:atPath];
    if (!tmp) {
        return YES;
    }
    
    NSError *error;
    BOOL flag = [fileManager removeItemAtPath:atPath error:&error];
    if (error) {
        NSLog(@"error info:%@",error);
    }
    return flag;
}
+ (BOOL)copyFileAtPath:(NSString *)atPath toPath:(NSString *)toPath{
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL flag = [fileManager copyItemAtPath:atPath toPath:toPath error:&error];
    if (error) {
        NSLog(@"error info:%@",error);
    }
    return flag;
}
+ (BOOL)moveFileAtPath:(NSString *)atPath toPath:(NSString *)toPath{
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL flag = [fileManager moveItemAtPath:atPath toPath:toPath error:&error];
    if (error) {
        NSLog(@"error info:%@",error);
    }
    return flag;
}
+ (BOOL)existsFileAtPath:(NSString *)atPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    BOOL flag = [fileManager fileExistsAtPath:atPath isDirectory:&isDir];
    if (flag&!isDir) {
        return YES;
    }else{
        return NO;
    }
}

//====================保存文件====================//
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
//====================读取文件====================//
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

//====================归档====================//
+ (NSData *)archiveRootObject:(NSObject *)object{
    NSError *error;
    NSData *result = [NSKeyedArchiver archivedDataWithRootObject:object requiringSecureCoding:YES error:&error];
    if (error) {
        NSLog(@"archive is failed. error info:%@，%s",error,__func__);
    }
    return result;
}

//====================解档====================//
+ (NSObject *)unArchiveRootObject:(NSData *)data class:(Class)class{
    NSError *error;
    NSObject *result = [NSKeyedUnarchiver unarchivedObjectOfClass:class fromData:data error:&error];
    if (error) {
        NSLog(@"unarchiver is failed.error info:%@,%s",error,__func__);
    }
    return result;
}
+ (NSObject *)unArchiveRootObject:(NSData *)data classes:(NSSet*)classes{
    NSError *error;
    NSObject *result = [NSKeyedUnarchiver unarchivedObjectOfClasses:classes fromData:data error:nil];
    if (error) {
        NSLog(@"unarchiver is failed.error info:%@,%s",error,__func__);
    }
    return result;
}

@end
