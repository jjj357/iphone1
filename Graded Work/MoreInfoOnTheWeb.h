//
//  MoreInfoOnTheWeb.h
//  Graded Work
//
//  Created by  on 12/6/12.
//
//

#import <UIKit/UIKit.h>

@interface MoreInfoOnTheWeb : UIViewController
@property (nonatomic, strong) NSString *moreInfoURL;

@property (weak, nonatomic) IBOutlet UIWebView *wvMoreInfo;



@end
