//
//  ViewController.m
//  coreDataDemo
//
//  Created by 陈新爽 on 2022/3/9.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Student+CoreDataClass.h"

@interface ViewController ()
@property (nonatomic, strong)NSManagedObjectContext* context;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addStudentWithName:@"cxs" age:21 gender:@"boy"];
    [self selectStudent];
    
    [self updateStudentWithOldName:@"cxs" newName:@"CXSCCC" newAge:22 newGender:@"handsomeBoy"];
    [self selectStudent];
    
    [self deleteStudentWithName:@"CXSCCC"];
    [self selectStudent];
}

//add
- (void)addStudentWithName:(NSString*)name age:(NSInteger)age gender:(NSString*)gender {
    //校验name是否重复
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    request.predicate = predicate;
    NSArray<Student *> *students = [self.context executeFetchRequest:request error:nil];
    if(students.count){
        return;
    }
    
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.context];
    student.name = name;
    student.age = age;
    student.gender = gender;
    NSError *error = nil;
    if (self.context.hasChanges) {
        [self.context save:&error];
    }
    if (error) {
        NSLog(@"CoreData Insert Data Error : %@", error);
    }
}

//delete
- (void)deleteStudentWithName:(NSString *)name {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    request.predicate = predicate;
    
    NSError *error = nil;
    NSArray<Student *> *students = [self.context executeFetchRequest:request error:&error];
    
    [students enumerateObjectsUsingBlock:^(Student * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.context deleteObject:obj];
    }];
    
    if (self.context.hasChanges) {
        [self.context save:nil];
    }
    
    if (error) {
        NSLog(@"CoreData Delete Data Error : %@", error);
    }
}

//update
- (void)updateStudentWithOldName:(NSString*)oldName newName:(NSString*)newName newAge:(NSInteger)newAge newGender:(NSString*)newGender{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", oldName];
    request.predicate = predicate;
    
    NSError *error = nil;
    NSArray<Student *> *students = [self.context executeFetchRequest:request error:&error];
    
    [students enumerateObjectsUsingBlock:^(Student * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.name = newName;
        obj.age = newAge;
        obj.gender = newGender;
    }];
    
    if (self.context.hasChanges) {
        [self.context save:nil];
    }
    
    if (error) {
        NSLog(@"CoreData Delete Data Error : %@", error);
    }
}

//select
-(void)selectStudent {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    
    NSError *error = nil;
    NSArray<Student *> *students = [self.context executeFetchRequest:request error:&error];
    if(students.count){
        [students enumerateObjectsUsingBlock:^(Student * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"Student Name : %@, age : %hd, gender : %@", obj.name, obj.age, obj.gender);
        }];
    }else{
        NSLog(@"coreData is empty");
    }
    
    if (error) {
        NSLog(@"CoreData Ergodic Data Error : %@", error);
    }
}

#pragma mark - getter
- (NSManagedObjectContext *)context {
    if(!_context) {
        AppDelegate *myDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        _context = myDelegate.persistentContainer.viewContext;
    }
    return _context;
}

@end
