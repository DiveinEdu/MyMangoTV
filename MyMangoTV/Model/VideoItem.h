//
//  VideoItem.h
//  MangoNetwork
//
//  Created by apple on 14-8-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoItem : NSObject

@property (nonatomic, assign) int FstlvlId;
@property (nonatomic, copy) NSString *Vname;
@property (nonatomic, copy) NSString *Pic;
@property (nonatomic, copy) NSString *Dur;
@property (nonatomic, copy) NSString *PlayUrl;
@property (nonatomic, copy) NSString *PublishTime;
@property (nonatomic, copy) NSString *SndlvlDesc;

- (id)initWithDict:(NSDictionary *)dict;

+ (instancetype)videoItem:(NSDictionary *)dict;
@end
