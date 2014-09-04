//
//  TypeCommendItem.m
//  MangoNetwork
//
//  Created by apple on 14-8-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "TypeCommendItem.h"
#import "VideoItem.h"

@implementation TypeCommendItem

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
//        NSMutableArray *parts = [NSMutableArray array];
//        for (NSDictionary *d in self.PartDatas) {
//
//        }
//        self.PartDatas = parts;
//        
//        NSMutableArray *specials = [NSMutableArray array];
//        for (NSDictionary *d in self.SpecialDatas) {
//            
//        }
//        self.SpecialDatas = specials;
        
        NSMutableArray *videos = [NSMutableArray array];
        for (NSDictionary *d in self.VideoDatas) {
            VideoItem *item = [VideoItem videoItem:d];
            [videos addObject:item];
        }
        self.VideoDatas = videos;
    }
    
    return self;
}

+ (instancetype)typeCommendItem:(NSDictionary *)dict
{
    return [[TypeCommendItem alloc] initWithDict:dict];
}

- (NSArray *)subItems
{
    if (self.PartDatas.count > 0) {
        return self.PartDatas;
    }
    
    if (self.VideoDatas.count > 0) {
        return self.VideoDatas;
    }
    
    return self.SpecialDatas;
}
@end
