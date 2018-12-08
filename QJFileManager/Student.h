//
//  Student.h
//  QJFileManager
//
//  Created by xiaodong on 2018/12/8.
//  Copyright © 2018年 PSTHD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject<NSCoding,NSSecureCoding>

@property (nonatomic, assign) int s_id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, assign) int grade;

- (void)study;


@end

NS_ASSUME_NONNULL_END
