//
//  Photographer.m
//  Photomania
//
//  Created by Gao Song on 8/11/16.
//  Copyright © 2016 Gao Song. All rights reserved.
//

#import "Photographer.h"
#import "Photo.h"

@implementation Photographer

// Insert code here to add functionality to your managed object subclass
+(Photographer *)photographerWithName:(NSString *)name
             inManageredObjectContext:(NSManagedObjectContext *)context
{
    Photographer *photographer=nil;
    
    if (name.length) {
        NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Photographer"];
        request.predicate=[NSPredicate predicateWithFormat:@"name = %@",name];
        
        NSError *error;
        NSArray *matchs=[context executeFetchRequest:request
                                               error:&error];
        
        if (!matchs||error||[matchs count] > 1) {
            // handle error
        }
        else if([matchs count])
        {
            photographer=[matchs firstObject];
        }
        else
        {
            photographer=[NSEntityDescription insertNewObjectForEntityForName:@"Photographer"
                                                       inManagedObjectContext:context];
            photographer.name=name;
        }
            
    }
    
    return photographer;
}
@end
