//
//  WorkCourseList.m
//  Graded Work
//
//  Created by  on 12/1/12.
//
//

#import "WorkCourseList.h"
#import "CourseList.h"
#import "CourseEdit.h"
#import "CourseView.h"
#import "AFNetworking.h"
#import "ICTClient.h"

@interface WorkCourseList ()

@end

@implementation WorkCourseList

@synthesize model = _model;


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
    
    //self.model.frc_gradedworks=NULL;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.model.frc_courses.fetchRequest.predicate = nil;
    //[self.model.frc_gradedworks.fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"subject == %@", self.ro]];
    
    [NSFetchedResultsController deleteCacheWithName:@"Course"];
    
    NSError *error = nil;
    [self.model.frc_courses performFetch:&error];
    
	
    // Register for a notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI:) name:@"MediaLoadedSuccessfully" object:nil];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return [[self.model.frc_courses sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    [self viewDidLoad];
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.model.frc_courses sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    //self.model.frc_gradedworks=NULL;
    
    // Configure the cell...
    
    // Get the (NSDictionary) object in the array that backs the tapped row
    NSManagedObject *d = [self.model.frc_courses objectAtIndexPath:indexPath];
    
    
    
    [self viewDidLoad];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSLog(@"\n=======in WorkCourseList.m, at the beginning of cellForRowAtIndexPath method=======");
    
    // NSDictionary *d = [self.model.Courses objectAtIndex:1];
    //NSLog(@"%@",[self.model.Courses objectAtIndex:0]);
    
    
    
    if ([[self.model.frc_courses sections] count] == 0)
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
        
        //NSManagedObject *d1 = [self.model.frc_courses objectAtIndexPath:indexPath];
        //NSManagedObject *d1 = [self.model.frc_courses objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        //NSManagedObject *d2 = [self.model.frc_semesters objectAtIndexPath:indexPath];
        //NSManagedObject *d3 = [self.model.frc_employees objectAtIndexPath:indexPath];
        
        cell.textLabel.text = [d valueForKey:@"subjectCode"];
        
        
        
        //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", [d1 valueForKey:@"semesterName"],[d1 valueForKey:@"employeeName"] ];
    
    
    
    // Finally, set the accessory (check mark) state
    cell.accessoryType = ([[d valueForKey:@"showGradedWork"] isEqualToString:@"Y"]) ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;
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

//#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    {
    
    // This table view permits check marks on more than one single row
    
        //self.model.frc_gradedworks=NULL;
        // Get the tapped cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    // Get the (NSDictionary) object in the array that backs the tapped row
   NSManagedObject *d = [self.model.frc_courses objectAtIndexPath:indexPath];
    
    // Set the check mark state
    if (cell.accessoryType == UITableViewCellAccessoryNone)
    {
        // If un-checked (clear), then check it, and save state
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [d setValue:@"Y" forKey:@"showGradedWork"];
    }
    else
    {
        // If already checked, then clear it, and save state
        cell.accessoryType = UITableViewCellAccessoryNone;
        [d setValue:@"N" forKey:@"showGradedWork"];
    }
    
    //check if core data store has graded work items for the course
        
    //if course is checked, check if its related graded works are in core data store,if not,add
    if ([[d valueForKey:@"showGradedWork"]  isEqualToString:@"Y"]) {
        [self.model fetchGradedWork:d];
    }
        
    [self.model saveChanges];
        
        /*
        
    //if course is NOT checked, remove its related graded works from core data store
    if ([[d valueForKey:@"showGradedWork"]  isEqualToString:@"NO"]) {
        
        NSString *temp = [NSString stringWithFormat:@"%@ %@",[d valueForKey:@"SubjectCode"],[d valueForKey:@"Section"]];
        
        NSLog(@"-------in WorkCourseList.m  didSelectRowAtIndexPath method, before for loop,temp is:%@",temp);
        
        for (int i=0;   i<self.model.Gradedwork.count; i++)  {
            
            NSLog(@"+$$+$$+$$+$$+$$+$$+inside for loop, courseinfo value is:%@, i is %d", [[self.model.Gradedwork objectAtIndex: i] valueForKey:@"CourseInfo"],i);
            
            if ([[[self.model.Gradedwork objectAtIndex: i] valueForKey:@"CourseInfo"] isEqualToString:temp]){
                
                //find the exact frc_gradedwork in data store by its id
                NSString *myId = [[self.model.Gradedwork objectAtIndex: i] valueForKey:@"Id"];
                
                NSLog(@"#=======#The gradedwork id is: %@",myId);
                      
                //NSFetchedResultsController *myresult = [self.model._cdStack frcWithEntityNamed:@"GradedWork" withPredicateFormat:@"id == //%@", myId predicateObject:nil sortDescriptors:@"dateDue,YES" andSectionNameKeyPath:nil];
                
                
               [self.model.frc_gradedworks.fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"id == %d", myId]];   //[courseId stringValue]]];
                
                [NSFetchedResultsController deleteCacheWithName:@"GradedWork"];
                
                NSLog(@"#########+How many graded works are found: %u",[self.model.frc_gradedworks.fetchedObjects count]);
                
                
                
                NSError *error = nil; 
                [self.model.frc_gradedworks performFetch:&error];
                
                //for(NSManagedObject *n in self.model.frc_gradedworks.fetchedObjects) {
                    
                
                
                NSManagedObject *mygradedwork = (NSManagedObject *)[self.model.frc_gradedworks.fetchedObjects lastObject];  // objectAtIndex:(NSUInteger)0];
                   
                   NSLog(@"+%%+%%+%%+%%+%%+%%+inside WorkCourseList.m for loop, mygradedwork value is:%@, i is %d",mygradedwork,i);
                       
                    (void)[self.model gradedworkDelete:mygradedwork];
                //}
            }  
       }
    }  */
    
    // Fade out the cell selection background
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     //<#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    }

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.model saveChanges];
    [self viewDidLoad];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.model saveChanges];
    [self viewDidLoad];
    //[self.tableView reloadData];
    
    ///////////
    
    [super viewWillAppear:animated];
    
    NSError *error = nil;
    //[resultsController performFetch:&error]; // Refetch data
    [self.model.frc_gradedworks performFetch:&error];
    if (error != nil) {
        // handle error
        NSLog(@"in gradedworklist.m viewwillappear method,there is error");
    }
    
    [self.tableView reloadData];
}


@end

