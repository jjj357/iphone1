//
//  MyNotes.h
//  Graded Work
//
//  Created by  on 12/6/12.
//
//

#import <UIKit/UIKit.h>



@interface MyNotes : UIViewController

@property (nonatomic, strong) NSManagedObject *ro;

@property (nonatomic, strong) NSString *courseInfoAndTitle;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *notes;

//UI labels,text view
@property (weak, nonatomic) IBOutlet UILabel *lblCourseInfoAndTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UITextView *tvNotes;


- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;


@end
