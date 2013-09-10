//
//  Model.h
//  CD Simple
//
//  Created by Peter McIntyre on 2012/06/22.
//  Copyright (c) 2012 Seneca College. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

// Properties

@property (nonatomic, strong) NSFetchedResultsController *frc_event;
@property (nonatomic, strong) NSFetchedResultsController *frc_courses;
@property (nonatomic, strong) NSFetchedResultsController *frc_subjects;
@property (nonatomic, strong) NSFetchedResultsController *frc_semesters;
@property (nonatomic, strong) NSFetchedResultsController *frc_employees;
@property (nonatomic, strong) NSFetchedResultsController *frc_gradedworks;
@property (nonatomic, strong) NSFetchedResultsController *frc_gradedworks_sortbydate;
@property (nonatomic, strong) NSFetchedResultsController *frc_gradedworks_sortbycourse;
@property (nonatomic, strong) NSFetchedResultsController *frc_gradedworks_sortbyvalue;
@property (nonatomic, strong) NSFetchedResultsController *frc_contacts;

@property (nonatomic, strong) NSDictionary *dayIdToDayName;
@property (nonatomic, strong) NSDictionary *weekDayName;

// Methods

@property (nonatomic, strong) NSArray *Courses;
@property (nonatomic, strong) NSArray *Subject;
@property (nonatomic, strong) NSArray *Employee;
@property (nonatomic, strong) NSArray *Semester;
@property (nonatomic, strong) NSArray *Gradedwork;
@property (nonatomic, strong) NSArray *Contact;

//@property (nonatomic, strong) NSDictionary *temp;

- (BOOL) courseExists:(NSNumber *)courseId;
- (BOOL) gradedWorkExists:(NSString *)courseInfo withTitle:(NSString *)title;

- (void) fetchGradedWork:(id)course;

// New... enables a course to be deleted
- (BOOL)courseDelete:(NSManagedObject *)course;

- (BOOL)contactDelete:(NSManagedObject *)contact;

//New... enables a gradedwork to be deleted
- (BOOL)gradedworkDelete:(NSManagedObject *)gradedwork;


//- (void)searchCourseList:(NSString *)artist album:(NSString *)album song:(NSString *)song;
- (id)addNew:(NSString *)entityName;
- (void)saveChanges;


- (NSManagedObject *)getGradedWorkById:(NSString *)gradedworkid;

// Convenience method, customized to the entity's desig
/*
- (id)addNewCourse:(NSString *)day1 inDay2:(NSString *)day2 inDuration1:(NSInteger)duration1 inDuration2:(NSInteger)duration2 inCourseId:(NSInteger)courseid inRoom2:(NSString *)room1 inRoom2:(NSString *)room2 inSection:(NSString *)section inStartPeriod:(NSInteger)startPeriod inStartPeriod2:(NSInteger)startPeriod2 forSubject:(id)subject;  */

- (id)addNewCourse:(NSString *)day1 inDay2:(NSString *)day2 inDuration1:(NSInteger)duration1 inDuration2:(NSInteger)duration2 inCourseId:(NSInteger)courseid inRoom2:(NSString *)room1 inRoom2:(NSString *)room2 inSection:(NSString *)section inStartPeriod:(NSInteger)startPeriod inStartPeriod2:(NSInteger)startPeriod2 forSubjectCode:(NSString *)subjectCode forEmployeeName:(NSString *)employeeName forSemesterName:(NSString *)semesterName;


- (id)addNewSubject:(NSString *)code  inDescription:(NSString *)desc inSubjectId:(NSInteger)subjectId inName:(NSString *)name inOutLineURL:(NSString *)outlineUrl ;

- (id)addNewEmployee:(NSString *)fullname  inWebSite:(NSString *)website inEmployeeId:(NSInteger)employeeId;

- (id)addNewSemester:(NSString *)semesterName  inString:(NSString *)semesterString inSemesterId:(NSInteger)semesterId inSemesterNum:(NSInteger)semesterNumber inYear:(NSInteger)year;

/*
- (id)addNewGradedwork:(NSString *)gradedworkId withTitle:(NSString *)gradedworkTitle inCategory:(NSString *)gradedworkCategory withDescription:(NSString *)gradedworkDescription withMoreInfoUrl:(NSString *)gradedworkMoreInfoUrl withValue:(NSString *)gradedworkValue onDateCreated:(NSString *)gradedworkDateCreated onDateAssigned:(NSString *)gradedworkDateAssigned onDateDue:(NSString *)gradedworkDateDue withTimeDuration:(NSString *)gradedworkDuration withCourseInfo:(NSString *)gradedworkCourseInfo withRowVersion:(NSString *)gradedworkRowVersion;   // withIsCurrent:(NSString *)gradedworkIsCurrent ;   */

- (id)addNewGradedwork:(NSInteger)gradedworkId withTitle:(NSString *)gradedworkTitle inCategory:(NSString *)gradedworkCategory withDescription:(NSString *)gradedworkDescription withMoreInfoUrl:(NSString *)gradedworkMoreInfoUrl withValue:(NSDecimalNumber *)gradedworkValue onDateCreated:(NSString *)gradedworkDateCreated onDateAssigned:(NSString *)gradedworkDateAssigned onDateDue:(NSString *)gradedworkDateDue withTimeDuration:(NSInteger)gradedworkDuration withCourseInfo:(NSString *)gradedworkCourseInfo withRowVersion:(NSInteger)gradedworkRowVersion forCourse:(id)course;


//- (id)addNewContact:(NSString *)name  inCompany:(NSString *)company withPhoneNumber:(NSString *)phoneNumber withEmailAddress:(NSString *)email ;

-(id)addNewGroupMember:(NSNumber *)memberId withName:(NSString *)name toGradedWork:(id)gradedwork;

-(id)addNewGroupMemberWithoutGradedWorkObject:(NSNumber *)memberId withName:(NSString *)name;


// General-purpose data fetcher
- (NSArray *)fetchDataForEntityNamed:(NSString *)entityName withPredicateFormat:(NSString *)predicate predicateObject:(id)predicateObject sortDescriptors:(NSString *)sortDescriptors;

-(NSString *) showText:(NSString *)mystring;

@end
