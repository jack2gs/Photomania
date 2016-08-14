//
//  Photographer.h
//  Photomania
//
//  Created by Gao Song on 8/11/16.
//  Copyright © 2016 Gao Song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photo;

NS_ASSUME_NONNULL_BEGIN

@interface Photographer : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+(Photographer *)photographerWithName:(NSString *)name
             inManageredObjectContext:(NSManagedObjectContext *)context;

@end

NS_ASSUME_NONNULL_END

#import "Photographer+CoreDataProperties.h"
