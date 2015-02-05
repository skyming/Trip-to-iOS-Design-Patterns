//
//  Album+TableRepresentation.m
//  BlueLibrary
//
//  Created by skyming on 15/1/30.
//  Copyright (c) 2015年 Eli Ganem. All rights reserved.
//

#import "Album+TableRepresentation.h"

@implementation Album (TableRepresentation)

- (NSDictionary*)tr_tableRepresentation
{
    return @{@"titles":@[@"Artist", @"Album", @"Genre", @"Year"],
             @"values":@[self.artist, self.title, self.genre, self.year]};
}

@end
