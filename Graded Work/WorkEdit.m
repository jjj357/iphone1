//
//  WorkEdit.m
//  Graded Work
//
//  Created by  on 12/1/12.
//
//

#import "WorkEdit.h"
#import "SortByDate.h"
#import "SortByCourse.h"
#import "SortByValue.h"
#import "WorkCourseList.h"

@interface WorkEdit ()

@end

@implementation WorkEdit
@synthesize lblSortDate;
@synthesize lblSortCourse;
@synthesize lblSortValue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setLblSortDate:nil];
    [self setLblSortCourse:nil];
    [self setLblSortValue:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /*
    // Navigation
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
    
    
    if ([segue.identifier isEqualToString:@"toSortDate"])
    {
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        //NSManagedObject *so = [self.model.frc_courses objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        SortByDate *nextVC = (SortByDate *)nav.topViewController;
        nextVC.model = self.model;
        //nextVC.delegate = self;
        //nextVC.ro = so;
    }
    
    
    if ([segue.identifier isEqualToString:@"toSortCourse"])
    {
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        //NSManagedObject *so = [self.model.frc_courses objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        SortByCourse *nextVC = (SortByCourse *)nav.topViewController;
        
        //nextVC.listSortByCouse = [self.model fetchDataForEntityNamed:@"GradedWork" withPredicateFormat:nil predicateObject:nil sortDescriptors:@"courseInfo,YES,dateDue,YES"];
        
        nextVC.model = self.model; 
        //nextVC.delegate = self;
        //nextVC.ro = so;
    }
    
    
    if ([segue.identifier isEqualToString:@"toSortValue"])
    {
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        //NSManagedObject *so = [self.model.frc_courses objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        
        SortByValue *nextVC = (SortByValue *)nav.topViewController;
        
        //nextVC.listSortByValue = [self.model fetchDataForEntityNamed:@"GradedWork" withPredicateFormat:nil predicateObject:nil sortDescriptors:@"value,YES,courseInfo,YES"];
        
        
        nextVC.model = self.model;
        //nextVC.delegate = self;
        //nextVC.ro = so;
    }
    
    if ([segue.identifier isEqualToString:@"toWorkCCourseList"]) {
        //UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        //NSManagedObject *so = [self.model.frc_courses objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        //WorkCourseList *nextVC = (WorkCourseList *)nav.topViewController;
        WorkCourseList *nextVC = (WorkCourseList *)segue.destinationViewController;
        nextVC.model = self.model;
    }
    
    
    
}  


- (IBAction)done:(id)sender {
     [self dismissModalViewControllerAnimated: YES];
}
@end
