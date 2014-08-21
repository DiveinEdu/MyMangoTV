//
//  HotView.m
//  MyMangoTV
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "HotView.h"

@implementation HotView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] init];
//        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_imageView];
        
        _label = [[UILabel alloc] init];
        _label.numberOfLines = 2;
        [self addSubview:_label];
    }
    return self;
}

//0. 不能手动调用！！！
//1. 改变它的frame/bounds的时候
//2. 调用它的setNeedsLayout
//3. addSubview:将它添加到父视图上时
//4. 父视图的frame/bounds改变的时候
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 30);
    _label.frame = CGRectMake(0, self.frame.size.height - 30, self.frame.size.width, 30);
}
@end
