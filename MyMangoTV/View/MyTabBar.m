//
//  MyTabBar.m
//  CustomTabBarApp2
//
//  Created by apple on 14-8-18.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "MyTabBar.h"
#import "MyTabBarItem.h"

@interface MyTabBar ()
{
    UIImageView *bgView;
    NSMutableArray *btnArray;
}
@end

@implementation MyTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        bgView = [[UIImageView alloc] initWithFrame:self.bounds];
        bgView.image = [UIImage imageNamed:@"TabBarBackground.png"];
        [self addSubview:bgView];
        
        btnArray = [NSMutableArray array];
    }
    return self;
}

- (void)setSelectedIndex:(int)selectedIndex
{
    UIButton *btn = btnArray[selectedIndex];
    [self didClicked:btn];
    
    _selectedIndex = selectedIndex;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
    bgView.image = backgroundImage;
    _backgroundImage = backgroundImage;
}

- (void)setItems:(NSArray *)items
{
    //CoreGraphics
    CGFloat width = self.frame.size.width / items.count;
    
    for (int i = 0; i < items.count; i++) {
        MyTabBarItem *item = [items objectAtIndex:i];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:item.image forState:UIControlStateNormal];
        [btn setBackgroundImage:item.selectedImage forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(didClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(i * width, 0, width, self.frame.size.height);
        btn.tag = i;
        [self addSubview:btn];
        
        [btnArray addObject:btn];
    }
    
    _items = [items copy];
}

- (void)didClicked:(UIButton *)sender
{
    for (UIButton *btn in btnArray) {
        btn.selected = NO;
    }
    
    sender.selected = YES;
    
    if (_delegate && [_delegate respondsToSelector:@selector(tabBar:didSelectIndex:)]) {
        [_delegate tabBar:self didSelectIndex:sender.tag];
    }
}
@end
