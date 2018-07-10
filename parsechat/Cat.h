//
//  Cat.h
//  parsechat
//
//  Created by Haley Zeng on 7/9/18.
//  Copyright © 2018 Haley Zeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Cat : PFObject <PFSubclassing>

@property NSString *name;
@property int weight;
@property NSString *ownersName;

@end
