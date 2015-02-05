//
//  LibraryAPI.h
//  BlueLibrary
//
//  Created by skyming on 15/1/30.
//  Copyright (c) 2015年 Eli Ganem. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Album;

@interface LibraryAPI : NSObject
+ (LibraryAPI*)sharedInstance;

- (NSArray*)getAlbums;
- (void)addAlbum:(Album*)album atIndex:(NSInteger)index;
- (void)deleteAlbumAtIndex:(NSInteger)index;

- (void)saveAlbums;
@end
