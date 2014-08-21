//
//  MyTipsView.h
//  TipsBannerApp
//
//  Created by apple on 14-8-20.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTipsView : UIView
@property (nonatomic, strong) UIImage *image;

- (void)loadData:(NSArray *)titles;

- (void)scrollTips;
@end
