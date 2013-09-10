//
//  courses.h
//  Graded Work
//
//  Created by  on 11/24/12.
//
//

#import <Foundation/Foundation.h>

@interface courses : NSObject



@property (nonatomic, strong) NSString *Day1;
@property (nonatomic, strong) NSString *Day2;
@property (nonatomic) NSInteger Duration1;
@property (nonatomic) NSInteger Duration2;
@property (nonatomic, strong) NSString *EmployeeName;
@property (nonatomic) NSInteger Id;
@property (nonatomic) Boolean IsOffered;
@property (nonatomic, strong) NSString *Room1;
@property (nonatomic, strong) NSString *Room2;
@property (nonatomic, strong) NSString *Section;
@property (nonatomic) NSInteger StartPeriod1;
@property (nonatomic) NSInteger StartPeriod2;
@property (nonatomic, strong) NSString *SubjectCode;


// Designated initializer
- (id)initWithDictionary:(NSDictionary *)dictionary;
@end