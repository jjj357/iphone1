//
//  Model.m
//  CD Simple
//
//  Created by Peter McIntyre on 2012/06/22.
//  Copyright (c) 2012 Seneca College. All rights reserved.
//

#import "Model.h"
#import "CDStack.h"
#import "DataCreator.h"
#import "WebService.h"
#import "courses.h"
#import "gradedworks.h"
#import "AFNetworking.h"
#import "Utilities.h"
#import "ICTClient.h"
//#import "Utilities.h"
//#import "NSFetchedResultsController.h"

@interface Model ()
{
    // Core Data stack
    CDStack *_cdStack;
    
    // Results search string
    NSString *_resultsSearchUrl;
}

- (NSURL *)applicationDocumentsDirectory;

@end

@implementation Model

@synthesize frc_event = _frc_event;
@synthesize frc_courses = _frc_courses;
@synthesize frc_subjects = _frc_subjects;
@synthesize frc_employees =_frc_employees;
@synthesize frc_semesters =_frc_semesters;
@synthesize frc_gradedworks = _frc_gradedworks;
@synthesize frc_gradedworks_sortbydate = _frc_gradedworks_sortbydate;
@synthesize frc_gradedworks_sortbycourse = _frc_gradedworks_sortbycourse;
@synthesize frc_gradedworks_sortbyvalue = _frc_gradedworks_sortbyvalue;
@synthesize Courses=_Courses;
@synthesize Subject=_Subject;
@synthesize Semester=_Semester;
@synthesize Employee=_Employee;
@synthesize Gradedwork = _Gradedwork;
@synthesize dayIdToDayName=_dayIdToDayName;
@synthesize weekDayName=_weekDayName;
//@synthesize temp=_temp;

#pragma mark - Object lifecycle

- (id)init
{
    self = [super init];
    if (self) 
    {
        // Is this the app's first launch? (object store file does not exist) 
        // If yes, then does the app include starter data (will be in the app bundle) 
        // If yes, then copy the store file from the bundle to the Documents directory
        // Otherwise, will have to create some new data (after the stack is initialized)
        
        // URL to the object store file in the app bundle
        NSURL *storeFileInBundle = [[NSBundle mainBundle] URLForResource:@"ObjectStore" withExtension:@"sqlite"];
        
        // URL to the object store file in the Documents directory
        NSURL *storeFileInDocumentsDirectory = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ObjectStore.sqlite"];
        
        // System file manager
        NSFileManager *fm = [[NSFileManager alloc] init];
        
        // Check whether this is the first launch of the app
        BOOL isFirstLaunch = ![fm fileExistsAtPath:[storeFileInDocumentsDirectory path]];
        
        // Check whether the app is supplied with starter data in the app bundle
        BOOL hasStarterData = [fm fileExistsAtPath:[storeFileInBundle path]];
        
        if (isFirstLaunch)
        {
            if (hasStarterData)
            {
                // Use the supplied starter data
                [fm copyItemAtURL:storeFileInBundle toURL:storeFileInDocumentsDirectory error:nil];
                // Create a Core Data stack object after copying file
                _cdStack = [[CDStack alloc] init];
            }
            else
            {
                // Create a Core Data stack object before creating new data
                _cdStack = [[CDStack alloc] init];
                // Create some new data
                [DataCreator create:self];
            }
        }
        else
        {
            _cdStack = [[CDStack alloc] init];
        }
    }
    return self;
}

#pragma mark - Network fetched results

