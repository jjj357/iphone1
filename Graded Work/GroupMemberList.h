//
//  GroupMemberList.h
//  Graded Work
//
//  Created by  on 12/6/12.
//
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface GroupMemberList  : UITableViewController  <ABPeoplePickerNavigationControllerDelegate, ABPersonViewControllerDelegate>



@property (nonatomic, strong) Model *model;
@property (nonatomic, strong) NSManagedObject *ro;
@property (nonatomic, strong) NSArray *groupmembers;

@end
