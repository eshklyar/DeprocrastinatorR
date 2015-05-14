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
    NSLog(@".............................");

    self.array =[NSMutableArray new];
    self.edit=NO;
    self.swipe = NO;
    self.checks = [NSMutableArray new];
    self.swipePath = [[NSIndexPath alloc]init];
    self.prioritis = [NSMutableArray new];
//    NSLog(@"the count %ld", self.prioritis.count);
    self.priority =0;

    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self.tableView addGestureRecognizer:longPress];
}

- (IBAction)longPressGestureRecognized:(id)sender
{

    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;

    CGPoint longGesturePoint = [longPress locationInView:self.tableView];
    CGPoint sourcePoint;
    CGPoint destinationPoint;

    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:longGesturePoint];
    NSIndexPath *sourceIndexPath;
    NSIndexPath *destinationIndexPath;
    UITableViewCell *cell;
    BOOL gate =true;

    switch (state) {
        case ( UIGestureRecognizerStateBegan):
        {
//            gate = true;
            if (gate)
            {
                sourceIndexPath = [self.tableView indexPathForRowAtPoint:longGesturePoint];
    //            sourceIndexPath = tempIndexPath;
                sourcePoint = longGesturePoint;
//                NSLog(@"gate in begin 1 %d", gate);

    //          NSLog(@"tempIndex %ld", (long)tempIndexPath.row);

            }
//            NSLog(@"index %ld", (long)indexPath.row);


            NSLog(@"s1 %ld", (long)sourceIndexPath.row);
            gate = false;
//            NSLog(@"gate in begin 2 %d", gate);



//        NSLog(@"begun object s %@", [self.array objectAtIndex:sourceIndexPath.row]);
//        NSLog(@"row %ld", sourceIndexPath.row);

            break;
        }
        case ( UIGestureRecognizerStateChanged):
        {
             gate = false;
//            NSLog(@"gate in change %d", gate);
            if (indexPath && ![indexPath isEqual:sourceIndexPath])
            {
//                NSLog(@"row %ld", sourceIndexPath.row);

            cell = [self.tableView cellForRowAtIndexPath:indexPath];
//            CGPoint center = cell.center;
            destinationPoint = cell.center;

            destinationPoint.y = longGesturePoint.y;
            destinationIndexPath = [self.tableView indexPathForRowAtPoint:destinationPoint];

            cell.center = destinationPoint;
            [self.tableView addSubview:cell];

//            NSLog(@"object s in change %@", [self.array objectAtIndex:sourceIndexPath.row]);
//                NSLog(@"%d",gate);

            destinationIndexPath = [self.tableView indexPathForRowAtPoint:destinationPoint];

//            NSLog(@"object s %@", [self.array objectAtIndex:sourceIndexPath.row]);
//            NSLog(@"object d %@", [self.array objectAtIndex:destinationIndexPath.row]);
                NSLog(@"s2 %ld", (long)sourceIndexPath.row);



            [self.array exchangeObjectAtIndex: sourceIndexPath.row  withObjectAtIndex:destinationIndexPath.row] ;

//            NSLog(@"s3 %ld", (long)sourceIndexPath.row);
//            NSLog(@"d %ld", (long)destinationIndexPath.row);


//            NSLog(@"object s %@", [self.array objectAtIndex:sourceIndexPath.row]);
//            NSLog(@"object d %@", [self.array objectAtIndex:destinationIndexPath.row]);
//
//
//            [self.array exchangeObjectAtIndex: sourceIndexPath.row  withObjectAtIndex:destinationIndexPath.row] ;
//
//            NSLog(@"s %ld", (long)sourceIndexPath.row);
//            NSLog(@"d %ld", (long)destinationIndexPath.row);


            }
          break;
        }

        case ( UIGestureRecognizerStateEnded):
        {
            NSLog(@".............................");


//        destinationIndexPath = [self.tableView indexPathForRowAtPoint:destinationPoint];
//
//        NSLog(@"object s %@", [self.array objectAtIndex:sourceIndexPath.row]);
//        NSLog(@"object d %@", [self.array objectAtIndex:destinationIndexPath.row]);
//
//
//        [self.array exchangeObjectAtIndex: sourceIndexPath.row  withObjectAtIndex:destinationIndexPath.row] ;
//
//        NSLog(@"s %ld", (long)sourceIndexPath.row);
//        NSLog(@"d %ld", (long)destinationIndexPath.row);


            [self.tableView reloadData];
        sourceIndexPath = nil;
        destinationIndexPath=nil;
            gate = true;
//        cell=nil;
        }
        default:
            break;
        }
}
- (IBAction)swipeToChangeColor:(UISwipeGestureRecognizer *)swipeGesture {
    swipeGesture.cancelsTouchesInView = NO;

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
        }
    }
    else{
        [self.prioritis removeObjectAtIndex:path.row];
        NSLog(@"path %ld", path.row);
    }

    [self.tableView reloadData];
}
//- (IBAction)Pan:(UIPanGestureRecognizer *)panGestureRecognizer {
//    int i;i++;
//  NSLog(@"moving bla %d",i);
//
//
//
//
//    CGPoint originalPosition = [panGestureRecognizer locationInView:self.tableView];
//    CGPoint translationPoint = [panGestureRecognizer translationInView:self.tableView];
//
//    NSIndexPath *originalPath = [self.tableView indexPathForRowAtPoint:originalPosition];
//
//    UIView *cellView = [self.tableView cellForRowAtIndexPath:originalPath];
//
//
//
//    panGestureRecognizer.view.center = CGPointMake(panGestureRecognizer.view.center.x + translationPoint.x, panGestureRecognizer.view.center.y + translationPoint.y);
//
////    panGestureRecognizer.view.center = CGPointMake(panGestureRecognizer.view.center.x + translationPoint.x,
////                                         panGestureRecognizer.view.center.y + translationPoint.y);
//    [panGestureRecognizer setTranslation:CGPointMake(0, 0) inView:self.tableView];
//
//    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded)
//    {
//        CGPoint finalPoint = panGestureRecognizer.view.center;
//        NSIndexPath *finalPath = [self.tableView indexPathForRowAtPoint:finalPoint];
//
//        [self.array replaceObjectAtIndex:originalPath.row withObject:[self.array objectAtIndex:finalPath.row]];
//    }
//}

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
            [self.tableView reloadData];
        }
        [self markRowsWithCheck:self.selectedIndexPath];
    }
}
-(void)markRowsWithCheck:(NSIndexPath *)indexPath
{
    if (self.array.count > indexPath.row)
    {

        if (([self.checks[indexPath.row] isEqualToNumber:[NSNumber numberWithBool:1]]))
            [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;

        else
            [self.tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;

         [self.tableView reloadData];
    }
}
- (IBAction)onAddBtnPressed:(id)sender {
    [self.array addObject:self.textField.text];
    if (self.array.count!=0) {

        [self.checks addObject:@NO];
        [self.prioritis addObject:[NSNumber numberWithInteger:0]];
 }
        [self.textField resignFirstResponder];
        [self.tableView reloadData];

}
- (IBAction)onEditButtonPressed:(id)sender {
//    UIButton *button = (UIButton*)sender;
//    button.titleLabel.text = @"hello";

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

#pragma mark - tableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];

        cell.textLabel.text = [self.array objectAtIndex:indexPath.row];

        if ([[self.checks objectAtIndex:indexPath.row] isEqualToNumber:[NSNumber numberWithBool:0]])
            cell.accessoryType = UITableViewCellAccessoryNone;
        else
            cell.accessoryType = UITableViewCellAccessoryCheckmark;

    NSNumber* value = [self.prioritis objectAtIndex:indexPath.row] ;

    NSInteger valueNumber = [value integerValue];

    switch (valueNumber)
    {
        case 1: cell.backgroundColor = [UIColor redColor];
            break;

        case 2: cell.backgroundColor = [UIColor blueColor];
            break;

        case 3: cell.backgroundColor = [UIColor greenColor];
            break;

        default: cell.backgroundColor = [UIColor whiteColor];
            break;
    }
//    NSLog(@"priorities %@",self.prioritis[indexPath.row]);

return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.array.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [self.array count] ) {
        return NO;
    }
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];


    NSLog(@"delete");
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"didSelectRowAtIndexPath method is called");

    self.selectedIndexPath = indexPath;
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
            [self.tableView reloadData];
        }
        [self markRowsWithCheck:self.selectedIndexPath];
    }

