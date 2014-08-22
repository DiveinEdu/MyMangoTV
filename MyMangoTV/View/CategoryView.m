//
//  CategoryView.m
//  MyMangoTV
//
//  Created by apple on 14-8-22.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "CategoryView.h"

@implementation CategoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _imageView.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        [self addSubview:_imageView];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 40, frame.size.width, 40)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor whiteColor];
        [self addSubview:_label];
        
        _vipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - 39, 0, 39, 36)];
        [self addSubview:_vipImageView];
    }
    return self;
}

@end
