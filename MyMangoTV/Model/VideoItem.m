//
//  VideoItem.m
//  MangoNetwork
//
//  Created by apple on 14-8-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "VideoItem.h"

@implementation VideoItem

- (id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (instancetype)videoItem:(NSDictionary *)dict
{
    return [[VideoItem alloc] initWithDict:dict];
}
@end
