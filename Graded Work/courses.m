//
//  courses.m
//  Graded Work
//
//  Created by  on 11/24/12.
//
//

#import "courses.h"

@implementation courses

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        // Set the property values
        /*_rank = [[dictionary valueForKey:@"Rank"] intValue];
         _programName = [dictionary objectForKey:@"Program Name"];
         _network = [dictionary objectForKey:@"Network"];
         _viewers = [[dictionary valueForKey:@"Viewers"] intValue];*/
        _Day1= [dictionary objectForKey:@"Day1"];
        _Day2= [dictionary objectForKey:@"Day2"];
        _Duration1= [[dictionary valueForKey:@"Duration1"] intValue];
        _Duration2= [[dictionary valueForKey:@"Duration2"] intValue];
        _EmployeeName= [dictionary objectForKey:@"EmployeeName"];
        _Id= [[dictionary valueForKey:@"Id"] intValue];
        _IsOffered=[[dictionary valueForKey:@"IsOffered"] intValue];
        _Room1= [dictionary objectForKey:@"Room1"];
        _Room2= [dictionary objectForKey:@"Room2"];
        _Section= [dictionary objectForKey:@"Section"];
        _StartPeriod1= [[dictionary valueForKey:@"StartPeriod1"] intValue];
        _StartPeriod2= [[dictionary valueForKey:@"StartPeriod2"] intValue];
        _SubjectCode=[dictionary objectForKey:@"SubjectCode"];
    }
    return self;
}

@end

