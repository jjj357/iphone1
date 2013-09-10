//
//  ContactInfo.m
//  Graded Work
//
//  Created by  on 12/8/12.
//
//

#import "ContactInfo.h"
#import "AFNetworking.h"
#import "ICTClient.h"
#import "Model.h"

@interface ContactInfo ()

@end

@implementation ContactInfo
@synthesize lblName;
@synthesize lblCompany;
@synthesize ivContact;
@synthesize lblPhone;
@synthesize lblEmail;

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
	// create an instance of the “person” controller
    ABPersonViewController *vc = [[ABPersonViewController alloc] init];
    
    //Next, configure it, using the “contact” object that was just fetched
    vc.personViewDelegate = self;
    vc.displayedPerson = (__bridge ABRecordRef)(self.contact);
    
    NSLog(@"inside ContactInfo.m viewdidload");
    
    //Finally, present the controller
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidUnload
{
    [self setLblName:nil];
    [self setLblCompany:nil];
    [self setIvContact:nil];
    [self setLblPhone:nil];
    [self setLblEmail:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
