//
//  ChatViewController.m
//  parsechat
//
//  Created by Haley Zeng on 7/9/18.
//  Copyright © 2018 Haley Zeng. All rights reserved.
//

#import "ChatViewController.h"
#import "Parse.h"
#import "ChatMessageCell.h"
#import "Dog.h"
#import "Cat.h"
#import "Person.h"

@interface ChatViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *chatMessageTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendMessageButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (strong, nonatomic) NSArray *messages;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(refresh) userInfo:nil repeats:true];

    [self addDog];
    [self getDogs];
}


- (void)addCat {
    Cat *cat = [Cat object];
    cat.name = @"Haley's Cat";
    
    [cat saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"Dog successfully saved");
    }];
}

- (void)getCats {
    PFQuery *query = [Cat query];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        for (Cat *cat in objects) {
            NSLog(@"Cat named: %@", cat.name);
        }
    }];
}

- (void)addDog {
    Dog *dog = [Dog object];
    dog.name = @"Haley's Dog";
    
    [dog saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"Dog successfully saved");
    }];
}

- (void)getDogs {
    PFQuery *query = [Dog query];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
      //  for (Dog *dog in objects) {
         //   NSLog(@"Dog named: %@", dog.name);
      //  }
    }];
}

- (void)addPerson {
    Person *person = [Person object];
    person.name = @"Haley";
    
    [person saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        NSLog(@"Person successfully saved");
    }];
}

- (void)getPersons {
    PFQuery *query = [Person query];
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        for (Person *person in objects) {
            NSLog(@"Person named: %@", person.name);
        }
    }];
}

- (void)refresh {
    PFQuery *query = [PFQuery queryWithClassName:@"Message_fbu2018"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"user"];
    query.limit = 20;
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *messages, NSError *error) {
        if (messages != nil) {
            self.messages = messages;
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatMessageCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"chatMessageCell"];
    
    // clear constraints that control left/right alignment
    // to allow us to set the correct alignment next
    [cell removeConstraint:cell.sendBubbleViewLeftConstraint];
    [cell removeConstraint:cell.sendBubbleViewRightConstraint];
    [cell removeConstraint:cell.receiveBubbleViewLeftConstraint];
    [cell removeConstraint:cell.receiveBubbleViewRightConstraint];
    
    PFObject *message = self.messages[indexPath.row];
    PFUser *user = message[@"user"];
    
    if ([user.username isEqual:PFUser.currentUser.username]) {
        // add right-align constraints
        cell.usernameLabel.textAlignment = NSTextAlignmentRight;
        [cell addConstraint:cell.sendBubbleViewLeftConstraint];
        [cell addConstraint:cell.sendBubbleViewRightConstraint];
    }
    else {
        // add left-align constraints
        cell.usernameLabel.textAlignment = NSTextAlignmentLeft;
        [cell addConstraint:cell.receiveBubbleViewLeftConstraint];
        [cell addConstraint:cell.receiveBubbleViewRightConstraint];
    }
    
    if (user != nil) {
        cell.usernameLabel.text = user.username;
    }
    else {
        cell.usernameLabel.text = @"User";
    }
    
    cell.chatMessageText.text = message[@"text"];
    cell.bubbleView.layer.cornerRadius = 16;
    return cell;
}



- (IBAction)sendMessage:(id)sender {
    PFObject *chatMessage = [PFObject objectWithClassName:@"Message_fbu2018"];
    chatMessage[@"user"] = PFUser.currentUser;
    chatMessage[@"text"] = self.chatMessageTextField.text;
    [chatMessage saveInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (succeeded) {
            NSLog(@"The message was saved!");
        } else {
            NSLog(@"Problem saving message: %@", error.localizedDescription);
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
