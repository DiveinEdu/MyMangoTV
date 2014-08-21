//
//  MyTabBarItem.h
//  CustomTabBarApp2
//
//  Created by apple on 14-8-18.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTabBarItem : NSObject
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIImage *selectedImage;

- (id)initWithImage:(UIImage *)image title:(NSString *)title;
@end
