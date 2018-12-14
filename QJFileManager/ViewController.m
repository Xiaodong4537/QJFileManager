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
    
    BOOL flag;
    NSString *path1 = [QJFileManager.pathOfTmp stringByAppendingPathComponent:@"name"];
    flag = [QJFileManager createDirectory:path1];
    NSLog(@"flag=%d",flag);

    flag = [QJFileManager deleteDirectory:path1];
    NSLog(@"flag=%d",flag);
    
}


@end