- (NSArray *)Courses
{
    
    //NSLog(@"\n- - - in model.m  -(NSArray *)Courses method- - - ");
        //NSLog(@"\n& & &in the beginning  of  -Courses method,course count is %u,gradedwork count is %d& & & ",self.Courses.count,self.Gradedwork.count);
    
    // If we have the data, return it
    if (_Courses) return _Courses;
    
    // Otherwise, fetch the data
    _Courses = [[NSArray alloc] init];
    
    // Search string alternatives...
    
    NSString *search = nil;
    search = @"http://dps913fall2012.azurewebsites.net/api/courses";
    
    // Create and configure a request object
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:search]];
    
    // Create and configure an AFNetworking JSON request operation
    // Notice that the initializer uses "blocks" for the success and failure arguments
    
	// Reference the app's network activity indicator in the status bar
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
     {
         _Courses = [JSON allObjects];
         
         // Then, post a notification, so that a controller object can request the results
         [[NSNotificationCenter defaultCenter] postNotificationName:@"MediaLoadedSuccessfully" object:nil];
         
         // Reference the app's network activity indicator in the status bar
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
     }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
     {
         NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
         // Reference the app's network activity indicator in the status bar
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
     }
     ];
    
    // Start the operation
    [operation start];
    
     [self saveChanges];
    
    
    return _Courses;

}
- (NSArray *)Subject
{
    //NSLog(@"\n= = = in model.m  -(NSArray *)Subject method= = = ");
          //  NSLog(@"\n& & &in the beginning  of  -Subject method,course count is %u,gradedwork count is %u& & & ",self.Courses.count,self.Gradedwork.count);
    
    // If we have the data, return it
    if (_Subject) return _Subject;
    
    // Otherwise, fetch the data
    _Subject = [[NSArray alloc] init];
    
    // Search string alternatives...
    
    NSString *search = nil;
    search = @"http://dps913fall2012.azurewebsites.net/api/subjects";
    
    // Create and configure a request object
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:search]];
    
    // Create and configure an AFNetworking JSON request operation
    // Notice that the initializer uses "blocks" for the success and failure arguments
    
	// Reference the app's network activity indicator in the status bar
	//[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
     {
         _Subject = [JSON allObjects];
         //[DataCreator create:self];
         //NSLog(@"%@",[[_Subject objectAtIndex:0] description]);
         // Then, post a notification, so that a controller object can request the results
         [[NSNotificationCenter defaultCenter] postNotificationName:@"MediaLoadedSuccessfully" object:nil];
         
         // Reference the app's network activity indicator in the status bar
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
     }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
     {
         NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
         // Reference the app's network activity indicator in the status bar
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
     }
     ];
    
    // Start the operation
    [operation start];
    
     [self saveChanges];
    
    
    return _Subject;
    
}
- (NSArray *)Employee
{
    
    //NSLog(@"\n! ! ! !  in model.m  -(NSArray *)Employee method! ! ! ! ");
    //NSLog(@"\n& & &in the beginning  of  -Employee method,course count is %u,gradedwork count is %u& & & ",self.Courses.count,self.Gradedwork.count);
    
    // If we have the data, return it
    if (_Employee) return _Employee;
    
    // Otherwise, fetch the data
    _Employee = [[NSArray alloc] init];
    
    // Search string alternatives...
    
    NSString *search = nil;
    search = @"http://dps913fall2012.azurewebsites.net/api/employees";
    
    // Create and configure a request object
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:search]];
    
    // Create and configure an AFNetworking JSON request operation
    // Notice that the initializer uses "blocks" for the success and failure arguments
    
	// Reference the app's network activity indicator in the status bar
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
     {
         _Employee = [JSON allObjects];
         
         // Then, post a notification, so that a controller object can request the results
         [[NSNotificationCenter defaultCenter] postNotificationName:@"MediaLoadedSuccessfully" object:nil];
         
         // Reference the app's network activity indicator in the status bar
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
     }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
     {
         NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
         // Reference the app's network activity indicator in the status bar
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
     }
     ];
    
    // Start the operation
    [operation start];
    
     [self saveChanges];
    
    
    return _Employee;
    
}

- (NSArray *)Semester
{
    //NSLog(@"\n@ @ @ @  in model.m  -(NSArray *)Semester method@ @ @ @ ");
    //NSLog(@"\n& & &in the beginning  of  -Semester method,course count is %u,gradedwork count is %u& & & ",self.Courses.count,self.Gradedwork.count);
    
    
    // If we have the data, return it
    if (_Semester) return _Semester;
    
    // Otherwise, fetch the data
    _Semester = [[NSArray alloc] init];
    
    // Search string alternatives...
    
    NSString *search = nil;
    search = @"http://dps913fall2012.azurewebsites.net/api/semesters";
    
    // Create and configure a request object
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:search]];
    
    // Create and configure an AFNetworking JSON request operation
    // Notice that the initializer uses "blocks" for the success and failure arguments
    
	// Reference the app's network activity indicator in the status bar
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
     {
         _Semester = [JSON allObjects];
         
         // Then, post a notification, so that a controller object can request the results
         [[NSNotificationCenter defaultCenter] postNotificationName:@"MediaLoadedSuccessfully" object:nil];
         
         // Reference the app's network activity indicator in the status bar
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
     }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
     {
         NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
         // Reference the app's network activity indicator in the status bar
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
     }
     ];
    
    // Start the operation
    [operation start];
    
     [self saveChanges];
    
    
    return _Semester;
    
}

