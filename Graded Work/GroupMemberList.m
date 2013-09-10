//
//  GroupMemberList.m
//  Graded Work
//
//  Created by  on 12/6/12.
//
//

#import "GroupMemberList.h"
#import "AFNetworking.h"
#import "ICTClient.h"
#import "ContactInfo.h"
#import "Model.h"


@interface GroupMemberList ()

@end

@implementation GroupMemberList



@synthesize model = _model;
@synthesize ro = _ro;


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
    
    
    //[self.tableView reloadData];
    //NSLog(@"\n& & & in courseList.m,in the beginning of  viewDidLoad method& & & ");
    //NSLog(@"\n& & & in groupmemberList.m,in the beginning  of  viewDidLoad method,contact count is %d& & & ",self.model.contact.count);
    // Configure the row height
	//self.tableView.rowHeight = 55.0f;
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // Configure and load the fetched results controller
    //self.model.frc_contacts.delegate = self;
    //self.tableView.dataSource = self;
    //self.model.frc_courses.fetchRequest.predicate = nil;
    [self.model.frc_contacts.fetchRequest setPredicate:nil];  //[NSPredicate predicateWithFormat:@"(gradedwork.courseInfo == %@) AND (gradedwork.title == %@)",[self.ro valueForKey:@"courseInfo"],[self.ro valueForKey:@"title"]]];
    //@"Course.showGradedWork == YES"]] ;  //], self.ro]];
    
    
    //[self.model.frc_contacts.fetchRequest setPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"gradedwork == %@", self.ro]]];
    
    [NSFetchedResultsController deleteCacheWithName:@"GroupMember"];
    
    NSError *error = nil;
    [self.model.frc_contacts performFetch:&error];
    
	
    // Register for a notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUI:) name:@"MediaLoadedSuccessfully" object:nil];
    NSString *temp = @"good";  //[self.model showText:@"hi"];
    NSLog(@"=====IN Groupmemberlist.m viewdidload method,my string is %@",temp);
    
    
    
    //_groupmembers =  [self.model fetchDataForEntityNamed:@"GroupMember" withPredicateFormat:[NSString stringWithFormat:@"(gradedwork.courseInfo == %@) AND (gradedwork.title == %@)",[self.ro valueForKey:@"courseInfo"],[self.ro valueForKey:@"title"]] predicateObject:nil sortDescriptors:nil];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //NSLog(@"\n* * *in groupmemberList.m, at the end of  viewDidLoad method,contact count is  %d* * * ",self.model.Contact.count);
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

// UITableViewDelegate method
// Purpose - disable "swipe-to-delete" feature
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (self.editing) ? UITableViewCellEditingStyleDelete : UITableViewCellEditingStyleNone;
}

// UITableViewDataSource method
// Purpose - delete an object from the (Core Data) store
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the object from the Core Data store
        (void)[self.model contactDelete:[self.model.frc_contacts objectAtIndexPath:indexPath]];
    }
     else if (editingStyle == UITableViewCellEditingStyleInsert) {
         
     }
}


- (void)addItem:(id)sender
{
    // Get a reference to the "add" controller
    //UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"AddContactTask"];  //<=================
    //CourseEdit *vc = (CourseEdit *)nav.topViewController;   //<=================
    // Configure it
    //vc.model = self.model;     //<=================
    //vc.delegate = self;       //<=================
    
    // Present it, modally
    //[self.navigationController presentModalViewController:nav animated:YES];
    
    //Create an instance of the “people picker” controller
    ABPeoplePickerNavigationController *vc = [[ABPeoplePickerNavigationController alloc] init];
    
    //Configure the delegate property
    vc.peoplePickerDelegate = self;
    
    //Show the “people picker” modally
    [self presentModalViewController:vc animated:YES];
}   


// NSFetchedResultsControllerDelegate method
// Purpose - start "bracket" for table view changes
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self viewDidLoad];  //added later
    [self.tableView beginUpdates];
}

// NSFetchedResultsControllerDelegate method
// Purpose - smoothly (i.e. with animation) handles individual row changes in a table view
// Nicely handles one-row-at-a-time changes
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    // Perform the insert or delete, with animation
    switch (type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

// NSFetchedResultsControllerDelegate method
// Purpose - end "bracket" for table view changes
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self viewDidLoad];
    [self.tableView reloadData];  //<==RECENLTY ADDED
    [self.tableView endUpdates];
}

