//
//  ContactInfo.h
//  Graded Work
//
//  Created by  on 12/8/12.
//
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface ContactInfo : UIViewController

@property (nonatomic, strong) NSManagedObject *ro;
@property (nonatomic, strong)  id contact;


@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblCompany;
@property (weak, nonatomic) IBOutlet UIImageView *ivContact;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;


@end
