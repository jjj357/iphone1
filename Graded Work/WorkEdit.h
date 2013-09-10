//
//  WorkEdit.h
//  Graded Work
//
//  Created by  on 12/1/12.
//
//

#import <UIKit/UIKit.h>

@interface WorkEdit : UIViewController

@property (nonatomic, strong) Model *model;


@property (weak, nonatomic) IBOutlet UIButton *lblSortDate;
@property (weak, nonatomic) IBOutlet UIButton *lblSortCourse;
@property (weak, nonatomic) IBOutlet UIButton *lblSortValue;


- (IBAction)done:(id)sender;


@end
