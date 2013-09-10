//
//  WorkView.m
//  Graded Work
//
//  Created by  on 11/30/12.
//
//

#import "WorkView.h"
#import "MoreInfoOnTheWeb.h"
#import "MyNotes.h"
#import "GroupMemberList.h"

@interface WorkView ()

@end

@implementation WorkView
@synthesize lblCourse;
@synthesize lblDateAssigned;
@synthesize lblDateDue;
@synthesize lblDescription;
@synthesize lblTitle;
@synthesize lblValue;
@synthesize lblMoreInfo;

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
    self.lblCourse.text = [NSString stringWithFormat:@"Course Info: %@",[self.ro valueForKey:@"courseInfo"]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
    
    NSLog(@"======in graded workview.m, date assigned is %@,title is %@", [self.ro valueForKey:@"dateAssigned"],[self.ro valueForKey:@"title"]);
    NSString *strDate = [dateFormatter stringFromDate:[self.ro valueForKey:@"dateAssigned"]];
    NSLog(@"&&&&&&&&&&&&in graded workview.m, date assigned is %@", strDate);
    //[dateFormatter release];
    
    
    self.lblDateAssigned.text = [NSString stringWithFormat:@"Date Assigned: %@",strDate];   //[self.ro valueForKey:@"dateAssigned"];
    
    NSString *strDate2 = [dateFormatter stringFromDate:[self.ro valueForKey:@"dateDue"]];
    self.lblDateDue.text = [NSString stringWithFormat:@"Date Due: %@",strDate2];   //[NSString stringWithFormat:@"%@",[self.ro valueForKey:@"dateDue"]];
    
    self.lblDescription.text = [NSString stringWithFormat:@"Desciption: %@",[self.ro valueForKey:@"gradeDescription"]];
    self.lblTitle.text = [NSString stringWithFormat:@"Title: %@",[self.ro valueForKey:@"title"]];
    self.lblValue.text = [NSString stringWithFormat:@"Grade: %@",[NSString stringWithFormat:@"%@",[self.ro valueForKey:@"value"]]];
    self.lblMoreInfo.text = [self.ro valueForKey:@"moreInfoUrl"];
    

    
    
}

- (void)viewDidUnload
{
    [self setLblCourse:nil];
    [self setLblDateAssigned:nil];
    [self setLblDateDue:nil];
    [self setLblDescription:nil];
    [self setLblTitle:nil];
    [self setLblValue:nil];
    [self setLblMoreInfo:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    
    // Navigation push
    if ([segue.identifier isEqualToString:@"toNotes"])
    {
        // Fetch the selected object
        //NSManagedObject *o = [self.model.frc_courses objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        //Configure the next VC
        MyNotes *nextVC = (MyNotes *)nav.topViewController;
        NSLog(@"------in workview.m segue to mynotes, course info value is %@",[self.ro valueForKey:@"courseInfo"]);
        nextVC.courseInfoAndTitle = [NSString stringWithFormat:@"%@ - %@",[self.ro valueForKey:@"courseInfo"],[self.ro valueForKey:@"title"]];
        nextVC.description = [self.ro valueForKey:@"gradeDescription"];
        nextVC.notes = [self.ro valueForKey:@"notes"];
        //nextVC.model = self.model;
        
        nextVC.ro= self.ro;
    }  
    
    
    if ([segue.identifier isEqualToString:@"toWebview"])
    {
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        //NSManagedObject *so = [self.model.frc_courses objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        MoreInfoOnTheWeb *nextVC = (MoreInfoOnTheWeb *)nav.topViewController;
        //nextVC.model = self.model;
        //nextVC.delegate = self;
        nextVC.moreInfoURL = [self.ro valueForKey:@"moreInfoUrl"];
    }
    
    
    if ([segue.identifier isEqualToString:@"toGroupMember"])
    {
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        //NSManagedObject *so = [self.model.frc_courses objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        //GroupMemberList *nextVC = (GroupMemberList *)segue.destinationViewController;
        GroupMemberList *nextVC = (GroupMemberList *)nav.topViewController;
        nextVC.model = self.model;
        nextVC.ro = self.ro;
        NSLog(@"------in workview.m segue to toGroupMember...");
        //nextVC.delegate = self;
        //nextVC.moreInfoURL = [self.ro valueForKey:@"moreInfoUrl"];
    }
    
}

@end
