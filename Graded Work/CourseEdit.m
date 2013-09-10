//
//  CourseEdit.m
//  GradedWork
//
//  Created by  on 11/22/12.
//  Copyright (c) 2012 Peter McIntyre. All rights reserved.
//

#import "CourseEdit.h"
#import "AFNetworking.h"

@interface CourseEdit ()

@end

@implementation CourseEdit
@synthesize delegate=_delegate;
@synthesize model=_model;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Register for a notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI:) name:@"MediaLoadedSuccessfully" object:nil];
}

#pragma mark - Notification handlers

- (void)updateUI:(NSNotification *)notification
{
    // This method is called when there's new/updated data from the network
    [self.tableView reloadData];
}

#pragma mark - Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return 1;
    return [[self.model.frc_courses sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Reference the collection in the model object
    return (self.model.Courses.count == 0) ? 1 : self.model.Courses.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // NSDictionary *d = [self.model.Courses objectAtIndex:1];
    
    
    if (self.model.Courses.count == 0)
    {
        // Show a message, and disable selection/tapping
        cell.textLabel.text = @"Loading...";
        cell.accessoryType = UITableViewCellAccessoryNone;
        tableView.allowsSelection = NO;
    }
    else
    {
        tableView.allowsSelection = YES;
        NSDictionary *d = [self.model.Courses objectAtIndex:indexPath.row];
        cell.textLabel.text = [d valueForKey:@"SubjectCode"];
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get the tapped cell
    // UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    /*
    // Get the (NSDictionary) object in the array that backs the tapped row
    NSDictionary *d = [self.model.Courses objectAtIndex:indexPath.row];
    NSLog(@"%@",[d description]);
    [self.delegate CourseEditController:self didEditItem:d];
    */
    
    // Fade out the cell selection background
    // [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    // Navigation logic may go here. Create and push another view controller.
    // Fetch the selected object
    
    NSLog(@"inside CourseEdit.m didSelectRowAtIndexPath method");
          
    NSDictionary *o = [self.model.Courses objectAtIndex:indexPath.row];
    
    //if (![self.model courseExists:[NSNumber numberWithInt:[[o valueForKey:@"Id"] intValue]]]) {
                
       //NSLog(@"in CourseEdit.m if(courseExist) statement, selected course is %@",[o valueForKey:@"SubjectCode"]);
    
    
        
    [self.delegate EditCourseController:self didEditItem:o];
    
    
    //}
    
    //NSLog(@"in CourseEdit.m, after if(courseExist) statement");
    
    //[self dismissModalViewControllerAnimated:YES];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}

- (IBAction)save:(id)sender{
    [self dismissModalViewControllerAnimated: YES];
}


- (IBAction)cancel:(id)sender
{
    // Call the delegate, pass in nil
    [self.delegate EditCourseController:self didEditItem:nil];
}

/*
 - (IBAction)save:(id)sender
 {
 // Dismiss the keyboard
 [[self view] endEditing:NO];
 
 // Call back to the delegate, pass the values from the user interface
 
 // Make a dictionary, and pass it back to the delegate
 NSDictionary *d = [NSDictionary dictionaryWithObjectsAndKeys:self.tfFullName.text, @"fullName", self.tfOffice.text, @"office", self.tfEmail.text, @"email", self.tfWebSite.text, @"webSite", nil];
 
 [self.delegate EditCourseController:self didEditItem:d];
 
 }  */





@end
