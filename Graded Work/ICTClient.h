//
//  ICTClient.h
//  Graded Work
//
//  Created by  on 11/28/12.
//
//

#import <Foundation/Foundation.h>
#import "AFHTTPClient.h"

@interface ICTClient :  AFHTTPClient

+ (id)sharedInstance;

@end
