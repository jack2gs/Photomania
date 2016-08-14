//
//  CoreDataTableViewController.m
//  Photomania
//
//  Created by Gao Song on 8/14/16.
//  Copyright © 2016 Gao Song. All rights reserved.
//

#import "CoreDataTableViewController.h"

@interface CoreDataTableViewController () <NSFetchedResultsControllerDelegate>

@end

@implementation CoreDataTableViewController

-(void)performFetch
{
    NSError *error;
    BOOL success = [self.fetchedResultsController performFetch:&error];
    
    if (!success) {
        NSLog(@"Error happened during performing fetch.");
    }
    
    [self.tableView reloadData];
}

-(void)setFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    if (fetchedResultsController!=_fetchedResultsController) {
        _fetchedResultsController=fetchedResultsController;
        _fetchedResultsController.delegate=self;
        
        self.title=_fetchedResultsController.fetchRequest.entityName;
        
        [self performFetch];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    if ([[self.fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    } else
        return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([[self.fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo name];
    } else
        return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [self.fetchedResultsController sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [self.fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}
#pragma mark - NSFetchedResultsControllerDelegate
// called after fetched results controller received a content change notification
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    [self.tableView reloadData];
}

@end
