//
//  DVIDataManager.h
//  MangoNetwork
//
//  Created by apple on 14-8-27.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVIDataManager : NSObject

+ (instancetype)sharedManager;

- (NSArray *)flashData:(BOOL)refresh;
- (NSArray *)commendData;

- (NSArray *)liveVideoURL:(NSString *)name;
@end
