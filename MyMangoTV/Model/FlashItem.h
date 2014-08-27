//
//  FlashItem.h
//  MangoNetwork
//
//  Created by apple on 14-8-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <Foundation/Foundation.h>

//model class／模型类

@interface FlashItem : NSObject

@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *Pic;
@property (nonatomic, copy) NSString *Type;
@property (nonatomic, copy) NSString *Url;

- (id)initWithDictionary:(NSDictionary *)dict;

+ (instancetype)flashItem:(NSDictionary *)dict;
@end
