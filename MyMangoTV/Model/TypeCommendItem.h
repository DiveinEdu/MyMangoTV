//
//  TypeCommendItem.h
//  MangoNetwork
//
//  Created by apple on 14-8-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TypeCommendItem : NSObject

@property (nonatomic, copy) NSString *TypeName;
@property (nonatomic, assign) int UiPartType;
@property (nonatomic, assign) int PicType;
@property (nonatomic, assign) int MoreLinkStatus;
@property (nonatomic, assign) int MoreLinkType;
@property (nonatomic, assign) int FstlvlId;
@property (nonatomic, assign) int TypeId;
@property (nonatomic, strong) NSArray *PartDatas;
@property (nonatomic, strong) NSArray *SpecialDatas;
@property (nonatomic, strong) NSArray *VideoDatas;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)typeCommendItem:(NSDictionary *)dict;

- (NSArray *)subItems;
@end
