//
//  Student+CoreDataProperties.h
//  coreDataDemo
//
//  Created by 陈新爽 on 2022/3/9.
//
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest NS_SWIFT_NAME(fetchRequest());

@property (nullable, nonatomic, copy) NSString *name;
@property (nonatomic) int16_t age;
@property (nullable, nonatomic, copy) NSString *gender;

@end

NS_ASSUME_NONNULL_END
