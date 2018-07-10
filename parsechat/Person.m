//
//  Person.m
//  parsechat
//
//  Created by Haley Zeng on 7/9/18.
//  Copyright © 2018 Haley Zeng. All rights reserved.
//

#import "Person.h"

@implementation Person

@dynamic name, hometown;

+ (nonnull NSString *)parseClassName {
    return @"Person";
}

@end