- (NSArray *)Gradedwork
{
    
    //NSLog(@"\n$ $ $ $  in model.m  -(NSArray *)Gradedwork method $ $ $ $ ");
    //NSLog(@"\n& & &in the beginning  of  -Gradedwork method,course count is %u,gradedwork count is %u& & & ",self.Courses.count,self.Gradedwork.count);
    
    // If we have the data, return it
    if (_Gradedwork) return _Gradedwork;
    
    // Otherwise, fetch the data
    _Gradedwork = [[NSArray alloc] init];
    
    // Search string alternatives...
    
    NSString *search = nil;
    search = @"http://dps913fall2012.azurewebsites.net/api/gradedworks";
    
    // Create and configure a request object
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:search]];
    
    // Create and configure an AFNetworking JSON request operation
    // Notice that the initializer uses "blocks" for the success and failure arguments
    
	// Reference the app's network activity indicator in the status bar
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON)
     {
         _Gradedwork = [JSON allObjects];
         
         // Then, post a notification, so that a controller object can request the results
         [[NSNotificationCenter defaultCenter] postNotificationName:@"MediaLoadedSuccessfully" object:nil];
         
         // Reference the app's network activity indicator in the status bar
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
     }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
     {
         NSLog(@"Request Failed with Error: %@, %@", error, error.userInfo);
         // Reference the app's network activity indicator in the status bar
         [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
     }
     ];
    
    // Start the operation
    [operation start];
    
     [self saveChanges];
    
    
    return _Gradedwork;
    
    /*
    // If the data exists, just return it
    if (_Gradedwork) return _Gradedwork;
    
    // Otherwise, go fetch the data...
    
    // Reference the app's network activity indicator in the status bar
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    // Send a message to the singleton AFHTTPClient subclass, "ClientRatings"
    
    [[ICTClient sharedInstance] getPath:@"gradedworks" parameters:nil
                                    success:^(AFHTTPRequestOperation *operation, id response) {
                                        //NSLog(@"Response: %@", response);
                                        
                                        // This block is executed if the request is successful
                                        // We will go through the "response", and build an array
                                        // of "Rating" objects
                                        NSMutableArray *results = [NSMutableArray array];
                                        for (id gradedworkDictionary in response)
                                        {
                                           gradedworks *gradedworks1 = [[gradedworks alloc] initWithDictionary:gradedworkDictionary];
                                            [results addObject:gradedworks1];
                                        }
                                        
                                        // Assign the results to the property's backing store
                                        _Gradedwork = results;
                                        
                                        // Reference the app's network activity indicator in the status bar
                                        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

                                        // Then, post a notification, so that a controller object can request the results
                                        [[NSNotificationCenter defaultCenter] postNotificationName:@"GetGradedWorksSuccessful" object:nil];
                                        
                                    }
                                    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                        NSLog(@"Error... %@", error);
                                    }];
    return _Gradedwork;
     
     */
    
}

#pragma mark - Managed object maintenance

- (id)addNew:(NSString *)entityName
{
    // Create and return the new managed object
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:_cdStack.managedObjectContext];
}

// New... enables a course to be deleted
- (BOOL)courseDelete:(NSManagedObject *)course
{
    //NSManagedObject *course1 = course;
    NSLog(@"=========in model.m courseDelete:course method, course's description is %@", [course description]);
    [_cdStack.managedObjectContext deleteObject:course];
    [_cdStack saveContext];
       
    [self saveChanges];
    
    return YES;
}

- (BOOL)contactDelete:(NSManagedObject *)contact {
    NSLog(@"$$$$$$$$$$ in model.m contactDelete:contact method, contact's description is %@", [contact description]);
    [_cdStack.managedObjectContext deleteObject:contact];
    [_cdStack saveContext];
    
    [self saveChanges];
    
    return YES;
}

//New... enables a gradedwork to be deleted
- (BOOL)gradedworkDelete:(NSManagedObject *)gradedwork {
    NSLog(@"++++++++++ in model.m gradedworkDelete:gradedwork method, contact's description is %@", [gradedwork description]);
    [_cdStack.managedObjectContext deleteObject:gradedwork];
    [_cdStack saveContext];
    
    [self saveChanges];
    
    return YES;
}


- (NSManagedObject *)getGradedWorkById:(NSString *)gradedworkid {
    //return [_cdStack frcWithEntityNamed:@"GradedWork" withPredicateFormat:[NSString stringWithFormat:@"id == %@", gradedworkid] predicateObject:nil sortDescriptors:@"dateDue,YES" andSectionNameKeyPath:nil];
}  





- (void)saveChanges
{
    [_cdStack saveContext];
}

