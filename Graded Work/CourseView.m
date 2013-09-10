//
//  CourseView.m
//  Graded Work
//
//  Created by  on 11/22/12.
//
//

#import "CourseView.h"
#import "ICTClient.h"

@interface CourseView ()

@end

@implementation CourseView
@synthesize lblSubjectCodeSection;
@synthesize lblSemesterName;
@synthesize lblEmployeeName;
@synthesize lblDay1TimeInRoom;
@synthesize lblDay2TimeInRoom;

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
    
    // Build the user interface...
    
    self.lblSubjectCodeSection.text = [NSString stringWithFormat:@"%@ %@",[self.ro valueForKey:@"subjectCode"],[self.ro valueForKey:@"section"]];
    
    self.lblSemesterName.text = [self.ro valueForKey:@"semesterName"];
    
    self.lblEmployeeName.text = [self.ro valueForKey:@"employeeName"];
    
    NSString *temp_day1 = [self.ro valueForKey:@"day1"];
    NSString *temp_day2 = [self.ro valueForKey:@"day2"];
    NSString *temp_duration1 = [NSString stringWithFormat:@"%d", [[self.ro valueForKey:@"duration1"] intValue]];
    NSString *temp_duration2 = [NSString stringWithFormat:@"%d", [[self.ro valueForKey:@"duration2"] intValue]];
    
    NSString *temp_startperiod1 = [NSString stringWithFormat:@"%d", [[self.ro valueForKey:@"startPeriod1"] intValue]];
    if (![temp_startperiod1 isEqualToString:@"10"]) {
       temp_startperiod1 = [NSString stringWithFormat:@"0%@", temp_startperiod1] ;
    }
    
    NSString *temp_startperiod2 = [NSString stringWithFormat:@"%d", [[self.ro valueForKey:@"startPeriod2"] intValue]];
    if (![temp_startperiod2 isEqualToString:@"10"]) {
        temp_startperiod2 = [NSString stringWithFormat:@"0%@", temp_startperiod2] ;
    }
    
    ////
    
    NSString *temp1 = [NSString stringWithFormat:@"%@%@",temp_duration1, temp_startperiod1];
    NSString *temp2 = [NSString stringWithFormat:@"%@%@",temp_duration2, temp_startperiod2];
    
    NSLog(@"temp1 value is %@",temp1);
    ////
    
    NSString *final_weekdayname1 = [self.model.weekDayName valueForKey:temp_day1];
    NSString *final_weekdayname2 = [self.model.weekDayName valueForKey:temp_day2];
    
    NSString *final_timeperiod1 = [self.model.dayIdToDayName valueForKey:temp1];
    NSString *final_timeperiod2 = [self.model.dayIdToDayName valueForKey:temp2];
    
    NSString *final_room1 = [self.ro valueForKey:@"room1"];
    NSString *final_room2 = [self.ro valueForKey:@"room2"];
    
    
    
    self.lblDay1TimeInRoom.text = [NSString stringWithFormat:@"%@ %@ in %@",final_weekdayname1,final_timeperiod1,final_room1];
    self.lblDay2TimeInRoom.text = [NSString stringWithFormat:@"%@ %@ in %@",final_weekdayname2,final_timeperiod2,final_room2];
    
}

- (void)viewDidUnload
{
    [self setLblSubjectCodeSection:nil];
    [self setLblSemesterName:nil];
    [self setLblEmployeeName:nil];
    [self setLblDay1TimeInRoom:nil];
    [self setLblDay2TimeInRoom:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
