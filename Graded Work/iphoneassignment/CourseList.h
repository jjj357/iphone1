//
//  CourseList.h
//  Graded Work
//
//  Created by  on 11/22/12.
//
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "CourseEdit.h"


@interface CourseList : UITableViewController  <NSFetchedResultsControllerDelegate, EditCourseDelegate>


@property (nonatomic, strong) Model *model;
@property (nonatomic, strong) NSManagedObject *ro;
//@property (nonatomic, strong) NSManagedObject *ro_employee;
//@property (nonatomic, strong) NSManagedObject *ro_semester;

@end