- (void) fetchGradedWork:(id)course {
    //add new gradedworks for this specific course (subjectcode + section)
    NSString *temp = [NSString stringWithFormat:@"%@ %@",[course valueForKey:@"SubjectCode"],[course valueForKey:@"Section"]];
    
    NSLog(@"-------in model.m fetchGradedWork:course method, before for loop,temp is:%@",temp);
    
    //for(NSDictionary *s in self.Gradedwork){ 
    for (int i=0;   i<self.Gradedwork.count; i++)  {
        
        NSLog(@"+++++++inside Model.m for loop, courseinfo value is:%@, i is %d", [[self.Gradedwork objectAtIndex: i] valueForKey:@"CourseInfo"],i);
        
        if ([[[self.Gradedwork objectAtIndex: i] valueForKey:@"CourseInfo"] isEqualToString:temp]){
            //temp=[NSString stringWithFormat:@"%@%@", temp,[s valueForKey:@"Year"] ];
            
            //NSLog(@"+++++++iscurrent value is: %@", [[self.Gradedwork objectAtIndex: i] valueForKey:@"IsCurrent"]);
            
            NSString *tempTitle = [[self.Gradedwork objectAtIndex: i] valueForKey:@"Title"];
            
            //if ([temp isEqualToString:[d valueForKey:@"SemesterName"]]){
            
            //check if this gradedwork already exists in frc_gradedworks
            if (![self gradedWorkExists:temp withTitle:tempTitle]) {
                
                NSManagedObject *new = [self addNewGradedwork:[[[self.Gradedwork objectAtIndex: i] valueForKey:@"Id"] intValue] 
                                                      withTitle:[[self.Gradedwork objectAtIndex: i] valueForKey:@"Title"]
                                                     inCategory:[[self.Gradedwork objectAtIndex: i] valueForKey:@"Category"]
                                                withDescription:[[self.Gradedwork objectAtIndex: i] valueForKey:@"Description"]
                                                withMoreInfoUrl:[[self.Gradedwork objectAtIndex: i] valueForKey:@"MoreInfoUrl"]
                                                      withValue:[[self.Gradedwork objectAtIndex: i] valueForKey:@"Value"]
                                                  onDateCreated:[[self.Gradedwork objectAtIndex: i] valueForKey:@"DateCreated"]
                                                 onDateAssigned:[[self.Gradedwork objectAtIndex: i] valueForKey:@"DateAssigned"]
                                                      onDateDue:[[self.Gradedwork objectAtIndex: i] valueForKey:@"DateDue"]
                                               withTimeDuration:[[[self.Gradedwork objectAtIndex: i] valueForKey:@"Duration"] intValue]
                                                 withCourseInfo:[[self.Gradedwork objectAtIndex: i] valueForKey:@"CourseInfo"]
                                                 withRowVersion:[[[self.Gradedwork objectAtIndex: i] valueForKey:@"RowVersion"] intValue]
                                        forCourse:course   ];
                
                                                 // withIsCurrent:[[self.Gradedwork objectAtIndex: i] valueForKey:@"IsCurrent"]   ];
            
               [self saveChanges];
            
            
               NSLog(@"=========in model.m fetchGradedWork:course method, new added gradedwork's description is %@", [new description]);
            }
            
        }
    }
    
    [self saveChanges];
    
}

#pragma mark - Fetched results controller - Events


- (NSFetchedResultsController *)frc_courses
{
    // If the frc is already configured, simply return it
    if (_frc_courses) return _frc_courses;
    
    // Otherwise, create a new frc, and set it as the property (and return it below)
    _frc_courses = [_cdStack frcWithEntityNamed:@"Course" withPredicateFormat:nil predicateObject:nil sortDescriptors:@"room1,YES" andSectionNameKeyPath:nil];
    
    return _frc_courses;
}


- (NSFetchedResultsController *)frc_subjects
{
    // If the frc is already configured, simply return it
    if (_frc_subjects) return _frc_subjects;
    
    // Otherwise, create a new frc, and set it as the property (and return it below)
    _frc_subjects = [_cdStack frcWithEntityNamed:@"Subject" withPredicateFormat:nil predicateObject:nil sortDescriptors:@"code,YES" andSectionNameKeyPath:nil];
    
    return _frc_subjects;
}

- (NSFetchedResultsController *)frc_semesters
{
    // If the frc is already configured, simply return it
    if (_frc_semesters) return _frc_semesters;
    
    // Otherwise, create a new frc, and set it as the property (and return it below)
    _frc_semesters = [_cdStack frcWithEntityNamed:@"Semester" withPredicateFormat:nil predicateObject:nil sortDescriptors:@"id,YES" andSectionNameKeyPath:nil];
    
    return _frc_semesters;
}

- (NSFetchedResultsController *)frc_employees

{
    // If the frc is already configured, simply return it
    if (_frc_employees) return _frc_employees;
    
    // Otherwise, create a new frc, and set it as the property (and return it below)
    _frc_employees = [_cdStack frcWithEntityNamed:@"Employee" withPredicateFormat:nil predicateObject:nil sortDescriptors:@"id,YES" andSectionNameKeyPath:nil];
    
    return _frc_employees;
}

- (NSFetchedResultsController *)frc_gradedworks

{
    // If the frc is already configured, simply return it
    if (_frc_gradedworks) return _frc_gradedworks;
    
    // Otherwise, create a new frc, and set it as the property (and return it below)
    _frc_gradedworks = [_cdStack frcWithEntityNamed:@"GradedWork" withPredicateFormat:nil predicateObject:nil sortDescriptors:@"id,YES" andSectionNameKeyPath:nil];
    
    [self saveChanges];
    
    return _frc_gradedworks;
}

- (NSFetchedResultsController *)frc_gradedworks_sortbydate