//    if (self.edit) {
//        [tableView cellForRowAtIndexPath:indexPath].textLabel.backgroundColor = [UIColor redColor];
//
//        [tableView reloadData];
//        NSLog(@"didSelectRowAtIndexPath 2");
//    }

}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
     NSLog(@"didDeselectRowAtIndexPath");
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}



- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"canMoveRowAtIndexPath");

    if (indexPath.row == [self.array count]) {
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    NSLog(@"moveRowAtIndexPath");

    NSString *item = [self.array objectAtIndex:fromIndexPath.row];
    [self.array removeObjectAtIndex:fromIndexPath.row];
    [self.array insertObject:item atIndex:toIndexPath.row];
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    NSLog(@"targetIndexPathForMoveFromRowAtIndexPath");

    if ([proposedDestinationIndexPath row] < [self.array count])
    {
        return proposedDestinationIndexPath;
    }
    NSIndexPath *betterIndexPath = [NSIndexPath indexPathForRow:[self.array count]-1 inSection:0];
    return betterIndexPath;
}




#pragma mark textFiled

- (void)textFieldDidBeginEditing:(UITextField *)textField{

}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.textField.text = @"";
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self.textField resignFirstResponder];
    return YES;
}


- (UIView *)customSnapshotFromView:(UIView *)inputView {

    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}
//- (UIView *)customSnapshotFromView:(UIView *)inputView {
//
//    // Make an image from the input view.
//    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
//    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//
//    // Create an image view.
//    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
//    snapshot.layer.masksToBounds = NO;
//    snapshot.layer.cornerRadius = 0.0;
//    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
//    snapshot.layer.shadowRadius = 5.0;
//    snapshot.layer.shadowOpacity = 0.4;
//
//    return snapshot;
//}
@end
