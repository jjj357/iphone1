//
//  MyNotes.m
//  Graded Work
//
//  Created by  on 12/6/12.
//
//

#import "MyNotes.h"

@interface MyNotes ()

@end

@implementation MyNotes
@synthesize lblCourseInfoAndTitle;
@synthesize lblDescription;
@synthesize tvNotes;

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
	// Do any additional setup after loading the view.
    self.lblCourseInfoAndTitle.text = self.courseInfoAndTitle;
    self.lblDescription.text = self.description;
    self.tvNotes.text = self.notes;
}

- (void)viewDidUnload
{
    [self setLblCourseInfoAndTitle:nil];
    [self setLblDescription:nil];
    [self setTvNotes:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

//a method copied from CourseList.m, maybe useless to this file
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
    if (editing)
    {
        // The "Edit button was tapped, so we create an "Cancel" button on the left side
        // Add it to the left side of the nav bar
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(imagePickerControllerDidCancel:)];
        
        // Add it to the left side of the nav bar
        [self.navigationItem setLeftBarButtonItem:cancelButton animated:YES];
    }
    else
    {
		// The "Done" button was tapped, so we remove the add button from the left side
		[self.navigationItem setLeftBarButtonItem:nil animated:YES];
        //NSManagedObject *p = [self addNew:@"Course"];
        [self.ro setValue:self.tvNotes.text forKey:@"notes"];
    }
}

- (IBAction)cancel:(id)sender {
    // Call the delegate, pass in nil
    //[self.delegate EditCourseController:self didEditItem:nil];
    [self dismissModalViewControllerAnimated: YES];
}

- (IBAction)save:(id)sender {
    [self.ro setValue:self.tvNotes.text forKey:@"notes"];
    [self dismissModalViewControllerAnimated: YES];
}


@end
