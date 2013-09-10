//
//  GradedWorkList.m
//  Graded Work
//
//  Created by  on 11/30/12.
//
//

#import "GradedWorkList.h"
#import "WorkEdit.h"
#import "WorkView.h"
#import "AFNetworking.h"
#import "ICTClient.h"


@interface GradedWorkList ()

@end

@implementation GradedWorkList

@synthesize model = _model;
@synthesize ro = _ro;
@synthesize gradedworks = _gradedworks;

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
    /*
     for (int j=0;   j<self.model.frc_courses.count; j++) {
    for (int i=0;   i<self.model.Gradedwork.count; i++) {
        //NSLog(@"inside CourseList.m delegate's search subject loop");
        //NSLog(@"in GradedWorkList.m delegate's search subject loop, NSDictionary value is %@",[d valueForKey:@"SubjectCode"]);
        
        //NSLog(@"in CourseList.m delegate, SubjectCode value is %@", [self.model.Courses objectAtIndex: i]);
        
        //NSLog(@"in GradedWorkList.m delegate's search subject loop, Subject [i] value is %@",[[self.model.Gradedwork objectAtIndex: i] valueForKey:@"Code"]);
        
        
        if ([[[self.model.Gradedwork objectAtIndex: i] valueForKey:@"CourseInfo"] isEqualToString:[d valueForKey:@"SubjectCode"]])  {
            [self.model addNewSubject:[[self.model.Subject objectAtIndex: i] valueForKey:@"Code"]
                        inDescription:[[self.model.Subject objectAtIndex: i] valueForKey:@"Description"]
                          inSubjectId:[[[self.model.Subject objectAtIndex: i] valueForKey:@"Id"] intValue]
                               inName:[[self.model.Subject objectAtIndex: i] valueForKey:@"Name"]
                         inOutLineURL:[[self.model.Subject objectAtIndex: i] valueForKey:@"OutlineUrl"]];
            //NSLog(@"in CourseList.m delegate's addNewSubject, SubjectCode value is %@",[addedSubject valueForKey:@"code"]);
        }
        
    }//end of 2nd for loop
    }//end of first for loop
    
    [self.model saveChanges];
    
    */
    
    // Configure the row height
	//self.tableView.rowHeight = 55.0f;
    
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Configure and load the fetched results controller
    //self.model.frc_gradedworks.delegate = self;
    //self.tableView.dataSource = self;
    self.model.frc_gradedworks.fetchRequest.predicate = nil;
    //NSString *mystring = @"Y";
    [self.model.frc_courses.fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"course.showGradedWork == 'Y'"]];  
                                                           
    //[self.model.frc_gradedworks.fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"course.showGradedWork == %@",@"YES"]] ;  //], self.ro]];
    
    [NSFetchedResultsController deleteCacheWithName:@"GradedWork"];
    
    NSError *error = nil;
    [self.model.frc_gradedworks performFetch:&error];
    
	
    // Register for a notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI:) name:@"MediaLoadedSuccessfully" object:nil];
    
    //_gradedworks =  [self.model fetchDataForEntityNamed:@"GradedWork" withPredicateFormat:[NSString stringWithFormat:@"course.showGradedWork == %@",@"Y"] predicateObject:nil sortDescriptors:nil];
    
     //NSLog(@"=***===***=====in gradedworklist.m viewdidload method, gradedwork's description is %@", [self.gradedworks description]);
    
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)updateUI:(NSNotification *)notification
{
    // This method is called when there's new/updated data from the network
    [self.tableView reloadData];
}

