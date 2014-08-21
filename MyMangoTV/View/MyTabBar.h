//
//  MyTabBar.h
//  CustomTabBarApp2
//
//  Created by apple on 14-8-18.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyTabBar;

@protocol MyTabBarDelegate <NSObject>

@optional
- (void)tabBar:(MyTabBar *)tabBar didSelectIndex:(NSInteger)index;

@end

@interface MyTabBar : UIView

@property (nonatomic, assign) int selectedIndex;

@property (nonatomic, strong) UIImage *backgroundImage;

@property (nonatomic, copy) NSArray *items;
@property (nonatomic, weak) id<MyTabBarDelegate> delegate;
@end
