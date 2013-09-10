//
//  MoreInfoOnTheWeb.m
//  Graded Work
//
//  Created by  on 12/6/12.
//
//

#import "MoreInfoOnTheWeb.h"

@interface MoreInfoOnTheWeb ()

@end

@implementation MoreInfoOnTheWeb
@synthesize wvMoreInfo=_wvMoreInfo;
@synthesize moreInfoURL=_moreInfoURL;

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
    NSURLRequest* request=[NSURLRequest requestWithURL:[NSURL URLWithString:_moreInfoURL]];
    [self.wvMoreInfo loadRequest:request];
}

- (void)viewDidUnload
{
    [self setWvMoreInfo:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
