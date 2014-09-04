//
//  DVINetworkManager.m
//  MangoNetwork
//
//  Created by apple on 14-8-26.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVINetworkManager.h"

#import "DVIHTTPRequest.h"
#import "Configuration.h"

typedef void(^DataHandlerType)(DVIHTTPRequest *request, NSData *data);

@interface DVINetworkManager ()
{
    NSMutableArray *_requestArray;
}
@end

@implementation DVINetworkManager

+ (instancetype)sharedManager
{
    static DVINetworkManager *shareInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[DVINetworkManager alloc] init];
    });
    
    return shareInstance;
}

- (instancetype)init
{
    if (self = [super init]) {
        _requestArray = [NSMutableArray array];
    }
    
    return self;
}

- (void)startRequest:(NSString *)path method:(NSString *)method paramter:(NSDictionary *)paramter handler:(DataHandlerType)dataHandler
{
    DVIHTTPRequest *request = [[DVIHTTPRequest alloc] initWithURL:path];
    request.method = method;
    request.paramter = paramter;
    
    request.dataHandler = dataHandler;
    
    [_requestArray addObject:request];
    [request start];
}

- (void)getTodayCommend
{
    NSDictionary *dict = @{@"ClientName":@"IPhone"};
    
    __weak typeof(_requestArray) WeakArray = _requestArray;
    
    //开始下载今天的内容
    [self startRequest:kGetTodayCommendURL
                method:@"GET"
              paramter:dict
               handler:^(DVIHTTPRequest *request, NSData *data){
        
        //下载完成后发送通知将数据传递出去
        [[NSNotificationCenter defaultCenter] postNotificationName:kGetTodayCommend object:nil userInfo:@{@"data":data}];
        
        [WeakArray removeObject:request];
    }];
}

- (void)getGetLive:(NSDictionary *)dict
{
    __weak typeof(_requestArray) WeakArray = _requestArray;
    [self startRequest:kGetLiveURL
                method:@"GET"
              paramter:dict
               handler:^(DVIHTTPRequest *request, NSData *data) {
                   //下载完成后发送通知将数据传递出去
                   [[NSNotificationCenter defaultCenter] postNotificationName:kGetTVLive object:nil userInfo:@{@"data":data}];
                   
                   [WeakArray removeObject:request];
    }];
}

- (void)getLiveVideoURL:(NSDictionary *)dict
{
    __weak typeof(_requestArray) WeakArray = _requestArray;
    [self startRequest:kGetLiveVideoURL method:@"GET" paramter:dict handler:^(DVIHTTPRequest *request, NSData *data) {
        //下载完成后发送通知将数据传递出去
        [[NSNotificationCenter defaultCenter] postNotificationName:kGetLiveVideo object:nil userInfo:@{@"data":data}];
        
        [WeakArray removeObject:request];
    }];
}
@end
