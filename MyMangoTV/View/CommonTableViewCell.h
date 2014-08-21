//
//  CommonTableViewCell.h
//  MyMangoTV
//
//  Created by apple on 14-8-20.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonTableViewCell : UITableViewCell
{
    UIScrollView *_scrollView;
}

@property (nonatomic, strong) NSInteger (^numberOfViewInCell)(CommonTableViewCell *);
@property (nonatomic, strong) CGFloat (^widthForCell)(CommonTableViewCell *, NSInteger);
@property (nonatomic, strong) UIView *(^viewForCell)(CommonTableViewCell *, NSInteger);
@property (nonatomic, strong) void (^didSelectedView)(CommonTableViewCell *, NSInteger);

- (void)reloadData;
@end
