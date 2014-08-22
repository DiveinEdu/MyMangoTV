//
//  CommonTableViewCell.m
//  MyMangoTV
//
//  Created by apple on 14-8-20.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "CommonTableViewCell.h"

@interface CommonTableViewCell ()
{
    NSMutableArray *_cellWdiths;
}
@end

@implementation CommonTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:_scrollView];
        
        //用来保存cell上视图的宽度
        _cellWdiths = [NSMutableArray array];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
        [_scrollView addGestureRecognizer:tap];
    }
    return self;
}

- (void)didTap:(UITapGestureRecognizer *)recognizer
{
    //获取手势在_scrollView上的位置
    CGPoint point = [recognizer locationInView:_scrollView];//已经将偏移量计算在内
//    CGPoint offset = _scrollView.contentOffset;
    
    CGFloat x = point.x;// + offset.x;
    for (int i = 0; i < _cellWdiths.count; i++) {
        NSNumber *w = _cellWdiths[i];
        x -= [w floatValue];
        if (x < 0) {
            if (_didSelectedView) {
                _didSelectedView(self, i);
            }
            break;
        }
    }
}

//从xib文件或storyboard创建时自动调用
- (void)awakeFromNib
{
    // Initialization code
}

//选中cell的时候调用
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)reloadData
{
    //将scrollView上的所有子视图都移除掉
    [_scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //获取cell上视图的总数
    NSInteger count = _numberOfViewInCell(self);
    
    CGFloat width = 0.0f;
    for (int i = 0; i < count; i++) {
        //获取每个视图的宽度
        CGFloat tmp = _widthForCell(self, i);
        //根据宽度计算scrollView的contentSize
        width += tmp;
        
        //保存每个视图的宽度
        [_cellWdiths addObject:[NSNumber numberWithFloat:tmp]];
    }
    
    //设置contentSize
    _scrollView.contentSize = CGSizeMake(width, self.frame.size.height);
    
    CGFloat x = 0;
    for (int i = 0; i < count; i++) {
        //获取每个位置的视图
        UIView *v = _viewForCell(self, i);
        
        //获取每个视图的宽度
        NSNumber *w = _cellWdiths[i];
        //设置第i个视图的位置和尺寸
        v.frame = CGRectMake(x, 0, [w floatValue], self.frame.size.height);
        x += [w floatValue];
        
        //在cell上显示视图
        [_scrollView addSubview:v];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _scrollView.frame = self.bounds;
    
    [self reloadData];
}
@end
