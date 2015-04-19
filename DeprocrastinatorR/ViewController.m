//
//  ViewController.m
//  DeprocrastinatorR
//
//  Created by Edik Shklyar on 4/18/15.
//  Copyright (c) 2015 Edik Shklyar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITabBarDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UITextField *myTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView = [[UITableView alloc]init];
//    [self.tableView reloadData];
//    self.tableView.delegate = self;
}
- (IBAction)onAddBtnPressed:(id)sender {
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
NSLog(@"bla");

    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        NSLog(@"bla");
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text =@"hello world";
    cell.backgroundColor = [UIColor greenColor];

//    cell.textLabel.description = @"oh well";
    cell.tintColor = [UIColor blueColor];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    return YES;
}
@end
