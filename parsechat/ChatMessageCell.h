//
//  ChatMessageCell.h
//  parsechat
//
//  Created by Haley Zeng on 7/9/18.
//  Copyright © 2018 Haley Zeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *chatMessageText;
@property (weak, nonatomic) IBOutlet UIView *bubbleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bubbleViewLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bubbleViewRightConstraint;

@end