{
    // If the frc is already configured, simply return it
    if (_frc_gradedworks_sortbydate) return _frc_gradedworks_sortbydate;
    
    // Otherwise, create a new frc, and set it as the property (and return it below)
    _frc_gradedworks_sortbydate = [_cdStack frcWithEntityNamed:@"GradedWork" withPredicateFormat:nil predicateObject:nil sortDescriptors:@"dateDue,YES" andSectionNameKeyPath:nil];
    
    [self saveChanges];
    
    return _frc_gradedworks_sortbydate;
}

- (NSFetchedResultsController *)frc_gradedworks_sortbycourse

{
    // If the frc is already configured, simply return it
    if (_frc_gradedworks_sortbycourse) return _frc_gradedworks_sortbycourse;
    
    // Otherwise, create a new frc, and set it as the property (and return it below)
    _frc_gradedworks_sortbycourse = [_cdStack frcWithEntityNamed:@"GradedWork" withPredicateFormat:nil predicateObject:nil sortDescriptors:@"courseInfo,YES" andSectionNameKeyPath:nil];
    
    [self saveChanges];
    
    return _frc_gradedworks_sortbycourse;
}



- (NSFetchedResultsController *)frc_gradedworks_sortbyvalue

{
    // If the frc is already configured, simply return it
    if (_frc_gradedworks_sortbyvalue) return _frc_gradedworks_sortbyvalue;
    
    // Otherwise, create a new frc, and set it as the property (and return it below)
    _frc_gradedworks_sortbyvalue = [_cdStack frcWithEntityNamed:@"GradedWork" withPredicateFormat:nil predicateObject:nil sortDescriptors:@"value,YES" andSectionNameKeyPath:nil];
    
    [self saveChanges];
    
    return _frc_gradedworks_sortbyvalue;
}

- (NSFetchedResultsController *)frc_contacts

{
    // If the frc is already configured, simply return it
    if (_frc_contacts) return _frc_contacts;
    
    // Otherwise, create a new frc, and set it as the property (and return it below)
    _frc_contacts = [_cdStack frcWithEntityNamed:@"GroupMember" withPredicateFormat:nil predicateObject:nil sortDescriptors:@"abRecordId,YES" andSectionNameKeyPath:nil];
    
    [self saveChanges];
    
    return _frc_contacts;
}


// Convenience method, customized to the entity's design
-  (id)addNewCourse:(NSString *)day1 inDay2:(NSString *)day2 inDuration1:(NSInteger)duration1 inDuration2:(NSInteger)duration2 inCourseId:(NSInteger)courseId inRoom2:(NSString *)room1 inRoom2:(NSString *)room2 inSection:(NSString *)section inStartPeriod:(NSInteger)startPeriod inStartPeriod2:(NSInteger)startPeriod2 forSubjectCode:(NSString *)subjectCode forEmployeeName:(NSString *)employeeName forSemesterName:(NSString *)semesterName
{
    //if (![self courseExists:[NSNumber numberWithInt:courseId]]) {
    
    NSLog(@"\n..........in model.m addnewcourse method...............");
  
    NSManagedObject *p = [self addNew:@"Course"];
    [p setValue:day1 forKey:@"day1"];
    [p setValue:day2 forKey:@"day2"];
    [p setValue:[NSNumber numberWithInt:duration1] forKey:@"duration1"];
    [p setValue:[NSNumber numberWithInt:duration2] forKey:@"duration2"];
    
    [p setValue:[NSNumber numberWithInt:courseId] forKey:@"courseId"];
    
    
    [p setValue:room1 forKey:@"room1"];
    [p setValue:room2 forKey:@"room2"];
    [p setValue:section forKey:@"section"];
    [p setValue:[NSNumber numberWithInt:startPeriod] forKey:@"startPeriod1"];
    [p setValue:[NSNumber numberWithInt:startPeriod2] forKey:@"startPeriod2"];
    [p setValue:subjectCode forKey:@"subjectCode"];
    [p setValue:employeeName forKey:@"employeeName"];
    [p setValue:semesterName forKey:@"semesterName"];
    //[p setValue:@YES forKey:@"showGradedWork"];

    [self saveChanges];

    [self fetchGradedWork:p];
    
    return p;
    
    //return NULL;
}

