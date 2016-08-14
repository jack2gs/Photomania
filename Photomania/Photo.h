//
//  Photo.h
//  Photomania
//
//  Created by Gao Song on 8/11/16.
//  Copyright © 2016 Gao Song. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Photographer;

NS_ASSUME_NONNULL_BEGIN

@interface Photo : NSManagedObject

// Insert code here to declare functionality of your managed object subclass
+(Photo *)photoWithFlickrInfo:(NSDictionary *)photoDictionary
      inManageedObjectContext:(NSManagedObjectContext *)context;

+(void)loadPhotosFromFlickrArray:(NSArray *)photos // of Flickr Dictionary
         inManageedObjectContext:(NSManagedObjectContext *)context;
@end

NS_ASSUME_NONNULL_END

#import "Photo+CoreDataProperties.h"
