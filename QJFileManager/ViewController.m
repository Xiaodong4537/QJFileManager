//
//  ViewController.m
//  QJFileManager
//
//  Created by xiaodong on 2018/12/4.
//  Copyright © 2018年 PSTHD. All rights reserved.
//

#import "ViewController.h"
#import "QJFileManager.h"
#import "Student.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1. 程序初始化的生成的目录
    NSLog(@"root=%@",QJFileManager.pathOfHome);
    NSLog(@"documents=%@",QJFileManager.pathOfDocuments);
    NSLog(@"library=%@",QJFileManager.pathOfLibrary);
    NSLog(@"cache=%@",QJFileManager.pathOfCache);
    NSLog(@"cookies=%@",QJFileManager.pathOfCookies);
    NSLog(@"preferences=%@",QJFileManager.pathOfPreferences);
    NSLog(@"tmp=%@",QJFileManager.pathOfTmp);
    
    /*
     * 文件夹模块
     * 1.创建文件夹 2.删除文件夹 3.复制文件夹 4.移动文件夹 5.遍历文件夹 6.文件夹是否存在
     */
    
    BOOL flag;
    //1.创建文件夹
    NSString *path1 = [QJFileManager.pathOfTmp stringByAppendingPathComponent:@"724301566"];
    flag = [QJFileManager createDirectory:path1];
    NSLog(@"flag=%d",flag);
    
    NSString *path2 = [QJFileManager.pathOfTmp stringByAppendingString:@"name/bb/cc/"];
    flag = [QJFileManager createDirectory:path2];
    NSLog(@"flag=%d",flag);
    
    //2.删除文件夹
    flag = [QJFileManager deleteDirectory:path1];
    NSLog(@"flag=%d",flag);
    
    //文件属性
    NSString *path3 = [QJFileManager.pathOfTmp stringByAppendingString:@"test.plist"];
    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path3 error:nil];
    NSLog(@"dict=%@",dict);
   
    //3.复制文件夹
    NSString *path4 = [QJFileManager.pathOfTmp stringByAppendingPathComponent:@"copy/copy"];
    //目标路径不存在是否要创建？创建如何，不创建又如何？
    NSString *path5 = [QJFileManager.pathOfTmp stringByAppendingPathComponent:@"source/source"];
    flag = [QJFileManager copySourceDirectory:path5 destinationPath:path4];
    NSLog(@"flag=%d",flag);
    
    //4.移动文件夹
    NSString *path6 = [QJFileManager.pathOfTmp stringByAppendingPathComponent:@"source"];
    NSString *path7 = [QJFileManager.pathOfDocuments stringByAppendingPathComponent:@"MyName"];
    flag = [QJFileManager moveSourceDirectory:path6 destinationPath:path7];
    NSLog(@"flag=%d",flag);
   
    //5. 遍历文件夹
    NSString *path8 = QJFileManager.pathOfDocuments;
    
    NSArray *array = [QJFileManager getFileNameListAtPath:path8 fileType:@"plist"];
    NSLog(@"array=%@",array);
    
    NSMutableArray *arrayM = [NSMutableArray array];
    [QJFileManager getFileNameListAtPath:path8 fileType:@".plist" fileListArray:&arrayM];
    NSLog(@"arrayM=%@",arrayM);
    
    NSMutableArray *fileArray = [NSMutableArray array];
    NSMutableArray *dirArray = [NSMutableArray array];
    [QJFileManager getAllFileAndDirectoryAtPath:path8 fileListArray:&fileArray directoryListArray:&dirArray isAllDirectories:NO];
    NSLog(@"fileArray=%@",fileArray);
    NSLog(@"dirArray=%@",dirArray);
    
}





@end