- (id)addNewGradedwork:(NSInteger)gradedworkId withTitle:(NSString *)gradedworkTitle inCategory:(NSString *)gradedworkCategory withDescription:(NSString *)gradedworkDescription withMoreInfoUrl:(NSString *)gradedworkMoreInfoUrl withValue:(NSDecimalNumber *)gradedworkValue onDateCreated:(NSString *)gradedworkDateCreated onDateAssigned:(NSString *)gradedworkDateAssigned onDateDue:(NSString *)gradedworkDateDue withTimeDuration:(NSInteger)gradedworkDuration withCourseInfo:(NSString *)gradedworkCourseInfo withRowVersion:(NSInteger)gradedworkRowVersion forCourse:(id)course  {    //withIsCurrent:(NSString *)gradedworkIsCurrent    {

    NSLog(@"\n ########## in model.m addnewGradedWork method  ##################");
    
    
    NSManagedObject *p = [self addNew:@"GradedWork"];
    [p setValue:gradedworkCategory forKey:@"category"];
    [p setValue:gradedworkCourseInfo forKey:@"courseInfo"];
    [p setValue:[NSNumber numberWithInt:gradedworkDuration] forKey:@"duration"];
    [p setValue:[NSNumber numberWithInt:gradedworkId] forKey:@"id"];
    [p setValue: [Utilities DateFromYear:gradedworkDateAssigned]  forKey:@"dateAssigned"];
    [p setValue: [Utilities DateFromYear:gradedworkDateCreated] forKey:@"dateCreated"];
    [p setValue: [Utilities DateFromYear
                  :gradedworkDateDue] forKey:@"dateDue"];
    [p setValue:gradedworkDescription forKey:@"gradeDescription"];
 
    
    //[p setValue:gradedworkIsCurrent forKey:@"isCurrent"];
    /*
    
    if ([gradedworkIsCurrent isEqualToString:@"true"]) {
        
    [p setValue:[NSNumber numberWithBool:YES] forKey:@"isCurrent"];
    }
    else if ([gradedworkIsCurrent isEqualToString:@"false"]) {
        
        [p setValue:[NSNumber numberWithBool:NO] forKey:@"isCurrent"];
    }    */
    
    [p setValue:gradedworkMoreInfoUrl forKey:@"moreInfoUrl"];
    [p setValue:gradedworkTitle forKey:@"title"];
    
    //NSString *string = gradedworkValue;
    //NSScanner *scanner = [NSScanner scannerWithString:string];
    //double aNumber;
    //[scanner scanDouble:&aNumber];
    [p setValue:gradedworkValue forKey:@"value"];  
          //[NSDecimalNumber decimalNumberWithString:gradedworkValue] forKey:@"value"];
    
    [p setValue:[NSNumber numberWithInt:gradedworkRowVersion] forKey:@"rowVersion"];   //gradedworkRowVersion forKey:@"rowVersion"];
    [p setValue:course forKey:@"course"];

    return p;



}





- (id)addNewSubject:(NSString *)code  inDescription:(NSString *)desc inSubjectId:(NSInteger)subjectId inName:(NSString *)name inOutLineURL:(NSString *)outlineUrl{
    
    NSManagedObject *p = [self addNew:@"Subject"];
    [p setValue:code forKey:@"code"];
    [p setValue:desc forKey:@"subjectDescription"];
    [p setValue:[NSNumber numberWithInt:subjectId] forKey:@"id"];
    [p setValue:name forKey:@"subjectName"];
    [p setValue:outlineUrl forKey:@"outlineUrl"];
    
    //[self saveChanges];

    return p;

}
- (id)addNewEmployee:(NSString *)fullname  inWebSite:(NSString *)website inEmployeeId:(NSInteger)employeeId{
    
    NSManagedObject *p = [self addNew:@"Employee"];
    [p setValue:fullname forKey:@"fullName"];
    [p setValue:website forKey:@"webSite"];
    [p setValue:[NSNumber numberWithInt:employeeId] forKey:@"id"];
    
    //[self saveChanges];

    
    return p;
    
}
- (id)addNewSemester:(NSString *)semesterName  inString:(NSString *)semesterString inSemesterId:(NSInteger)semesterId inSemesterNum:(NSInteger)semesterNumber inYear:(NSInteger)year{
    
    NSManagedObject *p = [self addNew:@"Semester"];
    [p setValue:semesterName forKey:@"semesterName"];
    [p setValue:semesterString forKey:@"semesterString"];
    [p setValue:[NSNumber numberWithInt:semesterId] forKey:@"id"];
    [p setValue:[NSNumber numberWithInt:semesterNumber] forKey:@"semesterNumber"];
    [p setValue:[NSNumber numberWithInt:year] forKey:@"year"];
    
    //[self saveChanges];
   
    
    return p;
    
}

/*
- (id)addNewContact:(NSString *)name  inCompany:(NSString *)company withPhoneNumber:(NSString *)phoneNumber withEmailAddress:(NSString *)email {
    NSManagedObject *p = [self addNew:@"Contact"];
    [p setValue:name forKey:@"name"];
    [p setValue:company forKey:@"company"];
    [p setValue:phoneNumber forKey:@"phoneNumber"];
    [p setValue:email forKey:@"email"];
    
    [self saveChanges];
    
    
    return p;
}    */



