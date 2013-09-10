//
//  WebService.m
//  Graded Work
//
//  Created by  on 11/24/12.
//
//

#import "WebService.h"
#import "AFHTTPRequestOperation.h"

#define BaseURL @"http://dps913fall2012.azurewebsites.net/api/"

@implementation WebService

+ (id)sharedInstance
{
    static WebService *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[WebService alloc] initWithBaseURL:[NSURL URLWithString:BaseURL]];
    });
    return __sharedInstance;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self)
    {
        // Configuration
        // e.g. can also set token header, and other settings
        [self registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    }
    return self;
}


@end

