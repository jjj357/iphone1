//
//  CourseView.h
//  Graded Work
//
//  Created by  on 11/22/12.
//
//

#import <UIKit/UIKit.h>
//#import "Course.h"
#import "Model.h"

@interface CourseView : UIViewController

@property (nonatomic, strong) Model *model;
//@property (nonatomic, strong) Course *courseitem;
@property (nonatomic, strong) NSManagedObject *ro;

//user interface
@property (weak, nonatomic) IBOutlet UILabel *lblSubjectCodeSection;
@property (weak, nonatomic) IBOutlet UILabel *lblSemesterName;
@property (weak, nonatomic) IBOutlet UILabel *lblEmployeeName;
@property (weak, nonatomic) IBOutlet UILabel *lblDay1TimeInRoom;
@property (weak, nonatomic) IBOutlet UILabel *lblDay2TimeInRoom;




@end
