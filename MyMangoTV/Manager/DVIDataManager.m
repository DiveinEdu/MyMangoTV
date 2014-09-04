//
//  DVIDataManager.m
//  MangoNetwork
//
//  Created by apple on 14-8-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DVIDataManager.h"
#import "DVINetworkManager.h"

#import "Configuration.h"

#import "FlashItem.h"
#import "VideoItem.h"
#import "TypeCommendItem.h"

#import "NSString+URL.h"

@interface DVIDataManager ()
{
    NSArray *_flashData;
    NSArray *_typeCommendData;
    
    NSString *_channelName;
    NSArray *_liveVideoURL;
}
@end

@implementation DVIDataManager

+ (instancetype)sharedManager
{
    static DVIDataManager *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[DVIDataManager alloc] init];
    });
    
    return sharedInstance;
}

- (id)init
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetTodayCommend:) name:kGetTodayCommend object:nil];
    }
    
    return self;
}

- (NSArray *)flashData:(BOOL)refresh
{
    if (_flashData == nil || refresh) {
        [[DVINetworkManager sharedManager] getTodayCommend];
        
    }
    
    return _flashData;
}

- (NSArray *)commendData
{
    if (_typeCommendData == nil) {
        [[DVINetworkManager sharedManager] getTodayCommend];
    }
    
    return _typeCommendData;
}

- (void)didGetTodayCommend:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    NSData *data = [userInfo objectForKey:@"data"];
    
    //将todayCommend的数据从JSON字符串转化为OC的字典
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    //将数据从OC的基本数据类型转换自定义的数据类型，方便编译器进行提示和类型检查
    NSArray *flashArray = dict[@"FlashData"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *d in flashArray) {
        FlashItem *item = [FlashItem flashItem:d];
        [array addObject:item];
    }
    _flashData = array;
    
    NSArray *typeArray = dict[@"TypeCommendData"];
    NSMutableArray *commendArray = [NSMutableArray array];
    for (NSDictionary *d in typeArray) {
        TypeCommendItem *item = [[TypeCommendItem alloc] initWithDict:d];
        [commendArray addObject:item];
    }
    _typeCommendData = commendArray;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshData object:nil];
}

- (NSArray *)liveVideoURL:(NSString *)name
{
    if ([name isEqualToString:_channelName]) {
        return _liveVideoURL;
    }
    
    //到这里添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didGetLiveVideo:) name:kGetLiveVideo object:nil];
    
    NSString *encodedName = [name urlEncode];
    NSDictionary *dict = @{@"ChannelName":encodedName};
    [[DVINetworkManager sharedManager] getLiveVideoURL:dict];
    return nil;
}

- (void)didGetLiveVideo:(NSNotification *)notification
{
    NSLog(@"%@", [[NSString alloc] initWithData:[notification.userInfo objectForKey:@"data"] encoding:NSUTF8StringEncoding]);
    //处理数据....
    [[NSNotificationCenter defaultCenter] postNotificationName:kRefreshLiveVideo object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:kGetLiveVideo];
}
@end
