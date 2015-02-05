//
//  PersistencyManager.m
//  BlueLibrary
//
//  Created by skyming on 15/1/30.
//  Copyright (c) 2015年 Eli Ganem. All rights reserved.
//

#import "PersistencyManager.h"
#import "Album.h"

@interface PersistencyManager () {
    // an array of all albums
    NSMutableArray *albums;
}

@end

@implementation PersistencyManager

- (id)init

{
    
    self = [super init];
    
    if (self) {
        
        NSData *data = [NSData dataWithContentsOfFile:[NSHomeDirectory() stringByAppendingString:@"/Documents/albums.bin"]];
        albums = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        if (albums == nil)
        {
            albums = [NSMutableArray arrayWithArray:
                      @[[[Album alloc] initWithTitle:@"Best of Bowie" artist:@"David Bowie" coverUrl:@"http://b.hiphotos.baidu.com/image/pic/item/79f0f736afc3793133040dc5e9c4b74542a911e9.jpg" year:@"1992"],
                        
                        [[Album alloc] initWithTitle:@"It's My Life" artist:@"No Doubt" coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_no%20doubt_its%20my%20life%20%20bathwater.png" year:@"2003"],
                        
                        [[Album alloc] initWithTitle:@"Nothing Like The Sun" artist:@"Sting" coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_sting_nothing%20like%20the%20sun.png" year:@"1999"],
                        
                        [[Album alloc] initWithTitle:@"Staring at the Sun" artist:@"U2" coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_u2_staring%20at%20the%20sun.png" year:@"2000"],
                        
                        [[Album alloc] initWithTitle:@"American Pie" artist:@"Madonna" coverUrl:@"http://www.coversproject.com/static/thumbs/album/album_madonna_american%20pie.png" year:@"2000"]]];
            
            [self saveAlbums];
        }
    }
    return self;
}

- (NSArray*)getAlbums
{
    return albums;
}

- (void)addAlbum:(Album*)album atIndex:(NSInteger)index
{
    if (albums.count >= index)
        [albums insertObject:album atIndex:index];
    else
        [albums addObject:album];
}

- (void)deleteAlbumAtIndex:(NSInteger)index
{
    [albums removeObjectAtIndex:index];
}

- (void)saveImage:(UIImage*)image filename:(NSString*)filename
{
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
    NSData *data = UIImagePNGRepresentation(image);
    [data writeToFile:filename atomically:YES];
}

- (UIImage*)getImage:(NSString*)filename
{
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
    NSData *data = [NSData dataWithContentsOfFile:filename];
    return [UIImage imageWithData:data];
}

- (void)saveAlbums
{
    NSString *filename = [NSHomeDirectory() stringByAppendingString:@"/Documents/albums.bin"];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:albums];
    [data writeToFile:filename atomically:YES];
}
@end
