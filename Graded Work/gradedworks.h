//
//  gradedworks.h
//  Graded Work
//
//  Created by  on 11/30/12.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface gradedworks : NSObject


@property (nonatomic, strong) NSString *DateCreated;
@property (nonatomic, strong) NSString *DateAssigned;
@property (nonatomic, strong) NSString *DateDue;
//@property (nonatomic) NSInteger Duration;
@property (nonatomic, strong) NSString *Duration;


//@property (nonatomic) NSNumber *Value;
@property (nonatomic, strong) NSString *Value;


@property (nonatomic, strong) NSString *MoreInfoUrl;
//@property (nonatomic) NSInteger Id;
//@property (nonatomic) NSInteger RowVersion;
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *RowVersion;


//@property (nonatomic) Boolean IsCurrent;
@property (nonatomic, strong) NSString *IsCurrent;
@property (nonatomic, strong) NSString *Title;
@property (nonatomic, strong) NSString *Category;
@property (nonatomic, strong) NSString *Description;
@property (nonatomic, strong) NSString *CourseInfo;


// Designated initializer
- (id)initWithDictionary:(NSDictionary *)dictionary;


@end
