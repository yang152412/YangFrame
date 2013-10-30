//
//  AppDelegate.h
//  YangFrame
//
//  Created by Yang Shichang on 13-10-26.
//  Copyright (c) 2013年 Yang152412. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YNetEngine.h"
#import "TabBarViewController.h"
#import "NavigationViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@property (strong, nonatomic) NavigationViewController *navController;
@property (strong, nonatomic) TabBarViewController *tabBarController;
@property (strong, nonatomic) YNetEngine *netEngine;

@end
