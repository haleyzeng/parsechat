//
//  Dog.m
//  parsechat
//
//  Created by Haley Zeng on 7/9/18.
//  Copyright © 2018 Haley Zeng. All rights reserved.
//

#import "Dog.h"

@implementation Dog

@dynamic name, weight, ownersName;

+ (nonnull NSString *)parseClassName {
    return @"Dog";
}

@end