-(id)addNewGroupMember:(NSNumber *)memberId withName:(NSString *)name toGradedWork:(id)gradedwork {
    NSLog(@"--------IN model.m addnewgroupmember method");
    
    NSManagedObject *p = [self addNew:@"GroupMember"];
    [p setValue:memberId forKey:@"abRecordId"];   //[NSNumber numberWithInt:memberId] forKey:@"abRecordId"];
    [p setValue:name forKey:@"displayName"];
    [p setValue:gradedwork forKey:@"gradedwork"];
    
    NSLog(@"IN model.m addnewgroupmember method,added new group member is %@",[p description]);
    //[self saveChanges];
    
    
    return p;
}

-(id)addNewGroupMemberWithoutGradedWorkObject:(NSNumber *)memberId withName:(NSString *)name {
    NSLog(@"**************IN model.m addnewgroupmemberwithoutgradedworkObject method");
    
    NSManagedObject *p = [self addNew:@"GroupMember"];
    [p setValue:memberId forKey:@"abRecordId"];   //[NSNumber numberWithInt:memberId] forKey:@"abRecordId"];
    [p setValue:name forKey:@"displayName"];
    //[p setValue:gradedwork forKey:@"gradedwork"];
    
    NSLog(@"IN model.m addnewgroupmemberwithoutgradedworkObject method,added new group member is %@",[p description]);
    //[self saveChanges];
    
    
    return p;

    
}

- (NSDictionary *)dayIdToDayName {
    if (_dayIdToDayName) return _dayIdToDayName;
    
    _dayIdToDayName = [[NSDictionary alloc] init];
    
    
    _dayIdToDayName = [NSDictionary dictionaryWithObjectsAndKeys:
                       @"8:00am-8:50am" ,@"101",
                       @"8:55am-9:45am" ,@"102",
                       @"9:50am-10:40am" ,@"103",
                       @"10:45am-11:35am" ,@"104",
                       @"11:40am-12:30pm" ,@"105",
                       @"12:35pm-1:25pm" ,@"106",
                       @"1:30pm-2:20pm" ,@"107",
                       @"2:25pm-3:15pm" ,@"108",
                       @"3:20pm-4:10pm" ,@"109",
                       @"4:15pm-5:05pm" ,@"110",
                       @"8:00am-9:45am" ,@"201",
                       @"8:55am-10:40am" ,@"202",
                       @"9:50am-11:35am" ,@"203",
                       @"10:45am-12:30pm" ,@"204",
                       @"11:40am-1:25pm" ,@"205",
                       @"12:35pm-2:20pm" ,@"206",
                       @"1:30pm-3:15pm" ,@"207",
                       @"2:25pm-4:10pm" ,@"208",
                       @"3:20pm-5:05pm" ,@"209",
                       @"4:15pm-6:00pm" ,@"210",
                       @"8:00am-10:40am" ,@"301",
                       @"8:55am-11:35am" ,@"302",
                       @"9:50am-12:30pm" ,@"303",
                       @"10:45am-1:25pm" ,@"304",
                       @"11:40am-2:20pm" ,@"305",
                       @"12:35pm-3:15pm" ,@"306",
                       @"1:30pm-4:10pm" ,@"307",
                       @"2:25pm-5:05pm" ,@"308",
                       @"3:20pm-6:00pm" ,@"309",
                       @"4:15pm-6:55pm" ,@"310",
                       nil
                       ];
    
    return _dayIdToDayName;
    
}

- (NSDictionary *)weekDayName {
    if (_weekDayName) return _weekDayName;
    
    _weekDayName = [[NSDictionary alloc] init];
    
    
    _weekDayName = [NSDictionary dictionaryWithObjectsAndKeys:
                    @"Monday" , @"M",
                    @"Tuesday" , @"T",
                    @"Wednesday" , @"W",
                    @"Thursday" , @"R",
                    @"Friday" , @"F",
                    @"Saturday" , @"S",
                    @"Sunday" , @"U",
                    nil
                    ];
    return _weekDayName;
}

