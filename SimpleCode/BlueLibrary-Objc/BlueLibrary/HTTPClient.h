//
//  HTTPClient.h
//  MyLibrary
//
//  Created by Eli Ganem on 8/7/13.
//  Copyright (c) 2013 Eli Ganem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTTPClient : NSObject

- (id)getRequest:(NSString*)url;
- (id)postRequest:(NSString*)url body:(NSString*)body;
- (UIImage*)downloadImage:(NSString*)url;

@end
