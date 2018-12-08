//
//  Student.m
//  QJFileManager
//
//  Created by xiaodong on 2018/12/8.
//  Copyright © 2018年 PSTHD. All rights reserved.
//

#import "Student.h"

@implementation Student

- (void)study{
    NSLog(@"I can study.");
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeInt:self.s_id forKey:@"s_id"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeInt:self.age forKey:@"age"];
    [aCoder encodeInt:self.grade forKey:@"grade"];
    
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self == [super init]) {
        self.s_id = [aDecoder decodeIntForKey:@"s_id"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntForKey:@"age"];
        self.grade = [aDecoder decodeIntForKey:@"grade"];
    }
    return self;
}

- (void)setName:(NSString *)name{
    _name = name;
    NSLog(@"this is a founction output by rewrite.");
}

+ (BOOL)supportsSecureCoding{
    return YES;
}


@end
