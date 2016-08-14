//
//  AppDelegate+MOC.m
//  Photomania
//
//  Created by Gao Song on 8/14/16.
//  Copyright © 2016 Gao Song. All rights reserved.
//

#import "AppDelegate+MOC.h"

@implementation AppDelegate (MOC)
#pragma mark - Core Data stack

/*
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) mainQueueManagedObjectContext
{
    NSManagedObjectContext *managedObjectContext;
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [managedObjectContext setPersistentStoreCoordinator: coordinator];
    
    return managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    NSManagedObjectModel *managedObjectModel;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Photomania" withExtension:@"momd"];
    managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return managedObjectModel;
}

/*
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    
    NSString *storePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent:@"Earthquakes.sqlite"];
    NSURL *storeUrl = [NSURL fileURLWithPath:storePath];
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: @YES, NSInferMappingModelAutomaticallyOption: @YES};
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    NSError *error;
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return persistentStoreCoordinator;
}


#pragma mark - Application's documents directory

// Returns the URL to the application's Documents directory.
- (NSString *)applicationDocumentsDirectory
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}
@end
