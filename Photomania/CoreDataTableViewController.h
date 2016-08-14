//
//  CoreDataTableViewController.h
//  Photomania
//
//  Created by Gao Song on 8/14/16.
//  Copyright © 2016 Gao Song. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CoreDataTableViewController : UITableViewController

@property(strong,nonatomic) NSFetchedResultsController *fetchedResultsController;

-(void)performFetch;

@end
