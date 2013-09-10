//
//  Utilities.m
//  Classes
//
//  Created by Peter McIntyre on 2012/10/25.
//  Copyright (c) 2012 Peter McIntyre. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities

+ (NSDate *) DateFromYear:(int)year month:(int)month day:(int)day {
    NSCalendar *c = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dc = [[NSDateComponents alloc] init];
    [dc setYear:year];
    [dc setMonth:month];
    [dc setDay:day];
    [dc setHour:0];
    [dc setMinute:0];
    [dc setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
    
    return [c dateFromComponents:dc];
}

+ (NSDate *)DateFromISO8601String:(NSString *)dateString
{
    if ([dateString hasSuffix:@"Z"])
    {
        dateString = [[dateString substringToIndex:(dateString.length-1)] stringByAppendingString:@"-0000"];
    }
    dateString = [dateString stringByReplacingOccurrencesOfString:@":" withString:@""];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HHmmssZ";
    
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
    
    return [dateFormatter dateFromString:dateString];
}

+ (NSDate *) DateFromYear:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute second:(int)second {
    /*
    NSCalendar *c = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dc = [[NSDateComponents alloc] init];
    [dc setYear:year];
    [dc setMonth:month];
    [dc setDay:day];
    [dc setHour:hour];
    [dc setMinute:minute];
    [de setSecond:second];
    return [c dateFromComponents:dc];
    */
    
    
    NSDate *date = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    NSDateComponents *dc = [gregorian components: NSUIntegerMax fromDate: date];
    [dc setYear:year];
    [dc setMonth:month];
    [dc setDay:day];
    [dc setHour:hour];
    [dc setMinute:minute];
    [dc setSecond:second];
    [dc setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
    
    NSDate *newDate = [gregorian dateFromComponents: dc];
    
    return newDate;
    
    //NSDate *newDate = [gregorian dateFromComponents: components];
    //[gregorian release];
}

+ (NSDate *) DateFromYear:(NSString *)dateString {
    /*
     NSCalendar *c = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
     NSDateComponents *dc = [[NSDateComponents alloc] init];
     [dc setYear:year];
     [dc setMonth:month];
     [dc setDay:day];
     [dc setHour:hour];
     [dc setMinute:minute];
     [de setSecond:second];
     return [c dateFromComponents:dc];
     */
    
    NSArray *firstSplit1 = [dateString componentsSeparatedByString:@"T"];
    
    NSArray *firstSplit2 = [[firstSplit1 objectAtIndex:0] componentsSeparatedByString:@"-"];
    NSString *year = [firstSplit2  objectAtIndex:0];
    NSString *month = [firstSplit2  objectAtIndex:1];
    NSString *day = [firstSplit2  objectAtIndex:2];
    
    NSArray *firstSplit3 = [[firstSplit1   objectAtIndex:1] componentsSeparatedByString:@":"];
    NSString *hour = [firstSplit3  objectAtIndex:0];
    NSString *minute = [firstSplit3  objectAtIndex:1];
    
    NSArray *firstSplit4 = [[firstSplit3  objectAtIndex:2] componentsSeparatedByString:@"."];
    NSString *second = [firstSplit4  objectAtIndex:0];
    
    
    
    
    NSDate *date = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSGregorianCalendar];
    NSDateComponents *dc = [gregorian components: NSUIntegerMax fromDate: date];
    [dc setYear:[year intValue]];
    [dc setMonth:[month intValue]];
    [dc setDay:[day intValue]];
    [dc setHour:[hour intValue]];
    [dc setMinute:[minute intValue]];
    [dc setSecond:[second intValue]];
    [dc setTimeZone:[NSTimeZone timeZoneWithName:@"EST"]];
    
    NSDate *newDate = [gregorian dateFromComponents: dc];
    
    return newDate;
    
    //NSDate *newDate = [gregorian dateFromComponents: components];
    //[gregorian release];
}

@end
