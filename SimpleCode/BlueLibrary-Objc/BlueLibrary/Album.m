//
//  Album.m
//  BlueLibrary
//
//  Created by skyming on 15/1/30.
//  Copyright (c) 2015年 Eli Ganem. All rights reserved.
//

#import "Album.h"

@implementation Album
- (id)initWithTitle:(NSString*)title artist:(NSString*)artist coverUrl:(NSString*)coverUrl
               year:(NSString*)year {
    self = [super init];
    if (self)
    {
        _title = title;
        _artist = artist;
        _coverUrl = coverUrl;
        _year = year;
        _genre = @"Pop";
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder

{
    
    [aCoder encodeObject:self.year forKey:@"year"];
    
    [aCoder encodeObject:self.title forKey:@"album"];
    
    [aCoder encodeObject:self.artist forKey:@"artist"];
    
    [aCoder encodeObject:self.coverUrl forKey:@"cover_url"];
    
    [aCoder encodeObject:self.genre forKey:@"genre"];
    
}

- (id)initWithCoder:(NSCoder *)aDecoder

{
    
    self = [super init];
    
    if (self)
        
    {
        
        _year = [aDecoder decodeObjectForKey:@"year"];
        
        _title = [aDecoder decodeObjectForKey:@"album"];
        
        _artist = [aDecoder decodeObjectForKey:@"artist"];
        
        _coverUrl = [aDecoder decodeObjectForKey:@"cover_url"];
        
        _genre = [aDecoder decodeObjectForKey:@"genre"];
        
    }
    
    return self;
    
}
@end