/*
 - (void)setEditing:(BOOL)editing animated:(BOOL)animated
 {
 [super setEditing:editing animated:animated];
 
 if (editing)
 {
 // The "Edit button was tapped, so we create an "Add" (+) button on the left side
 UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
 // Add it to the left side of the nav bar
 [self.navigationItem setLeftBarButtonItem:addButton animated:YES];
 }
 else
 {
 // The "Done" button was tapped, so we remove the add button from the left side
 [self.navigationItem setLeftBarButtonItem:nil animated:YES];
 }
 }   */


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    //return 1;
    return [[self.model.frc_gradedworks sections] count];  //<==removed recently
    //[self.gradedworks count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //[self.tableView reloadData];
    // Return the number of rows in the section.
    //return self.model.gradedworks.count;
    [self viewDidLoad];
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.model.frc_gradedworks sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    // Fetch the dictionary
    //id d = [self.model.frc_gradedworks objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
    
    // Configure the text label
    //cell.textLabel.text = [d valueForKey:@"SubjectCode"];
    
    // Convert the ISO 8601 date to an NSDate
    //NSDate *releaseDate = [Utilities DateFromISO8601String:[d valueForKey:@"releaseDate"]];
    // Configure the detail text label
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", [d valueForKey:@"SemesterName"],
    //                           [d valueForKey:@"EmployeeName"]];
    //[NSDateFormatter localizedStringFromDate:releaseDate dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle]];
    
    /*
     // Alternative detail text label...
     cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - $%1.2f, %1.2f minutes", [d valueForKey:@"artistName"], [[d valueForKey:@"trackPrice"] floatValue], [[d valueForKey:@"trackTimeMillis"] floatValue] / 60000.0];
     */
    
    //[self.tableView reloadData];
    //[self.tableView reloadData];
    
    [self viewDidLoad];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // NSDictionary *d = [self.model.gradedworks objectAtIndex:1];
    //NSLog(@"%@",[self.model.gradedworks objectAtIndex:0]);
    
    
    
    if ([[self.model.frc_gradedworks sections] count] == 0)
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
        
        /*
        NSString *temp = [NSString stringWithFormat:@"%@ %@",[course valueForKey:@"SubjectCode"],[course valueForKey:@"Section"]];
        
        NSLog(@"-------in model.m fetchGradedWork:course method, before for loop,temp is:%@",temp);
        
        //for(NSDictionary *s in self.Gradedwork){
        for (int i=0;   i<self.model.Gradedwork.count; i++)  {
            
            NSLog(@"+++++++inside for loop, courseinfo value is:%@, i is %d", [[self.Gradedwork objectAtIndex: i] valueForKey:@"CourseInfo"],i);
            
            if ([[[self.model.Gradedwork objectAtIndex: i] valueForKey:@"CourseInfo"] isEqualToString:temp]){
                */
                
        //NSManagedObject *d1 = [self.gradedworks objectAtIndex:indexPath.row];
        NSManagedObject *d1 = [self.model.frc_gradedworks objectAtIndexPath:indexPath];
        //NSManagedObject *d1 = [self.model.frc_gradedworks objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        //NSManagedObject *d2 = [self.model.frc_semesters objectAtIndexPath:indexPath];
        //NSManagedObject *d3 = [self.model.frc_employees objectAtIndexPath:indexPath];
        
        cell.textLabel.text = [d1 valueForKey:@"courseInfo"];
        
        
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Navigation push
    
     if ([segue.identifier isEqualToString:@"toGradedWorkView"])
     {
     // Fetch the selected object
     NSManagedObject *o = [self.model.frc_gradedworks objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
     //Configure the next VC
     WorkView *nextVC = (WorkView *)segue.destinationViewController;
     NSLog(@"in CourseList.m segue to graded works view, subject code value is %@",[o valueForKey:@"courseInfo"]);
     nextVC.title = [NSString stringWithFormat:@"%@-%@",[o valueForKey:@"courseInfo"],[o valueForKey:@"title"]];
     //nextVC.model = self.model;
     
     nextVC.ro= o;
     }  
    
    //click "Edit" to sort view
    if ([segue.identifier isEqualToString:@"toGradedWorkEdit"])
    {
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        //NSManagedObject *so = [self.model.frc_gradedworks objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        WorkEdit *nextVC = (WorkEdit *)nav.topViewController;
        nextVC.model = self.model;
        //nextVC.delegate = self;
        //nextVC.ro = so;
    }
}


