//
//  LibraryAPI.m
//  BlueLibrary
//
//  Created by skyming on 15/1/30.
//  Copyright (c) 2015年 Eli Ganem. All rights reserved.
//

#import "LibraryAPI.h"
#import "Album.h"
#import "PersistencyManager.h"
#import "HTTPClient.h"

@interface LibraryAPI () {
    PersistencyManager *persistencyManager;
    HTTPClient *httpClient;
    BOOL isOnline;
    
}
@end

@implementation LibraryAPI
+ (LibraryAPI*)sharedInstance
{
    // 1
    static LibraryAPI *_sharedInstance = nil;
    
    // 2
    static dispatch_once_t oncePredicate;
    
    // 3
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[LibraryAPI alloc] init];
    });
    return _sharedInstance;
}

- (id)init{
    self = [super init];
    
    if (self) {
        
        persistencyManager = [[PersistencyManager alloc] init];
        
        httpClient = [[HTTPClient alloc] init];
        
        isOnline = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadImage:) name:@"BLDownloadImageNotification" object:nil];
    }
    
    return self;
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


-(NSArray*)getAlbums
{
    return [persistencyManager getAlbums];
}

- (void)addAlbum:(Album*)album atIndex:(NSInteger)index
{
    [persistencyManager addAlbum:album atIndex:index];
    
    if (isOnline)
    {
        [httpClient postRequest:@"/api/addAlbum" body:[album description]];
    }
    
}

- (void)deleteAlbumAtIndex:(NSInteger)index
{
    [persistencyManager deleteAlbumAtIndex:index];
    
    if (isOnline)
    {
        [httpClient postRequest:@"/api/deleteAlbum" body:[@(index) description]];
    }
    
}

- (void)downloadImage:(NSNotification*)notification
{
    
    // 1
    UIImageView *imageView = notification.userInfo[@"imageView"];
    NSString *coverUrl = notification.userInfo[@"coverUrl"];
    
    // 2
    imageView.image = [persistencyManager getImage:[coverUrl lastPathComponent]];
    if (imageView.image == nil)
    {
        // 3
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
            UIImage *image = [httpClient downloadImage:coverUrl];
    
            // 4
            dispatch_sync(dispatch_get_main_queue(), ^{
                imageView.image = image;
                [persistencyManager saveImage:image filename:[coverUrl lastPathComponent]];
//                NSLog(@"Add 内存:%p %p",imageView,imageView.image);
            });
            

        });
    }
}

- (void)saveAlbums
{
    [persistencyManager saveAlbums];
}

@end
