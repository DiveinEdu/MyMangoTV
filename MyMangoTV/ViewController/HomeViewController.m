//
//  HomeViewController.m
//  MyMangoTV
//
//  Created by apple on 14-8-19.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "HomeViewController.h"

#import "MyScrollView.h"
#import "MyTipsView.h"

#import "UIImageView+WebCache.h"

#import "CommonTableViewCell.h"
#import "HotView.h"

#import "PublicHeader.h"
#import "Configuration.h"

#import "DVIDataManager.h"
#import "FlashItem.h"
#import "TypeCommendItem.h"
#import "VideoItem.h"

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate, MyScrollViewDelegate, MyScrollViewDataSource>
{
    UITableView *homeTableView;
    
    MyScrollView *bannerView;
    UIPageControl *pageControl;
    
    MyTipsView *tipsView;
    
    NSArray *bannerArray;
}
@end

@implementation HomeViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (UIView *)tableViewHeader
{
    CGRect rect = self.view.frame;
    CGFloat height = 180;
    CGFloat tipHeight = 44;
    CGFloat pageHeight = 20;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, height)];
    headerView.backgroundColor = [UIColor redColor];
    
    //创建头部滚动视图
    bannerView = [[MyScrollView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, height - tipHeight)];
    bannerView.dataSource = self;
    bannerView.delegate = self;
    [headerView addSubview:bannerView];
    
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, height - tipHeight - pageHeight, rect.size.width, pageHeight)];
    
//只在调试模式使用
#ifdef DEBUG
    pageControl.numberOfPages = 10;
#endif
    
    [headerView addSubview:pageControl];
    
    tipsView = [[MyTipsView alloc] initWithFrame:CGRectMake(0, height - tipHeight, rect.size.width, tipHeight)];
    tipsView.image = [UIImage imageNamed:@"HomeActivityBarIcon.png"];
    tipsView.backgroundColor = [UIColor colorWithRed:59.0/255 green:59.0/255 blue:59.0/255 alpha:1.0];
    [tipsView loadData:@[@"又是一条新闻", @"吸毒", @"上映"]];
    [headerView addSubview:tipsView];
    
    return headerView;
}

- (void)createTableView
{
    CGRect rect = self.view.frame;
    homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height - 49) style:UITableViewStylePlain];
    homeTableView.tableHeaderView = [self tableViewHeader];
    homeTableView.dataSource = self;
    homeTableView.delegate = self;
    [self.view addSubview:homeTableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavigationBarLogo.png"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"PlayRecordsIcoGray.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didClickHistory:) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 20, 20);

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    [self createTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRefresh:) name:kRefreshData object:nil];
    
    //获取首页的数据
    [[DVIDataManager sharedManager] flashData];
}

//刷新首页上面的滚动视图
- (void)didRefresh:(NSNotification *)notification
{
    bannerArray = [[DVIDataManager sharedManager] flashData];
    
    [bannerView reloadData];
}

- (void)didClickHistory:(id)sender
{
    NSLog(@"%s", __func__);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
//1
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

//2
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

//4
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *hotIdentifier = @"hot";
    static NSString *varietyIdentifier = @"variety";
    
    CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:hotIdentifier];
    if (cell == nil) {
        cell = [[CommonTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:hotIdentifier];
    }
    
    cell.numberOfViewInCell = ^NSInteger(CommonTableViewCell *cCell){
        return 9;
    };
    
    cell.widthForCell = ^CGFloat(CommonTableViewCell *cCell, NSInteger index){
        return 100.0f;
    };
    
    cell.viewForCell = ^(CommonTableViewCell *cCell, NSInteger index){
        HotView *v = [[HotView alloc] init];
        
        v.imageView.image = [UIImage imageNamed:@"color-wheel-icon.jpg"];
        v.label.text = @"这是一个文字";
        
        return v;
    };
    
    //对于block里面使用外部的一些变量时，进行复制
    __weak typeof(self) weakSelf = self;
    cell.didSelectedView = ^(CommonTableViewCell *cCell, NSInteger index) {
        DetailViewController *detailCtrl = [[DetailViewController alloc] init];
        //当使用push显示的时候，隐藏下面的TabBar
        detailCtrl.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:detailCtrl animated:YES];
    };
    
    [cell reloadData];
    
    return cell;
}

//3
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section % 2) {
        return 200;
    }
    
    return 100.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{//添加section header
    UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    [control addTarget:self action:@selector(didClickSection:) forControlEvents:UIControlEventTouchUpInside];
    control.backgroundColor = [UIColor whiteColor];
    control.tag = section;
    
    UIView *oView = [[UIView alloc] initWithFrame:CGRectMake(8, 4, 4, 42)];
    oView.backgroundColor = [UIColor orangeColor];
    [control addSubview:oView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(16, 0, self.view.frame.size.width - 20, 50)];
    label.font = [UIFont systemFontOfSize:32];
    label.textColor = [UIColor colorWithRed:100.0/255 green:100.0/255 blue:100.0/255 alpha:1.0];
    label.text = @"独家热播";
    [control addSubview:label];
    
    if (section % 2) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HomeMore.png"]];
        imageView.center = CGPointMake(self.view.frame.size.width - 20, 50 / 2);
        [control addSubview:imageView];
    }
    
    return control;
}

- (void)didClickSection:(UIControl *)sender
{
    NSLog(@".....");
}

#pragma mark - MyScrollViewDataSource
- (NSInteger)numberOfPageInScrollView:(MyScrollView *)scrollView
{
    //
    return bannerArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50.0f;
}

- (UIView *)scrollView:(MyScrollView *)scrollView viewAtIndex:(NSInteger)index
{
    FlashItem *item = [bannerArray objectAtIndex:index];
    
    UIImageView *v = [[UIImageView alloc] init];
    [v sd_setImageWithURL:[NSURL URLWithString:item.Pic]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 180 - 44 - 50, self.view.frame.size.width, 50)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    label.text = item.Name;
    [v addSubview:label];
    
    return v;
}

- (void)scrollView:(MyScrollView *)scrollView didSelectAtIndex:(NSInteger)index
{
    NSLog(@"selected: %d", index);
}

- (void)scrollViewDidEndScroll:(MyScrollView *)scrollView
{
    pageControl.currentPage = scrollView.currentPage;
}
@end
