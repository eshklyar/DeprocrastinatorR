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
@property NSMutableArray *prioritis;
@property NSInteger priority;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.array =[NSMutableArray new];
    self.edit=NO;
    self.swipe = NO;
    self.checks = [NSMutableArray new];
    self.swipePath = [[NSIndexPath alloc]init];
    self.prioritis = [NSMutableArray new];
    NSLog(@"the count %ld", self.prioritis.count);
    self.priority =0;
}
- (IBAction)swipeToChangeColor:(UISwipeGestureRecognizer *)swipeGesture {

    [swipeGesture setDirection:(UISwipeGestureRecognizerDirectionRight)];
    CGPoint point = [swipeGesture locationInView:self.tableView];
    NSIndexPath *path = [self.tableView indexPathForRowAtPoint:point];
    if (!self.edit)
    {
        if ((self.array.count !=0) && (self.prioritis.count !=0))
        {
            NSNumber *someNumber = [self.prioritis objectAtIndex:path.row];
            self.priority = [someNumber integerValue];

            if (self.priority < 4)
            {
                self.priority++;
                [self.prioritis replaceObjectAtIndex:path.row withObject:[NSNumber numberWithInteger:self.priority]];
            }
            else
            {
                self.priority =1;
                [self.prioritis replaceObjectAtIndex:path.row withObject:[NSNumber numberWithInteger:1]];
            }
//            [self changeRowColor:path withPriority:self.priority];
    //          NSLog(@"priority 2 %ld", self.priority);
        }

    }
    else{
//        [self.array removeObjectAtIndex:self.selectedIndexPath.row];
        [self.prioritis removeObjectAtIndex:path.row];
        NSLog(@"path %ld", path.row);

    }
//    if ([[self.tableView cellForRowAtIndexPath:path].backgroundColor isEqual:[UIColor whiteColor]]) {
//        self.priority = 0;
//    }
//
//else
//    self.priority =1;



//    self.swipePath = path;
//    if (path) {
//        NSLog(@"path");
//         UITableViewCell * cell = (UITableViewCell *)[self.tableView cellForRowAtIndexPath:path];
//        cell.textLabel.backgroundColor = [UIColor greenColor];
//        cell.backgroundColor = [UIColor redColor];
//        [self.tableView cellForRowAtIndexPath:path].backgroundColor = [UIColor blueColor];
//
//    }
//    [self.tableView cellForRowAtIndexPath:path].textLabel.text =@"bla" ;
//
//
//    [self.tableView cellForRowAtIndexPath:path].textLabel.backgroundColor = [UIColor grayColor];
//    [self.tableView cellForRowAtIndexPath:path].detailTextLabel.text =@"bla";
//     [self.tableView cellForRowAtIndexPath:path].accessoryType = UITableViewCellAccessoryCheckmark;


    [self.tableView reloadData];
//    NSLog(@"swipe %ld", (long)path.row);

//    self.swipe = YES;

//    oldPath = path;


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
            [self.prioritis removeObjectAtIndex:self.selectedIndexPath.row];
            NSLog(@"%@",self.prioritis);
             NSLog(@"%ld",self.selectedIndexPath.row);
//            [self.tableView reloadData];

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
-(void)changeRowColor:(NSIndexPath *)path withPriority:(NSInteger)priorityNumber

{
    switch (priorityNumber)
    {
        case 1:

            [self.tableView cellForRowAtIndexPath:path].backgroundColor = [UIColor redColor];
            break;

        case 2:

            [self.tableView cellForRowAtIndexPath:path].backgroundColor = [UIColor blueColor];
            break;

        case 3:

            [self.tableView cellForRowAtIndexPath:path].backgroundColor = [UIColor greenColor];
            break;

        default:

            [self.tableView cellForRowAtIndexPath:path].backgroundColor = [UIColor whiteColor];
            break;
    }
    [self.tableView reloadData];
}
- (IBAction)onAddBtnPressed:(id)sender {
    [self.array addObject:self.textField.text];
    [self.checks addObject:@NO];
    [self.prioritis addObject:[NSNumber numberWithInteger:0]];

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


    NSNumber* value = [self.prioritis objectAtIndex:indexPath.row] ;

    NSInteger valueNumber = [value integerValue];
    switch (valueNumber)
    {
        case 1:

        cell.backgroundColor = [UIColor redColor];
            break;

        case 2:

        cell.backgroundColor = [UIColor blueColor];
            break;

        case 3:

        cell.backgroundColor = [UIColor greenColor];
            break;

        default:

        cell.backgroundColor = [UIColor whiteColor];
            break;
    }



//    if ([[self.prioritis objectAtIndex:indexPath.row] isEqualToNumber:[NSNumber numberWithInteger:1]]) {
//        cell.backgroundColor = [UIColor redColor];
//    } else if ([[self.prioritis objectAtIndex:indexPath.row] isEqualToNumber:[NSNumber numberWithInteger:2]]){
//        cell.backgroundColor = [UIColor blueColor];
//    }else if ([[self.prioritis objectAtIndex:indexPath.row] isEqualToNumber:[NSNumber numberWithInteger:3]]){
//        cell.backgroundColor = [UIColor greenColor];
//    }else if ([[self.prioritis objectAtIndex:indexPath.row] isEqualToNumber:[NSNumber numberWithInteger:0]]){
//        cell.backgroundColor = [UIColor whiteColor];
//    }




//    if (self.swipe) {
//        cell.textLabel.backgroundColor =[UIColor greenColor];
//    }

//    while (self.prioritis)
//    {
//        NSLog(@"bla");
//        NSLog(@"the count bla %ld", self.prioritis.count);



//        [self.tableView reloadData];
//    [self resetColors:indexPath];

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
    [self.textField resignFirstResponder];
//    [self.tableView reloadData];

    return YES;
}

-(void)resetColors:(NSIndexPath*)indexPath{
    for (NSInteger x=0; x< self.prioritis.count; x++)
    {
        //            NSNumber *i = [NSNumber numberWithInteger:x];
        NSNumber * z = self.prioritis[x];
        NSInteger i = [z integerValue];

        //            int j = (int)i;
        [self changeRowColor:indexPath withPriority:i]  ;
        NSLog(@"bla bla");
        NSLog(@"the count bla bla %ld", self.prioritis.count);

        
    }


}
@end