/*
 
 #pragma mark - Fetched results controller (custom getter) creation template
 
 // Use this as a template... copy it, paste it (into your Model class), and then edit it
 - (NSFetchedResultsController *)frc_example
 {
 // If the frc is already configured, simply return it
 if (_frc_example) return _frc_example;
 
 // Otherwise, create a new frc, and set it as the property (and return it below)
 _frc_example = [_cdStack frcWithEntityNamed:@"Example" withPredicateFormat:nil predicateObject:nil sortDescriptors:@"exampleAttribute,YES" andSectionNameKeyPath:nil];
 
 return _frc_example;
 }    
 
 */

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (BOOL) courseExists:(NSNumber *)courseId {
    BOOL result = NO;
    

    
    
    //for(NSString *s in self.model.Subject){
    //for (int i=0;   i<self.Courses.count; i++) {
        //NSLog(@"inside CourseList.m delegate's search subject loop");
        //NSLog(@"in CourseList.m delegate's search subject loop, NSDictionary value is %@",[d valueForKey:@"SubjectCode"]);
        
        //NSLog(@"in CourseList.m delegate, SubjectCode value is %@", [self.model.Courses objectAtIndex: i]);
        
        //NSLog(@"in model.m courseExists method, Course id value is %@",[[self.Courses objectAtIndex: i] valueForKey:@"Id"]);
        
        //NSLog(@"in model.m courseExists method, Course name value is %@",[[self.Courses objectAtIndex: i] valueForKey:@"SubjectCode"]);
        
        
        
    [self.frc_courses.fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"courseId == %@", courseId]];   //[courseId stringValue]]];
        
        [NSFetchedResultsController deleteCacheWithName:@"Course"];
        
        NSError *error = nil;
        [self.frc_courses performFetch:&error];
        /*
        
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Course" inManagedObjectContext:coreDataContext];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"courseId == %@", [courseId stringValue]];

    NSError *error = nil;
    NSArray *results = [coreDataContext executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release]; */
    
        /*
        
         NSString *predicateString = [NSString stringWithFormat:@"Id==%@",[courseId stringValue]];
         NSFetchedResultsController *frc_course_filtered = [_cdStack frcWithEntityNamed:@"Course" withPredicateFormat:predicateString predicateObject:nil sortDescriptors:nil andSectionNameKeyPath:nil];  */
         
             if ([self.frc_courses.fetchedObjects count] != 0) {
                result = YES;
             }
         
        
        /*
        if ([(NSString *)[[self.frc_courses objectAtIndexPath: i] valueForKey:@"Id"] isEqual:[courseId stringValue]])  {
            result = true;
        }  */

    //}
            
    
    return result;
}

- (BOOL) gradedWorkExists:(NSString *)courseInfo withTitle:(NSString *)title {
    BOOL result = NO;
    
    
    
    
    //for(NSString *s in self.model.Subject){
    //for (int i=0;   i<self.Courses.count; i++) {
    //NSLog(@"inside CourseList.m delegate's search subject loop");
    //NSLog(@"in CourseList.m delegate's search subject loop, NSDictionary value is %@",[d valueForKey:@"SubjectCode"]);
    
    //NSLog(@"in CourseList.m delegate, SubjectCode value is %@", [self.model.Courses objectAtIndex: i]);
    
    //NSLog(@"in model.m courseExists method, Course id value is %@",[[self.Courses objectAtIndex: i] valueForKey:@"Id"]);
    
    //NSLog(@"in model.m courseExists method, Course name value is %@",[[self.Courses objectAtIndex: i] valueForKey:@"SubjectCode"]);
    
    
    
    [self.frc_gradedworks.fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"(courseInfo == %@) AND (title == %@)", courseInfo, title]];   //[courseId stringValue]]];
    
    [NSFetchedResultsController deleteCacheWithName:@"GradedWork"];
    
    NSError *error = nil;
    [self.frc_gradedworks performFetch:&error];
    /*
     
     NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
     fetchRequest.entity = [NSEntityDescription entityForName:@"Course" inManagedObjectContext:coreDataContext];
     fetchRequest.predicate = [NSPredicate predicateWithFormat:@"courseId == %@", [courseId stringValue]];
     
     NSError *error = nil;
     NSArray *results = [coreDataContext executeFetchRequest:fetchRequest error:&error];
     [fetchRequest release]; */
    
    /*
     
     NSString *predicateString = [NSString stringWithFormat:@"Id==%@",[courseId stringValue]];
     NSFetchedResultsController *frc_course_filtered = [_cdStack frcWithEntityNamed:@"Course" withPredicateFormat:predicateString predicateObject:nil sortDescriptors:nil andSectionNameKeyPath:nil];  */
    
    if ([self.frc_gradedworks.fetchedObjects count] != 0) {
        result = YES;
    }
    
    
    /*
     if ([(NSString *)[[self.frc_courses objectAtIndexPath: i] valueForKey:@"Id"] isEqual:[courseId stringValue]])  {
     result = true;
     }  */
    
    //}
    
    
    return result;
}

#pragma mark - Data fetcher

- (NSArray *)fetchDataForEntityNamed:(NSString *)entityName withPredicateFormat:(NSString *)predicate predicateObject:(id)predicateObject sortDescriptors:(NSString *)sortDescriptors
{
    NSFetchRequest *fr = [_cdStack fetchRequestForEnitityNamed:entityName withPredicateFormat:predicate predicateObject:predicateObject sortDescriptors:sortDescriptors];
    NSError *error = nil;
    NSArray *results = [_cdStack.managedObjectContext executeFetchRequest:fr error:&error];
    return (results) ? results : nil;
}

-(NSString *) showText:(NSString *)mystring {
    NSLog(@"\n=$$$***==$$$=***===***in Model.m showText method,mystring is %@",mystring);
    //NSString *temp=[NSString string]
    return [NSString stringWithFormat:@"i entered string: %@",mystring];
}

@end
