//
//  ViewController.m
//  DeprocrastinatorR
//
//  Created by Edik Shklyar on 4/18/15.
//  Copyright (c) 2015 Edik Shklyar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDataSource, UITabBarDelegate, UITextFieldDelegate, UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property NSMutableArray* array;

@property NSIndexPath* selectedIndexPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.array =[NSMutableArray new];
}
- (IBAction)tapped:(UITapGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:self.tableView];
    NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:point];

    if([self.tableView cellForRowAtIndexPath:indexPath].accessoryType ==UITableViewCellAccessoryNone)

        [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    else
         [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}

- (IBAction)onAddBtnPressed:(id)sender {
    [self.array addObject:self.textField.text];

    [self.textField resignFirstResponder];
    [self.tableView reloadData];
    NSLog(@"bla");
}

//-(void)viewDidAppear:(BOOL)animated{
////    NSIndexPath =
//    [self.tableView selectRowAtIndexPath:indexPath
//                            animated:NO
//                      scrollPosition:UITableViewScrollPositionNone];
//
//}

#pragma mark tableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
//    cell.detailTextLabel.text =@"bla";
//    cell.accessoryType = UITableViewCellAccessoryCheckmark;

    if ([self.selectedIndexPath isEqual:indexPath]) {//if it was already selected
        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
         NSLog(@"didSelectRowAtIndexPath in cellForRow");
    }

    return cell;
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    self.selectedIndexPath = indexPath;
//    [tableView reloadData];
//    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
//    NSLog(@"didSelectRowAtIndexPath");
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
////    [self doSomethingWithRowAtIndexPath:indexPath];
////    [self.tableView cellForRowAtIndexPath:indexPath] setAccessoryType:<#(UITableViewCellAccessoryType)#>
//}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath   *)indexPath
//{
//    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
//    NSLog(@"didSelectRowAtIndexPath");
//}

//-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
//     NSLog(@"didDeselectRowAtIndexPath");
//}

#pragma mark textFiled

- (void)textFieldDidBeginEditing:(UITextField *)textField{

}
- (void)textFieldDidEndEditing:(UITextField *)textField {
//    [self.tableView reloadData];
    self.textField.text = @"";
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

//    [self.array addObject:self.textField.text];
//
//    [self.textField resignFirstResponder];
//    [self.tableView reloadData];

    return YES;
}
@end
