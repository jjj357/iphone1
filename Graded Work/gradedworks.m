//
//  gradedworks.m
//  Graded Work
//
//  Created by  on 11/30/12.
//
//

#import "gradedworks.h"

@implementation gradedworks

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        // Set the property values
        _DateCreated= [dictionary objectForKey:@"DateCreated"];
        _DateAssigned= [dictionary objectForKey:@"DateAssigned"];
        _DateDue=  [dictionary objectForKey:@"DateDue"];
        _Duration= [dictionary valueForKey:@"Duration"]; 
        //_Duration= [[dictionary valueForKey:@"Duration"] intValue];
        //_Value= [NSNumber numberWithInt:[[dictionary valueForKey:@"Value"] intValue]];
        _Value = [dictionary valueForKey:@"Value"];
        _MoreInfoUrl= [dictionary objectForKey:@"MoreInfoUrl"];
        //_Id= [[dictionary valueForKey:@"Id"] intValue];
        _Id= [dictionary valueForKey:@"Id"];  
        //_RowVersion=[[dictionary valueForKey:@"RowVersion"] intValue];
        _RowVersion=[dictionary valueForKey:@"RowVersion"];
        
        _IsCurrent=[dictionary valueForKey:@"IsCurrent"];
        
        
        /*
        if ([[dictionary valueForKey:@"IsCurrent"] isEqualToString:@"true"]) {
            
            _IsCurrent=[dictionary valueForKey:@"IsCurrent"];  //true;    //YES;
        }
        else if ([[dictionary valueForKey:@"IsCurrent"] isEqualToString:@"false"]) {
            
            _IsCurrent=false;    //NO;
        }  */
        
        _Title=  [dictionary objectForKey:@"Title"];
        _Category=  [dictionary objectForKey:@"Category"];
        _Description=  [dictionary objectForKey:@"Description"];
        _CourseInfo=  [dictionary objectForKey:@"CourseInfo"];  


    }
    return self;
}


@end

