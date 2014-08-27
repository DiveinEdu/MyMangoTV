//
//  FlashItem.m
//  MangoNetwork
//
//  Created by apple on 14-8-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "FlashItem.h"

@implementation FlashItem

- (id)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (instancetype)flashItem:(NSDictionary *)dict
{
    return [[FlashItem alloc] initWithDictionary:dict];
}
@end
