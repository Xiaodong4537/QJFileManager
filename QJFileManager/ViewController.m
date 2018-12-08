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
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"root=%@",NSHomeDirectory());
    NSLog(@"documents=%@",QJFileManager.pathOfDocuments);
    NSLog(@"library=%@",QJFileManager.pathOfLibrary);
    NSLog(@"cache=%@",QJFileManager.pathOfCache);
    NSLog(@"cookies=%@",QJFileManager.pathOfCookies);
    NSLog(@"preferences=%@",QJFileManager.pathOfPreferences);
    NSLog(@"tmp=%@",QJFileManager.pathOfTmp);
    
    //文件(夹)操作
    NSString *namePath = [NSString stringWithFormat:@"%@/name",QJFileManager.pathOfDocuments];
    NSString *path = [QJFileManager.pathOfTmp stringByAppendingPathComponent:@"Test/test"];
    [QJFileManager createDirectory:namePath];
    [QJFileManager createDirectory:path];
    
    BOOL flag = [QJFileManager directoryOrFileIsExists:path];
    if (flag) {
        NSLog(@"directory is exists.");
    }else{
        NSLog(@"directory isn't exists.");
    }
    
    NSString *filePath = [path stringByAppendingPathComponent:@"test.text"];
    flag = [QJFileManager createFileWithPath:filePath];
    if (flag) {
        NSLog(@"file is create.");
    }else{
        NSLog(@"file isn't create.");
    }
    
    flag = [QJFileManager directoryOrFileIsExists:filePath];
    if (flag) {
        NSLog(@"file is exists.");
    }else{
        NSLog(@"file isn't exists.");
    }
    
    flag = [QJFileManager deleteDirectoryOrFile:namePath];
    if (flag) {
        NSLog(@"directory is delete.");
    }else{
        NSLog(@"directory isn't delete");
    }
    
    flag = [QJFileManager deleteDirectoryOrFile:filePath];
    if (flag) {
        NSLog(@"flag is delete");
    } else {
        NSLog(@"flag isn't delete");
    }
    
    flag = [QJFileManager deleteDirectoryOrFile:path];
    if (flag) {
        NSLog(@"YES");
    } else {
        NSLog(@"NO");
    }
    
    NSString *text = @"我们都是中国人！";
    NSString *textPath = [QJFileManager.pathOfTmp stringByAppendingPathComponent:@"/aa/test.text"];
    flag = [QJFileManager saveString:text filePath:textPath];
    if (flag) {
        NSLog(@"text save sucess.");
    } else {
        NSLog(@"text svae failure");
    }
    
    Student *ming = [[Student alloc] init];
    ming.s_id = 1;
    ming.name = @"小明";
    ming.age =  19;
    ming.grade = 99;
    
    Student *hong = [[Student alloc] init];
    hong.s_id = 2;
    hong.name = @"小红";
    hong.age = 20;
    hong.grade = 80;
    
    NSArray *arrayS = [NSArray arrayWithObjects:ming, @"345", nil];
    
    NSString *mingPath = [[QJFileManager pathOfDocuments] stringByAppendingPathComponent:@"ming.plist"];
    NSData *data = [QJFileManager archiveRootObject:ming];
    flag = [QJFileManager saveData:data filePath:mingPath];
    if (flag) {
        NSLog(@"the data saved sucess.");
    }else{
        NSLog(@"the operation is failure.");
    }
    
    NSData *readData = [QJFileManager readData:mingPath];
    
    Student *s = (Student*)[QJFileManager unArchiveRootObject:readData class:Student.self];
    NSLog(@"the student name is:%@.",s.name);
    
    NSString *sPath = [[QJFileManager pathOfTmp] stringByAppendingPathComponent:@"test.plist"];
    NSData *datas = [QJFileManager archiveRootObject:arrayS];
    flag = [QJFileManager saveData:datas filePath:sPath];
    if (flag) {
        NSLog(@"archive is sucess.");
    }else{
        NSLog(@"archive is failed");
    }
    
    NSData *datasr = [QJFileManager readData:sPath];
    
    NSSet *set = [NSSet setWithArray:@[NSArray.self, Student.self]];
    
    NSArray *arraySR = (NSArray *)[QJFileManager unArchiveRootObject:datasr classes:set];
    
    NSLog(@"nsarray is %@.",arraySR);
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


@end
