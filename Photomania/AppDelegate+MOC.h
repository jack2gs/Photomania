//
//  AppDelegate+MOC.h
//  Photomania
//
//  Created by Gao Song on 8/14/16.
//  Copyright © 2016 Gao Song. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface AppDelegate (MOC)

-(NSManagedObjectContext *)mainQueueManagedObjectContext;

@end