/*
#pragma mark - Delegate methods

- (void)EditCourseController:(id)controller didEditItem:(id)item
{
    //NSString *temp;
    //id addedSubject,addedSemester,addedEmployee;
    // Add a new object to the store, only if an object was passed in
    if (item) {
        NSDictionary *d = (NSDictionary *)item;
        
        NSLog(@"in CourseList.m delegate, SubjectCode value is %@",[d valueForKey:@"SubjectCode"]);
        
        //for(NSString *s in self.model.Subject){
        for (int i=0;   i<self.model.Subject.count; i++) {
            //NSLog(@"inside CourseList.m delegate's search subject loop");
            NSLog(@"in CourseList.m delegate's search subject loop, NSDictionary value is %@",[d valueForKey:@"SubjectCode"]);
            
            //NSLog(@"in CourseList.m delegate, SubjectCode value is %@", [self.model.gradedworks objectAtIndex: i]);
            
            NSLog(@"in CourseList.m delegate's search subject loop, Subject [i] value is %@",[[self.model.Subject objectAtIndex: i] valueForKey:@"Code"]);
            
            
            if ([[[self.model.Subject objectAtIndex: i] valueForKey:@"Code"] isEqualToString:[d valueForKey:@"SubjectCode"]])  {
                [self.model addNewSubject:[[self.model.Subject objectAtIndex: i] valueForKey:@"Code"]
                            inDescription:[[self.model.Subject objectAtIndex: i] valueForKey:@"Description"]
                              inSubjectId:[[[self.model.Subject objectAtIndex: i] valueForKey:@"Id"] intValue]
                                   inName:[[self.model.Subject objectAtIndex: i] valueForKey:@"Name"]
                             inOutLineURL:[[self.model.Subject objectAtIndex: i] valueForKey:@"OutlineUrl"]];
                //NSLog(@"in CourseList.m delegate's addNewSubject, SubjectCode value is %@",[addedSubject valueForKey:@"code"]);
            }
            
        }
        
        [self.model saveChanges];
        
        NSLog(@"after CourseList.m delegate's add subject loop");
        
        
         //for(NSString *s in self.model.Semester){
         for (int i=0;   i<self.model.Semester.count; i++) {
         NSLog(@"first line, inside CourseList.m delegate's add semester loop");
         if ([[[self.model.Semester objectAtIndex: i] valueForKey:@"SemesterNumber"] isEqualToString:@"1" ]) {  temp=[NSString stringWithFormat:@"Spring "];  }
         
         NSLog(@"inside CourseList.m delegate's add semester loop");
         
         if ([[[self.model.Semester objectAtIndex: i] valueForKey:@"SemesterNumber"] isEqualToString:@"2" ]) temp=@"Summer ";
         if ([[[self.model.Semester objectAtIndex: i] valueForKey:@"SemesterNumber"] isEqualToString:@"3" ]) temp=@"Fall ";
         if ([[[self.model.Semester objectAtIndex: i] valueForKey:@"SemesterNumber"] isEqualToString:@"4" ]) temp=@"Winter ";
         
         
         
         temp=[NSString stringWithFormat:@"\"%@%@\"", temp,[[self.model.Semester objectAtIndex: i] valueForKey:@"Year"] ];
         
         
         if ([temp isEqualToString:[d valueForKey:@"SemesterName"]]){
         [self.model addNewSemester:temp
         inString:temp
         inSemesterId:[[[self.model.Semester objectAtIndex: i] valueForKey:@"Id"] intValue]
         inSemesterNum:[[[self.model.Semester objectAtIndex: i] valueForKey:@"SemesterNumber"] intValue]
         inYear:[[[self.model.Semester objectAtIndex: i]
         valueForKey:@"Year"] intValue]    ];
         }
         
         
         }       
        
        NSLog(@"after CourseList.m delegate's add semester loop");
        
        for(NSDictionary *s in self.model.Employee){
            
            
            if ([[s valueForKey:@"FullName"] isEqualToString:[d valueForKey:@"EmployeeName"]]){
                //temp=[NSString stringWithFormat:@"%@%@", temp,[s valueForKey:@"Year"] ];
                
                
                //if ([temp isEqualToString:[d valueForKey:@"SemesterName"]]){
                [self.model addNewEmployee:[s valueForKey:@"FullName"]
                                 inWebSite:[s valueForKey:@"WebSite"]
                              inEmployeeId:[[s valueForKey:@"Id"] intValue]   ];
                
            }
        }
        
        [self.model saveChanges];
        
        NSLog(@"before CourseList.m delegate's addNewCourse,course subject code is %@",[d valueForKey:@"SubjectCode"]);
        
        
        
        if (![self.model courseExists:[NSNumber numberWithInt:[[d valueForKey:@"Id"] intValue]]]) {
            [self.model addNewCourse:[d valueForKey:@"Day1"]
                              inDay2: [d valueForKey:@"Day2"]
                         inDuration1:[[d valueForKey:@"Duration1"] intValue]
                         inDuration2:[[d valueForKey:@"Duration1"] intValue]
                          inCourseId:[[d valueForKey:@"Id"] intValue]
                             inRoom2:[d valueForKey:@"Room1"]
                             inRoom2:[d valueForKey:@"Room2"]
                           inSection:[d valueForKey:@"Section"]
                       inStartPeriod:[[d valueForKey:@"StartPeriod1"] intValue]
                      inStartPeriod2:[[d valueForKey:@"StartPeriod2"] intValue]
                      forSubjectCode: [d valueForKey:@"SubjectCode"]
                     forEmployeeName: [d valueForKey:@"EmployeeName"]
                     forSemesterName: [d valueForKey:@"SemesterName"]   ];
        }
        
         for(NSString *s in self.model.Subject){
         
         
         if ([[s valueForKey:@"Code"] isEqualToString:[d valueForKey:@"SubjectCode"]]){
         
         [self.model addNewSubject:[s valueForKey:@"Code"]
         inDescription:[s valueForKey:@"Description"]
         inSubjectId:[[s valueForKey:@"Id"] intValue]
         inName:[s valueForKey:@"Name"]
         inOutLineURL:[s valueForKey:@"OutlineUrl"]      ];
         
         
         }
         }  
        
        [self.model saveChanges];
        
        [self.tableView reloadData];
        
        NSLog(@"after CourseList.m delegate's addNewCourse");  //, course number is %@",self.model.frc_gradedworks.count);
        
        // self.model.temp = d;
        
        
        
    }
    // Dismiss the modal view controller
    [self dismissModalViewControllerAnimated:YES];
    
}   */


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    //[self viewDidLoad];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [self viewDidLoad];
    //[self.tableView reloadData];
    
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

