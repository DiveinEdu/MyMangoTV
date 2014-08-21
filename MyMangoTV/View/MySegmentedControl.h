//
//  MySegmentedControl.h
//  MyMangoTV
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MySegmentedControl : UIView
@property (nonatomic, copy) NSArray *items;
@property (nonatomic, assign) NSInteger selectedIndex;

@property (nonatomic, strong) void (^didSelectedAtIndex)(MySegmentedControl *, NSInteger);
@end
