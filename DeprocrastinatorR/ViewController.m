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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.array =[NSMutableArray new];
    self.edit=NO;
    self.checks = [NSMutableArray new];
}
- (IBAction)tapped:(UITapGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:self.tableView];

     self.selectedIndexPath=[self.tableView indexPathForRowAtPoint:point];
//    NSLog(@"selectedIndexPath, %ld",(long)self.selectedIndexPath.row);


    if (self.edit)

    {
//        NSLog(@"my check 1 %@",self.checks);

        [self.array removeObjectAtIndex:self.selectedIndexPath.row];
        [self.checks removeObjectAtIndex:self.selectedIndexPath.row];

    }
    else
    {
//        NSLog(@"my check 2 %@",self.checks);
//        NSLog(@"my check %@",[self.checks objectAtIndex:self.selectedIndexPath.row]);


        if ([[self.checks objectAtIndex:self.selectedIndexPath.row] isEqualToNumber:[NSNumber numberWithBool:0]])
        {
            [self.checks replaceObjectAtIndex:self.selectedIndexPath.row withObject:@YES];
            NSLog(@"YES");
        }
        else
        {
            [self.checks replaceObjectAtIndex:self.selectedIndexPath.row withObject:@NO];

            NSLog(@"NO");
        }
//        NSLog(@"my check 3 %@",self.checks);
    }




//__________________

        [self markRowsWithCheck:self.selectedIndexPath];
//        for (int i=0; i< self.checks.count; i++)
//        {
//            if (([self.checks[i] isEqualToNumber:[NSNumber numberWithBool:1]]))
//            {
//                NSLog(@"match %d", self.selectedIndexPath.row);
//
//                [self.tableView cellForRowAtIndexPath:self.selectedIndexPath].accessoryType = UITableViewCellAccessoryCheckmark;
//                 [self.tableView reloadData];
//            }
//            else
//            {
//                [self.tableView cellForRowAtIndexPath:self.selectedIndexPath].accessoryType = UITableViewCellAccessoryNone;
//                 NSLog(@"no match %d", self.selectedIndexPath.row);
//
//
//                 [self.tableView reloadData];
//            }
////            [self.tableView reloadData];
//
//         }
//      }
//    [self.tableView reloadData];

//    else{
//        NSLog(@"no edit");
//
//        if([self.tableView cellForRowAtIndexPath:self.selectedIndexPath].accessoryType == UITableViewCellAccessoryNone){
//
////            [self.tableView cellForRowAtIndexPath:self.selectedIndexPath].accessoryType = UITableViewCellAccessoryCheckmark;
//            [self.checks replaceObjectAtIndex:self.selectedIndexPath.row withObject:@YES];
//            NSLog(@"yes");
//            NSLog(@"checks 1 %@", self.checks);
//        }
//        else
//            {
////            [self.tableView cellForRowAtIndexPath:self.selectedIndexPath].accessoryType = UITableViewCellAccessoryNone;
//            [self.checks replaceObjectAtIndex:self.selectedIndexPath.row withObject:@NO];
//            NSLog(@"checks 2 %@", self.checks);
//            NSLog(@"no");
//            }


}
-(void)markRowsWithCheck:(NSIndexPath *)indexPath
{

    NSLog(@"markRowsWithCheck call");
    NSLog(@"my check 4 %@",self.checks);



        if (([self.checks[indexPath.row] isEqualToNumber:[NSNumber numberWithBool:1]]))
        {
            NSLog(@"match %d", indexPath.row);

            [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
//            [self.tableView reloadData];
        }
        else
        {
            [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
            NSLog(@"no match %d", indexPath.row);
        }

     [self.tableView reloadData];
}
- (IBAction)onAddBtnPressed:(id)sender {
    [self.array addObject:self.textField.text];
    [self.checks addObject:@NO];

    [self.textField resignFirstResponder];
    [self.tableView reloadData];
//    NSLog(@"bla");
}
- (IBAction)onEditButtonPressed:(id)sender {
//    [sender setTitle:@"Done"];
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

//    sender.textLebel.text =@"Done";
}
//selected? highlighted
-(void)viewDidAppear:(BOOL)animated{
//    NSIndexPath =
    [self.tableView selectRowAtIndexPath:self.selectedIndexPath
                            animated:NO
                      scrollPosition:UITableViewScrollPositionNone];

}

#pragma mark tableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [self.array objectAtIndex:indexPath.row];

    if ([[self.checks objectAtIndex:indexPath.row] isEqualToNumber:[NSNumber numberWithBool:0]]) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        NSLog(@"XXX %@", self.checks);
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
         NSLog(@"WWW %@", self.checks);
    }
//    for (int i=0; i< self.checks.count; i++)
//    {
//        if (([self.checks[i] isEqualToNumber:[NSNumber numberWithBool:1]]))
//        {
//            NSLog(@"match in cell");
//            [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
//        }
//        else
//        {
//            [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
//            NSLog(@"no match in cell");
//        }
////        [self.tableView reloadData];
//
//    }

//     NSLog(@"checks array at iddex %ld %@ ", (long)indexPath.row, [self.checks objectAtIndex:indexPath.row]);
//     NSLog(@"checks array %@", self.checks);

//***    NSLog(@"cheching in cell %@",[self.checks objectAtIndex:indexPath.row]);
//    if ([[self.checks objectAtIndex:indexPath.row] isEqualToNumber:[NSNumber numberWithBool:1]])
//    {
//***    NSLog(@"check");
//         [self.tableView cellForRowAtIndexPath:self.selectedIndexPath].accessoryType = UITableViewCellAccessoryCheckmark;

//    }
//    else{
//        [self.tableView cellForRowAtIndexPath:self.selectedIndexPath].accessoryType = UITableViewCellAccessoryNone;
//***         NSLog(@"none");
//         [self.tableView reloadData];

//    }
//       NSLog(@"indexpath, %@", indexPath);
//     NSLog(@"Selected indexpath, %@", self.selectedIndexPath);
//    cell.detailTextLabel.text =@"bla";
//    cell.accessoryType = UITableViewCellAccessoryCheckmark;
//
//    if ([self.selectedIndexPath isEqual:indexPath]) {//if it was already selected
//        [tableView selectRowAtIndexPath:self.selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
////        [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//
//         NSLog(@"selectedIndexPath = indexPath");
//    }
//    else{
//        NSLog(@"selectedIndexPath != indexPath");
//    NSLog(@"selectedIndexPath %@",self.selectedIndexPath);
//    NSLog(@"indexPath %@",indexPath);
//    }
// [self.tableView reloadData];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//can comment out following two methods. Why?
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:self.selectedIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];

    NSLog(@"delete");
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelectRowAtIndexPath method is called");


    self.selectedIndexPath = indexPath;
    if (self.edit) {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
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