- (void)updateUI:(NSNotification *)notification
{
    // This method is called when there's new/updated data from the network
    [self.tableView reloadData];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if (editing)
    {
        // The "Edit button was tapped, so we create an "Add" (+) button on the left side
        UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
        
        
        
        [self.navigationItem setLeftBarButtonItem:addButton animated:YES];
    }
    else
    {
		// The "Done" button was tapped, so we remove the add button from the left side
		[self.navigationItem setLeftBarButtonItem:nil animated:YES];
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    //return 1;
    return [[self.model.frc_contacts sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //[self.tableView reloadData];
    // Return the number of rows in the section.
    //return self.model.courses.count;
    //[self viewDidLoad];
    [self.tableView reloadData];  //<==Added recently
    [self viewDidLoad];
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.model.frc_contacts sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //static NSString *CellIdentifier = @"Cell";
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    // Fetch the dictionary
    //id d = [self.model.frc_courses objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
    
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
    
    //[self viewDidLoad];
    //[self.tableView reloadData];
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSLog(@"\n=======in groupmemberList.m, at the beginning of cellForRowAtIndexPath method=======");
    
    // NSDictionary *d = [self.model.Courses objectAtIndex:1];
    //NSLog(@"%@",[self.model.Courses objectAtIndex:0]);
    
    
    
    if ([[self.model.frc_contacts sections] count] == 0)
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
        
        
        //NSManagedObject *d1 = [self.groupmembers objectAtIndex:indexPath.row];
        NSManagedObject *d1 = [self.model.frc_contacts objectAtIndexPath:indexPath];
        //NSManagedObject *d1 = [self.model.frc_courses objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        //NSManagedObject *d2 = [self.model.frc_semesters objectAtIndexPath:indexPath];
        //NSManagedObject *d3 = [self.model.frc_employees objectAtIndexPath:indexPath];
        
         NSLog(@"\n=1=1=1=1=1=1=in groupmemberList.m, in if statement of cellForRowAtIndexPath method,displayName is %@",[d1 valueForKey:@"displayName"]);
        
        cell.textLabel.text = [d1 valueForKey:@"displayName"];
        
        
        
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
    
    NSLog(@"\n~~~~~~~~~in groupmemberList.m, at the end of cellForRowAtIndexPath method~~~~~~~~");
    
    return cell;
}

/*
 - (void) fetchGradedWork:(id)course {
 //add new gradedworks for this specific course (subjectcode + section)
 NSString *temp = [NSString stringWithFormat:@"%@ %@",[course valueForKey:@"SubjectCode"],[course valueForKey:@"Section"]];
 
 NSLog(@"-------in courselist.m fetchGradedWork:course method, before for loop,temp is:%@",temp);
 
 //for(NSDictionary *s in self.Gradedwork){
 for (int i=0;   i<self.model.Gradedwork.count; i++)  {
 
 NSLog(@"+++++++inside for loop, courseinfo value is:%@, i is %d", [[self.model.Gradedwork objectAtIndex: i] valueForKey:@"CourseInfo"],i);
 
 if ([[[self.model.Gradedwork objectAtIndex: i] valueForKey:@"CourseInfo"] isEqualToString:temp]){
 //temp=[NSString stringWithFormat:@"%@%@", temp,[s valueForKey:@"Year"] ];
 
 //NSLog(@"+++++++iscurrent value is: %@", [[self.Gradedwork objectAtIndex: i] valueForKey:@"IsCurrent"]);
 
 
 //if ([temp isEqualToString:[d valueForKey:@"SemesterName"]]){
 NSManagedObject *new = [self.model addNewGradedwork:[[[self.model.Gradedwork objectAtIndex: i] valueForKey:@"Id"] intValue]
 withTitle:[[self.model.Gradedwork objectAtIndex: i] valueForKey:@"Title"]
 inCategory:[[self.model.Gradedwork objectAtIndex: i] valueForKey:@"Category"]
 withDescription:[[self.model.Gradedwork objectAtIndex: i] valueForKey:@"Description"]
 withMoreInfoUrl:[[self.model.Gradedwork objectAtIndex: i] valueForKey:@"MoreInfoUrl"]
 withValue:[[self.model.Gradedwork objectAtIndex: i] valueForKey:@"Value"]
 onDateCreated:[[self.model.Gradedwork objectAtIndex: i] valueForKey:@"DateCreated"]
 onDateAssigned:[[self.model.Gradedwork objectAtIndex: i] valueForKey:@"DateAssigned"]
 onDateDue:[[self.model.Gradedwork objectAtIndex: i] valueForKey:@"DateDue"]
 withTimeDuration:[[[self.model.Gradedwork objectAtIndex: i] valueForKey:@"Duration"] intValue]
 withCourseInfo:[[self.model.Gradedwork objectAtIndex: i] valueForKey:@"CourseInfo"]
 withRowVersion:[[[self.model.Gradedwork objectAtIndex: i] valueForKey:@"RowVersion"] intValue]  ];
 // withIsCurrent:[[self.Gradedwork objectAtIndex: i] valueForKey:@"IsCurrent"]   ];
 
 [self.model saveChanges];
 
 
 NSLog(@"=========in model.m fetchGradedWork:course method, new added gradedwork's description is %@", [new description]);
 
 }
 }
 
 [self.model saveChanges];
 
 }     */



 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 

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
 }  */
 


 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 


 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 

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
    
    NSManagedObject *b = [self.model.frc_contacts objectAtIndexPath:indexPath];
    
    //First, get a reference to the device’s Address Book store
    ABAddressBookRef addressBook = ABAddressBookCreate();
    
    //Then, get a reference to the contact, using the contact’s unique identifier (that we saved in the device’s Core Data store when we created a group member object; you must cast that to an int)
    ABRecordRef contact = ABAddressBookGetPersonWithRecordID(addressBook,(int)[b valueForKey:@"abRecordId"]);
    
    //Then, create an instance of the “person” controller
    ABPersonViewController *vc = [[ABPersonViewController alloc] init];
    
    //Next, configure it, using the “contact” object that was just fetched
    vc.personViewDelegate = self;
    vc.displayedPerson = contact;
    
    //Finally, present the controller
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /*
    // Navigation push
    if ([segue.identifier isEqualToString:@"toCourseView"])
    {
        // Fetch the selected object
        NSManagedObject *o = [self.model.frc_courses objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        //Configure the next VC
        CourseView *nextVC = (CourseView *)segue.destinationViewController;
        NSLog(@"in CourseList.m segue to course view, subject code value is %@",[o valueForKey:@"subjectCode"]);
        nextVC.title = [o valueForKey:@"subjectCode"];
        nextVC.model = self.model;
        
        nextVC.ro= o;
    }   */
    
    
    if ([segue.identifier isEqualToString:@"toContactInfo"])
    {
        //NSManagedObject *b = [self.model.frc_contacts objectAtIndexPath:indexPath];

        
        ///////////////
        
        // Fetch the selected object
        NSManagedObject *o = [self.model.frc_contacts objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        
        
        //First, get a reference to the device’s Address Book store
        ABAddressBookRef addressBook = ABAddressBookCreate();
        
        //Then, get a reference to the contact, using the contact’s unique identifier (that we saved in the device’s Core Data store when we created a group member object; you must cast that to an int)
        ABRecordRef contact = ABAddressBookGetPersonWithRecordID(addressBook,(int)[o valueForKey:@"abRecordId"]);
        
        
        //UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        //NSManagedObject *so = [self.model.frc_courses objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        //CourseEdit *nextVC = (CourseEdit *)nav.topViewController;
        ContactInfo *nextVC = (ContactInfo *)segue.destinationViewController;
        
        //nextVC.model = self.model;
        //nextVC.delegate = self;
        nextVC.ro = o;  //self.ro;
        nextVC.contact = (__bridge id)(contact);
    }  
}

/*

#pragma mark - Delegate methods

- (void)EditGroupMemberController:(id)controller didEditItem:(id)item
{
    //NSString *temp;
    //id addedSubject,addedSemester,addedEmployee;
    // Add a new object to the store, only if an object was passed in
    if (item) {
        NSDictionary *d = (NSDictionary *)item;
        
        NSLog(@"in groupmemberList.m delegate");  //, SubjectCode value is %@",[d valueForKey:@"SubjectCode"]);
        
        /*
         //for(NSString *s in self.model.Subject){
         for (int i=0;   i<self.model.Subject.count; i++) {
         //NSLog(@"inside CourseList.m delegate's search subject loop");
         NSLog(@"in CourseList.m delegate's search subject loop, NSDictionary value is %@",[d valueForKey:@"SubjectCode"]);
         
         //NSLog(@"in CourseList.m delegate, SubjectCode value is %@", [self.model.Courses objectAtIndex: i]);
         
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
        
        NSLog(@"before groupmemberList.m delegate's addNewGroupMember");  //,course subject code is %@",[d valueForKey:@"SubjectCode"]);
        
        
        
        if (![self.model courseExists:[NSNumber numberWithInt:[[d valueForKey:@"Id"] intValue]]]) {
            //NSManagedObject *new =
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
                     forSemesterName: [d valueForKey:@"SemesterName"]
             
             ];
            
            //[self fetchGradedWork:new];
        }
        
        
        /*
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
        
        /*
         //add new gradedworks for this specific course (subjectcode + section)
         NSString *temp = [NSString stringWithFormat:@"%@ %@",[d valueForKey:@"SubjectCode"],[d valueForKey:@"Section"]];
         
         for(NSDictionary *s in self.model.Gradedwork){
         
         
         if ([[s valueForKey:@"CourseInfo"] isEqualToString:temp]){
         //temp=[NSString stringWithFormat:@"%@%@", temp,[s valueForKey:@"Year"] ];
         
         
         //if ([temp isEqualToString:[d valueForKey:@"SemesterName"]]){
         NSManagedObject *new = [self.model addNewGradedwork:[s valueForKey:@"Id"]
         withTitle:[s valueForKey:@"Title"]
         inCategory:[s valueForKey:@"Category"]
         withDescription:[s valueForKey:@"Description"]
         withMoreInfoUrl:[s valueForKey:@"MoreInfoUrl"]
         withValue:[s valueForKey:@"Value"]
         onDateCreated:[s valueForKey:@"DateCreated"]
         onDateAssigned:[s valueForKey:@"DateAssigned"]
         onDateDue:[s valueForKey:@"DateDue"]
         withTimeDuration:[s valueForKey:@"Duration"]
         withCourseInfo:[s valueForKey:@"CourseInfo"]
         withRowVersion:[s valueForKey:@"RowVersion"]
         withIsCurrent:[s valueForKey:@"IsCurrent"]   ];
         
         [self.model saveChanges];
         
         
         NSLog(@"\n%@", [new description]);
         
         }
         }    
        
        [self.model saveChanges];
        
        
        
        [self.tableView reloadData];
        
        NSLog(@"after CourseList.m delegate's addNewCourse");  //, course number is %@",self.model.frc_courses.count);
        
        // self.model.temp = d;
        
        
        
    }
    // Dismiss the modal view controller
    [self dismissModalViewControllerAnimated:YES];
    
}        */

/*
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
 [self viewDidLoad];
 [self.tableView reloadData];
 }    */

- (BOOL) peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker  shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    
    //extract the property values from the selected contact, using the address book functions
    NSString *displayName = (__bridge NSString *)ABRecordCopyCompositeName(person);
    //NSNumber
    NSNumber *abRecordId = [NSNumber numberWithInt:ABRecordGetRecordID(person)];
    
    //Next, create a dictionary, with the displayName and abRecordId values.
    //NSDictionary *d = [[NSDictionary alloc] initWithObjectsAndKeys:
     //                  displayName, @"displayName",
     //                  abRecordId, @"abRecordId",
      //                 nil]; //nil to signify end of objects and keys.
    NSLog(@"\n..........in groupmemberlist.m peoplePickerNavigationController:shouldcontinureafterselectingperson method,before addnewgroupmember method...............");
    
    NSLog(@"\n************in groupmemberlist.m, ro is %@",[self.ro description]);
    
    //Pass it – and the graded work object – to the Model class method that enables you to create a new group member object.
    //[self.model addNewGroupMember:abRecordId
    //                     withName:displayName
    //                 toGradedWork:self.ro];
    
      NSLog(@"\n=***===***===***in groupmemberlist.m peoplePickerNavigationController:shouldcontinureafterselectingperson method,displayName is %@,abRecordId is %@==========",displayName,abRecordId);
    
    [self.model showText:@"hi"];
    
    [self.model addNewGroupMemberWithoutGradedWorkObject:abRecordId
                                                withName:displayName];
    
       NSArray *mymemberlist = [self.model fetchDataForEntityNamed:@"GroupMember" withPredicateFormat:nil predicateObject:nil sortDescriptors:nil];
    
       NSLog(@"\n=$$$$$$===$$$===in groupmemberlist.m peoplePickerNavigationController:shouldcontinureafterselectingperson method,group member is %@",mymemberlist);
    
        NSLog(@"\n==========in groupmemberlist.m peoplePickerNavigationController:shouldcontinureafterselectingperson method,after addnewgroupmember method==========");
    
    [self.model saveChanges];
    
    [self viewDidLoad];
    
    [self.tableView reloadData];
    
    // Dismiss the modal view controller
    [self dismissModalViewControllerAnimated:YES];
    
    return YES;
}

- (void) peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
     [self dismissModalViewControllerAnimated:YES];
    
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
     [peoplePicker dismissModalViewControllerAnimated:YES];
    return YES;
    
    
}

- (BOOL) personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    return NO;
}




- (void)viewWillAppear:(BOOL)animated {
    [self viewDidLoad];
    //[self.tableView reloadData];
    
    [super viewWillAppear:animated];
    
    NSError *error = nil;
    //[resultsController performFetch:&error]; // Refetch data
    [self.model.frc_contacts performFetch:&error];
    if (error != nil) {
        // handle error
        NSLog(@"in groupmemberlist.m viewwillappear method,there is error");
    }
    
    [self.tableView reloadData];
}


@end
