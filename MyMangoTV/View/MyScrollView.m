//
//  MyScrollView.m
//  PageScrollApp
//
//  Created by apple on 14-8-19.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "MyScrollView.h"

@interface MyScrollView () <UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
}
@end

@implementation MyScrollView

@synthesize currentPage = _currentPage;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)didTap:(UITapGestureRecognizer *)recognizer
{
    if (_delegate && [_delegate respondsToSelector:@selector(scrollView:didSelectAtIndex:)]) {
        NSInteger index = _scrollView.contentOffset.x / _scrollView.frame.size.width;
        [_delegate scrollView:self didSelectAtIndex:index];
    }
}

- (void)setDataSource:(id<MyScrollViewDataSource>)dataSource
{
    _dataSource = dataSource;
    
    [self reloadData];
}

- (void)reloadData
{
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSInteger count = [_dataSource numberOfPageInScrollView:self];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    _scrollView.contentSize = CGSizeMake(width * count, height);
    
    for (NSInteger i = 0; i < count; i++) {
        UIView *view = [_dataSource scrollView:self viewAtIndex:i];
        view.frame = CGRectMake(i * width, 0, width, height);
        [_scrollView addSubview:view];
    }
}

- (NSInteger)currentPage
{
    return _scrollView.contentOffset.x / _scrollView.frame.size.width;
}

- (void)setCurrentPage:(NSInteger)currentPage
{
    _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width * currentPage, 0);
    _currentPage = currentPage;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        if (_delegate && [_delegate respondsToSelector:@selector(scrollViewDidEndScroll:)]) {
            [_delegate scrollViewDidEndScroll:self];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_delegate && [_delegate respondsToSelector:@selector(scrollViewDidEndScroll:)]) {
        [_delegate scrollViewDidEndScroll:self];
    }
}
@end
