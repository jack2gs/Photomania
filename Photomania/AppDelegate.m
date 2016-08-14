//
//  AppDelegate.m
//  Photomania
//
//  Created by Gao Song on 8/11/16.
//  Copyright © 2016 Gao Song. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+MOC.h"
#import "FlickrFetcher.h"
#import "Photo.h"
#import "PhotoDatabaseAvailability.h"

@interface AppDelegate () <NSURLSessionDownloadDelegate>

@property(nonatomic,strong) NSManagedObjectContext *photoDatabaseContext;
@property(nonatomic,strong) NSURLSession *flickrDownloadSession;

@end

#define FLICKR_FTECH @"FLICKR_FTECH"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.photoDatabaseContext=self.mainQueueManagedObjectContext;
    
    [self startFlickrFetch];
    
    return YES;
}

-(void)setPhotoDatabaseContext:(NSManagedObjectContext *)photoDatabaseContext
{
    _photoDatabaseContext=photoDatabaseContext;
    
    NSDictionary *userInfo=self.photoDatabaseContext?@{PhotoDatabaseAvailabilityContext:photoDatabaseContext}:nil;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:PhotoDatabaseAvailabilityNotification
                                                        object:self
                                                      userInfo:userInfo];
}

#pragma mark - NSURLSessionDownloadDelegate

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    if ([downloadTask.taskDescription isEqualToString:FLICKR_FTECH]) {
        NSManagedObjectContext *context=self.photoDatabaseContext;
        
        if (context) {
            NSArray *photos=[self flickrPhotosAtURL:location];
            
            [context performBlock:^{
                [Photo loadPhotosFromFlickrArray:photos inManageedObjectContext:context];
                [context save:NULL];
            }];
        }
    }
}

-(NSArray *)flickrPhotosAtURL:(NSURL *)location
{
    NSArray *photos;
    
    NSData *data=[NSData dataWithContentsOfURL:location];
    NSError *error;
    NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:NSJSONReadingAllowFragments
                                                                          error:&error];
    
    if (!error) {
        NSLog(@"Flickr results=%@",propertyListResults);
       photos = [propertyListResults valueForKeyPath:FLICKR_RESULTS_PHOTOS];
    }
    
    return photos;
}

-(void)startFlickrFetch
{
    [[self flickrDownloadSession] getTasksWithCompletionHandler:^(NSArray<NSURLSessionDataTask *> * _Nonnull dataTasks, NSArray<NSURLSessionUploadTask *> * _Nonnull uploadTasks, NSArray<NSURLSessionDownloadTask *> * _Nonnull downloadTasks) {
        if (![downloadTasks count]) {
            NSURLSessionDownloadTask *task=[self.flickrDownloadSession downloadTaskWithURL:[FlickrFetcher URLforRecentGeoreferencedPhotos]];
            task.taskDescription=FLICKR_FTECH;
            
            [task resume];
       }
       else
       {
           for (NSURLSessionDownloadTask *task in downloadTasks) {
              [task resume];
           }
       }
    }];
}

-(NSURLSession *)flickrDownloadSession
{
    if(!_flickrDownloadSession)
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:FLICKR_FTECH];
            configuration.allowsCellularAccess=NO;
            
            _flickrDownloadSession=[NSURLSession sessionWithConfiguration:configuration
                                                                 delegate:self
                                                            delegateQueue:nil];
        });
    }
    
    return _flickrDownloadSession;
}

@end
