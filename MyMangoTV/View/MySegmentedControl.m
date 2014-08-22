//
//  MySegmentedControl.m
//  MyMangoTV
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "MySegmentedControl.h"

@implementation MySegmentedControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setItems:(NSArray *)items
{
    _items = [items copy];
    
    [self createTitles];
}

- (void)createTitles
{
    CGFloat width = self.frame.size.width / _items.count;
    
    for (int i = 0; i < _items.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:_items[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:@"SegmentBackground.png"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"SegmentBackgroundSelected.png"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(didClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        btn.frame = CGRectMake(width * i, 0, width, self.frame.size.height);
        
        [self addSubview:btn];
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    
    UIButton *btn = nil;
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:[UIButton class]] && (v.tag == selectedIndex)) {
            btn = (UIButton *)v;
            break;
        }
    }
    
    [self didClicked:btn];
}

- (void)didClicked:(UIButton *)sender
{
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)v;
            btn.selected = NO;
        }
    }
    
    sender.selected = YES;
    _selectedIndex = sender.tag;
    
    if (_didSelectedAtIndex) {
        _didSelectedAtIndex(self, sender.tag);
    }
}
@end
