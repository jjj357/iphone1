//
//  GradedWorkList.h
//  Graded Work
//
//  Created by  on 11/30/12.
//
//

#import <Foundation/Foundation.h>
#import "Model.h"
#import "WorkEdit.h"

@interface GradedWorkList : UITableViewController

@property (nonatomic, strong) Model *model;
@property (nonatomic, strong) NSManagedObject *ro;
@property (nonatomic, strong) NSArray *gradedworks;

@end