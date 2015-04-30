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
@property BOOL edit;
@property NSMutableArray *checks;
@property BOOL swipe;
@property NSIndexPath *swipePath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.array =[NSMutableArray new];
    self.edit=NO;
    self.swipe = NO;
    self.checks = [NSMutableArray new];
    self.swipePath = [[NSIndexPath alloc]init];
}
- (IBAction)swipeToChangeColor:(UISwipeGestureRecognizer *)swipeGesture {

    CGPoint point = [swipeGesture locationInView:self.tableView];
     [swipeGesture setDirection:(UISwipeGestureRecognizerDirectionRight)];

    NSIndexPath *path = [self.tableView indexPathForRowAtPoint:point];

    NSIndexPath *oldPath;
    if ([oldPath isEqual:path]) {
        NSLog(@"equal");
    } else {
        NSLog(@"not equal");

    }

    int priority = 0;

    if ([path isEqual:oldPath]) {
        priority++;
    }

    switch (priority)

    {
        case 1:

            [self.tableView cellForRowAtIndexPath:path].backgroundColor = [UIColor redColor];

            NSLog(@"%d", priority);
            break;

        case 2:

            [self.tableView cellForRowAtIndexPath:path].backgroundColor = [UIColor blueColor];

            NSLog(@"%d", priority);

            break;

        case 3:

            [self.tableView cellForRowAtIndexPath:path].backgroundColor = [UIColor greenColor];

            NSLog(@"%d", priority);

            break;

        default:
            
            [self.tableView cellForRowAtIndexPath:path].backgroundColor = [UIColor grayColor];

            NSLog(@"%d", priority);

            break;
            
    }



    self.swipePath = path;
    if (path) {
        NSLog(@"path");
         UITableViewCell * cell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:path];
        cell.textLabel.backgroundColor = [UIColor greenColor];
        cell.backgroundColor = [UIColor redColor];
        [self.tableView cellForRowAtIndexPath:path].backgroundColor = [UIColor blueColor];

    }
    [self.tableView cellForRowAtIndexPath:path].textLabel.text =@"bla" ;


    [self.tableView cellForRowAtIndexPath:path].textLabel.backgroundColor = [UIColor grayColor];
    [self.tableView cellForRowAtIndexPath:path].detailTextLabel.text =@"bla";
//     [self.tableView cellForRowAtIndexPath:path].accessoryType = UITableViewCellAccessoryCheckmark;


    [self.tableView reloadData];
    NSLog(@"swipe %d", path.row);

    self.swipe = YES;

    oldPath = path;


}

- (IBAction)tapped:(UITapGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:self.tableView];

    self.selectedIndexPath=[self.tableView indexPathForRowAtPoint:point];


    if ((self.array.count !=0) && (self.checks.count !=0))
    {
        if (!self.edit)
        {
            if ([[self.checks objectAtIndex:self.selectedIndexPath.row] isEqualToNumber:[NSNumber numberWithBool:0]])
                [self.checks replaceObjectAtIndex:self.selectedIndexPath.row withObject:@YES];
            else
                [self.checks replaceObjectAtIndex:self.selectedIndexPath.row withObject:@NO];
        }
        else
        {
            [self.array removeObjectAtIndex:self.selectedIndexPath.row];
            [self.checks removeObjectAtIndex:self.selectedIndexPath.row];
        }

        [self markRowsWithCheck:self.selectedIndexPath];

    }

}
-(void)markRowsWithCheck:(NSIndexPath *)indexPath
{
    if (([self.checks[indexPath.row] isEqualToNumber:[NSNumber numberWithBool:1]]))
        [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;

    else
        [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;

     [self.tableView reloadData];
}
- (IBAction)onAddBtnPressed:(id)sender {
    [self.array addObject:self.textField.text];
    [self.checks addObject:@NO];

    [self.textField resignFirstResponder];
    [self.tableView reloadData];
}
- (IBAction)onEditButtonPressed:(id)sender {
    UIButton *button = (UIButton*)sender;
    button.titleLabel.text = @"hello";

    if ([[sender currentTitle] isEqualToString:@"Edit"]) {
         [sender setTitle:@"Done" forState:UIControlStateNormal];
        self.edit=YES;
    }
    else{
         [sender setTitle:@"Edit" forState:UIControlStateNormal];
        self.edit=NO;
    }

}
//selected? highlighted
-(void)viewDidAppear:(BOOL)animated{
    [self.tableView selectRowAtIndexPath:self.selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark tableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

        cell.textLabel.text = [self.array objectAtIndex:indexPath.row];
//    cell.textLabel.backgroundColor = [UIColor grayColor];

        if ([[self.checks objectAtIndex:indexPath.row] isEqualToNumber:[NSNumber numberWithBool:0]])
            cell.accessoryType = UITableViewCellAccessoryNone;
        else
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
//    if (self.swipe) {
//        cell.textLabel.backgroundColor =[UIColor greenColor];
//    }

return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];


    NSLog(@"delete");
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelectRowAtIndexPath method is called");


    self.selectedIndexPath = indexPath;
    if (self.edit) {
//        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
        [tableView cellForRowAtIndexPath:indexPath].textLabel.backgroundColor = [UIColor redColor];

        [tableView reloadData];
        NSLog(@"didSelectRowAtIndexPath 2");
    }
    
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
     NSLog(@"didDeselectRowAtIndexPath");
}

#pragma mark textFiled

- (void)textFieldDidBeginEditing:(UITextField *)textField{
//     NSLog(@"textFieldDidBeginEditing was called");

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
