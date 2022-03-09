//
//  Student+CoreDataProperties.m
//  coreDataDemo
//
//  Created by 陈新爽 on 2022/3/9.
//
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Student"];
}

@dynamic name;
@dynamic age;
@dynamic gender;

@end
