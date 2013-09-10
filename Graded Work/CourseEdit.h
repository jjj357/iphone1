//
//  CourseEdit.h
//  Graded Work
//
//  Created by  on 11/22/12.
//
//

#import <UIKit/UIKit.h>
#import "Model.h"

// See the protocol definition below
@protocol EditCourseDelegate;


@interface CourseEdit : UITableViewController //<UITextFieldDelegate>

// This class needs a delegate property
@property (nonatomic, assign) id <EditCourseDelegate> delegate;

@property (nonatomic, strong) Model *model;
//@property (strong, nonatomic) id detailItem;
@property (nonatomic, strong) NSManagedObject *ro;



- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end



// We use the delegate pattern here
// The intention is that this "add" view controller will be presented modally
// It will enable the user to enter data, and then "cancel" or "save"
// Both methods will call a delegate method to process the entered data
// Note that this view controller could also be used to "edit" an existing category

// The protocol's name format should be: Edit____Delegate, where the blank
// is the name of the entity / object that is being edited

@protocol EditCourseDelegate <NSObject>

// By default, methods are "required"; you can change this by prefacing methods with "@optional"
- (void) EditCourseController:(id)controller didEditItem:(id)item;




@end
