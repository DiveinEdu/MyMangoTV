//
//  MyScrollView.h
//  PageScrollApp
//
//  Created by apple on 14-8-19.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyScrollView;

@protocol MyScrollViewDataSource <NSObject>

@required
- (NSInteger)numberOfPageInScrollView:(MyScrollView *)scrollView;
- (UIView *)scrollView:(MyScrollView *)scrollView viewAtIndex:(NSInteger)index;

@end

@protocol MyScrollViewDelegate <NSObject>

@optional
- (void)scrollView:(MyScrollView *)scrollView didSelectAtIndex:(NSInteger)index;
- (void)scrollViewDidEndScroll:(MyScrollView *)scrollView;
@end

@interface MyScrollView : UIView
@property (nonatomic, weak) id<MyScrollViewDataSource> dataSource;
@property (nonatomic, weak) id<MyScrollViewDelegate> delegate;
@property (nonatomic, assign) NSInteger currentPage;

- (void)reloadData;
@end
