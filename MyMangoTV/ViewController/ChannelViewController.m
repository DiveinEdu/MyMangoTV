//
//  ChannelViewController.m
//  MyMangoTV
//
//  Created by apple on 14-8-19.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "ChannelViewController.h"

#import "CommonTableViewCell.h"
#import "CategoryView.h"

#import "DVIDataManager.h"

@interface ChannelViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_categoryArray;
}
@end

@implementation ChannelViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    [_tableView registerClass:[CommonTableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _categoryArray = @[@"综艺", @"新闻", @"电视剧", @"电影", @"音乐", @"动画片", @"出品方", @"爱芒果", @"VIP专区", @"花儿与少年"];
    
    [self createTableView];
    
    [[DVIDataManager sharedManager] liveVideoURL:@"贵州卫视"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_categoryArray.count % 3) {
        return _categoryArray.count / 3 + 1;
    }
    
    return _categoryArray.count / 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    
    //先取可重用的cell，如果没有则自动创建
    CommonTableViewCell *cell = (CommonTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];

    //获取tableView的行数
    int rowCount = [self tableView:nil numberOfRowsInSection:0];
    int count = (rowCount == (indexPath.row + 1))?(_categoryArray.count%3):3;

    //每个Cell里View的数目
    cell.numberOfViewInCell = ^(CommonTableViewCell *sender){
        return count;
    };
    //设置每个视图的宽度
    cell.widthForCell = ^CGFloat(CommonTableViewCell *sender, NSInteger index){
        return 100;
    };
    //返回每个视图的对象
    cell.viewForCell = ^(CommonTableViewCell *sender, NSInteger index) {
        CategoryView *v = [[CategoryView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        v.imageView.image = [UIImage imageNamed:@"CartoonIcon.png"];

        v.label.text = _categoryArray[indexPath.row * 3 + index];
        
        return v;
    };
    //选取一个类别
    cell.didSelectedView = ^(CommonTableViewCell *cell, NSInteger index){
        NSLog(@"%@", _categoryArray[indexPath.row * 3 + index]);
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
@end
