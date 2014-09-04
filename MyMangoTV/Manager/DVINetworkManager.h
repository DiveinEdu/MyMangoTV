//
//  DVINetworkManager.h
//  MangoNetwork
//
//  Created by apple on 14-8-26.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVINetworkManager : NSObject

+ (instancetype)sharedManager;

//获取每天最新消息
- (void)getTodayCommend;

//获取直播信息
- (void)getGetLive:(NSDictionary *)dict;

//获取某个频道的视频列表
- (void)getLiveVideoURL:(NSDictionary *)dict;
@end