/*
// UITableViewDataSource method
// Purpose - delete an object from the (Core Data) store
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //if (editingStyle == UITableViewCellEditingStyleDelete)
    //for (int i=0;i<[self.model.frc_courses   //count];i++)
    {
        // Delete the object from the Core Data store
        (void)[self.model gradedworkDelete:[self.model.frc_gradedworks objectAtIndexPath:indexPath]];
    }
}  */



- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject

       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type

      newIndexPath:(NSIndexPath *)newIndexPath {
    
    
    
    UITableView *tableView = self.tableView;
    
    
    
    switch(type) {
            
            
            
        case NSFetchedResultsChangeInsert:
            
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
             
                             withRowAnimation:UITableViewRowAnimationFade];
            
            break;
            
            
            
        case NSFetchedResultsChangeDelete:
            
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
             
                             withRowAnimation:UITableViewRowAnimationFade];
            
            break;
            
            
            /*
        case NSFetchedResultsChangeUpdate:
            
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath]
             
                    atIndexPath:indexPath];
            
            break;  */
            
            
            
        case NSFetchedResultsChangeMove:
            
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
             
                             withRowAnimation:UITableViewRowAnimationFade];
            
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
             
                             withRowAnimation:UITableViewRowAnimationFade];
            
            break;
            
    }
    
}


@end




