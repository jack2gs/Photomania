//
//  PhotographerCDTVC.m
//  Photomania
//
//  Created by Gao Song on 8/14/16.
//  Copyright © 2016 Gao Song. All rights reserved.
//

#import "PhotographerCDTVC.h"
#import "Photographer.h"
#import "PhotoDatabaseAvailability.h"

@interface PhotographerCDTVC ()

@end

@implementation PhotographerCDTVC


-(void)awakeFromNib
{
    [[NSNotificationCenter defaultCenter] addObserverForName:PhotoDatabaseAvailabilityNotification
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification * _Nonnull note) {
                                                      self.managedObjectContext=note.userInfo[PhotoDatabaseAvailabilityContext];
    }];
}


-(void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    _managedObjectContext=managedObjectContext;
    
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Photographer"];
    request.predicate=nil;
    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"name"
                                                            ascending:YES
                               selector:@selector(localizedStandardCompare:)]];
    
    self.fetchedResultsController=[[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                      managedObjectContext:_managedObjectContext
                                                                        sectionNameKeyPath:nil
                                                                                 cacheName:nil];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[self.tableView dequeueReusableCellWithIdentifier:@"Photographer Cell" forIndexPath:indexPath];
    
    Photographer *photograper=[self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text=photograper.name;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%ld",photograper.photos.count];
    
    return cell;
}

@end
