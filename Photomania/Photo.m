//
//  Photo.m
//  Photomania
//
//  Created by Gao Song on 8/11/16.
//  Copyright © 2016 Gao Song. All rights reserved.
//

#import "Photo.h"
#import "FlickrFetcher.h"
#import "Photographer.h"

@implementation Photo

// Insert code here to add functionality to your managed object subclass
+(Photo *)photoWithFlickrInfo:(NSDictionary *)photoDictionary
      inManageedObjectContext:(NSManagedObjectContext *)context;
{
    Photo *photo=nil;
    
    NSString *unique=photoDictionary[FLICKR_PHOTO_ID];
    NSFetchRequest *request =[NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    request.predicate=[NSPredicate predicateWithFormat:@"unique = %@",unique];
    
    NSError *error;
    NSArray *matches=[context executeFetchRequest:request error:&error];
    
    if (!matches||error||[matches count]>1) {
        // handle error
    }
    else if ([matches count])
    {
        photo=[matches firstObject];
    }
    else
    {
        photo=[NSEntityDescription insertNewObjectForEntityForName:@"Photo"
                                            inManagedObjectContext:context];
        photo.unique=unique;
        photo.title=[photoDictionary valueForKeyPath:FLICKR_PHOTO_TITLE];
        photo.subtitle=[photoDictionary valueForKey:FLICKR_PHOTO_DESCRIPTION];
        photo.imageURL=[[FlickrFetcher URLforPhoto:photoDictionary format:FlickrPhotoFormatLarge] absoluteString];
        
        NSString *photographerName=[photoDictionary valueForKeyPath:FLICKR_PHOTO_OWNER];
        photo.whoTook=[Photographer  photographerWithName:photographerName
                                 inManageredObjectContext:context];
        
    }
    
    
    return photo;
}

+(void)loadPhotosFromFlickrArray:(NSArray *)photos // of Flickr Dictionary
         inManageedObjectContext:(NSManagedObjectContext *)context
{
    for (NSDictionary *photo in photos) {
        [self photoWithFlickrInfo:photo inManageedObjectContext:context];
    }
}
@end
