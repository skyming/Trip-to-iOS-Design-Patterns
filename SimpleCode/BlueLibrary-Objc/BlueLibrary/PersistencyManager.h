//
//  PersistencyManager.h
//  BlueLibrary
//
//  Created by skyming on 15/1/30.
//  Copyright (c) 2015年 Eli Ganem. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Album;

@interface PersistencyManager : NSObject

- (NSArray*)getAlbums;
- (void)addAlbum:(Album*)album atIndex:(NSInteger)index;
- (void)deleteAlbumAtIndex:(NSInteger)index;

- (void)saveImage:(UIImage*)image filename:(NSString*)filename;
- (UIImage*)getImage:(NSString*)filename;

- (void)saveAlbums;

@end
