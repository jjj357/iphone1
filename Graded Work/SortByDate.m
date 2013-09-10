//
//  SortByDate.m
//  Graded Work
//
//  Created by  on 12/1/12.
//
//

#import "SortByDate.h"
#import "Model.h"
#import "CDStack.h"
#import "DataCreator.h"
#import "WebService.h"
#import "courses.h"
#import "gradedworks.h"
#import "AFNetworking.h"
#import "Utilities.h"
#import "ICTClient.h"

@interface SortByDate ()

@end

@implementation SortByDate


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //NSLog(@"\n& & & in courseList.m,in the beginning of  viewDidLoad method& & & ");
    //NSLog(@"\n=== in sortbydate.m,in the beginning  of  viewDidLoad method,graded work count is %u ",[self.frc_gradedworks_sortbydate count]);
    // Configure the row height
	//self.tableView.rowHeight = 55.0f;
    
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Configure and load the fetched results controller
    //self.model.frc_gradedworks_sortbydate.delegate = self;
    //self.tableView.dataSource = self;
    self.model.frc_gradedworks_sortbydate.fetchRequest.predicate = nil;
    //[self.model.frc_gradedworks_sortbydate.fetchRequest setPredicate:nil];
    //[NSPredicate predicateWithFormat:@"subject == %@", self.ro]];
    
    [NSFetchedResultsController deleteCacheWithName:@"GradedWork"];
    
    NSError *error = nil;
    [self.model.frc_gradedworks_sortbydate performFetch:&error];
    
	
    // Register for a notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI:) name:@"MediaLoadedSuccessfully" object:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //NSLog(@"\n* * *in courseList.m, at the end of  viewDidLoad method,course count is %u,gradedwork count is %d* * * ",self.frc_gradedworks_sortbydate.count,self.model.Gradedwork.count);
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)updateUI:(NSNotification *)notification
{
    // This method is called when there's new/updated data from the network
    [self.tableView reloadData];
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    //return 0;
    return [[self.model.frc_gradedworks_sortbydate sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    //return 0;
    [self viewDidLoad];
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.model.frc_gradedworks_sortbydate sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    // Configure the cell...
    [self viewDidLoad];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // NSDictionary *d = [self.model.gradedworks objectAtIndex:1];
    //NSLog(@"%@",[self.model.gradedworks objectAtIndex:0]);
    
    
    
    if ([[self.model.frc_gradedworks_sortbydate sections] count] == 0)
    {
        // Show a message, and disable selection/tapping
        cell.textLabel.text = @"Loading...";
        cell.accessoryType = UITableViewCellAccessoryNone;
        tableView.allowsSelection = NO;
    }
    else
    {
        
        tableView.allowsSelection = YES;
        //cell.textLabel.text = [self.model.temp valueForKey:@"SubjectCode"];
        
        NSManagedObject *d1 = [self.model.frc_gradedworks_sortbydate objectAtIndexPath:indexPath];
        //NSManagedObject *d1 = [self.model.frc_gradedworks objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        //NSManagedObject *d2 = [self.model.frc_semesters objectAtIndexPath:indexPath];
        //NSManagedObject *d3 = [self.model.frc_employees objectAtIndexPath:indexPath];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yy HH:mm:ss"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
        
        NSString *strDate2 = [dateFormatter stringFromDate:[d1 valueForKey:@"dateDue"]];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@-Due:%@", [d1 valueForKey:@"courseInfo"],strDate2];
        
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@  - Grade:  %@", [d1 valueForKey:@"title"], [d1 valueForKey:@"value"]];
        
        //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", [d1 valueForKey:@"semesterName"],[d1 valueForKey:@"employeeName"] ];
        
        
        //NSLog(@"in CourseList.m cellForRowAtIndexPath, SubjectCode value is %@",[[d1 valueForKey:@"subject"] valueForKey:@"code"]);
        
        //NSLog(@"in CourseList.m cellForRowAtIndexPath, semester value is %@",[NSString stringWithFormat:@"%@", [[d1 valueForKey:@"semester"]  valueForKey:@"semesterName"]] );
        //,[[d1 valueForKey:@"employee"] valueForKey:@"fullName"]]);
        //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", [d1 valueForKey:@"semester.semesterName"],[d1 valueForKey:@"employee.fullName"]];
        
        //NSManagedObject *o = [self.model.frc_subjects objectAtIndexPath:indexPath];
        //NSManagedObject *o = [self.model.frc_subjects objectAtIndexPath:indexPath];
        
        //for(NSString *s in self.model.Subject){
        //   if ([[s valueForKey:@"Code"] isEqualToString:[d valueForKey:@"SubjectCode"]]){
        
        //NSLog(@"in CourseList.m cellForRowAtIndexPath, SubjectCode value is %@",[(NSManagedObject *)[d1 valueForKey:@"subject"] valueForKey:@"code"]);
        //[self.model.frc_subjects.fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"code == %@", [d1 valueForKey:@"subject"]];
        
        //[[d1 valueForKey:@"subject"] valueForKey:@"code"];
        
        /*
         Boolean result = false;
         NSString *predicateString = [NSString stringWithFormat:@"code==%@",SubjectCode];
         NSFetchedResultsController *frc_course_filtered = [_cdStack frcWithEntityNamed:@"Subject" withPredicateFormat:predicateString predicateObject:nil sortDescriptors:nil andSectionNameKeyPath:nil];
         if (frc_course_filtered != NULL) {
         result = true;
         cell.textLabel.text = [[frc_course_filtered objectAtIndexPath:0] valueForKey:@"SubjectCode"];
         }  */
        
    }
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}

- (IBAction)done:(id)sender {
    [self dismissModalViewControllerAnimated: YES];
}
@end
