//
//  WorkView.h
//  Graded Work
//
//  Created by  on 11/30/12.
//
//

#import <UIKit/UIKit.h>

@interface WorkView : UIViewController

@property (nonatomic, strong) NSManagedObject *ro;

@property (nonatomic, strong) Model *model;


@property (weak, nonatomic) IBOutlet UILabel *lblCourse;
@property (weak, nonatomic) IBOutlet UILabel *lblDateAssigned;
@property (weak, nonatomic) IBOutlet UILabel *lblDateDue;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblValue;
@property (weak, nonatomic) IBOutlet UILabel *lblMoreInfo;



@end
