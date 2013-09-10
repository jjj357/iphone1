//
//  ICTClient.m
//  Graded Work
//
//  Created by  on 11/28/12.
//
//

#import "ICTClient.h"
#import "AFHTTPRequestOperation.h"

#define BaseURL @"http://dps913fall2012.azurewebsites.net/api/"

@implementation ICTClient

+ (id)sharedInstance
{
    static ICTClient *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[ICTClient alloc] initWithBaseURL:[NSURL URLWithString:BaseURL]];
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

