//
//  AppDelegate.h
//  coreDataDemo
//
//  Created by 陈新爽 on 2022/3/9.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

