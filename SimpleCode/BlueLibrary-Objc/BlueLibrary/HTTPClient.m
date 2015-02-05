//
//  HTTPClient.m
//  MyLibrary
//
//  Created by Eli Ganem on 8/7/13.
//  Copyright (c) 2013 Eli Ganem. All rights reserved.
//

#import "HTTPClient.h"

@implementation HTTPClient

- (id)getRequest:(NSString*)url
{
    return nil;
}

- (id)postRequest:(NSString*)url body:(NSString*)body
{
    return nil;
}

- (UIImage*)downloadImage:(NSString*)url
{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    return [UIImage imageWithData:data];
}

@end
