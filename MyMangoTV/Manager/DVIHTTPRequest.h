//
//  DVIHTTPRequest.h
//  MangoNetwork
//
//  Created by apple on 14-8-26.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <Foundation/Foundation.h>


//URL/Method/Parameter
@interface DVIHTTPRequest : NSObject

@property (nonatomic, copy, readonly) NSString *path;
@property (nonatomic, copy) NSString *method;
@property (nonatomic, strong) NSDictionary *paramter;
@property (nonatomic, strong) NSDictionary *headerFields;

@property (nonatomic, copy) void (^errorHandler)(DVIHTTPRequest *, NSError *);
@property (nonatomic, copy) void (^dataHandler)(DVIHTTPRequest *, NSData *);

- (instancetype)initWithURL:(NSString *)path;

- (void)start;
- (void)cancel;
@end
