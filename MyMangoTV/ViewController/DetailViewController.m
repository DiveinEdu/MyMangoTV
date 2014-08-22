//
//  DetailViewController.m
//  MyMangoTV
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DetailViewController.h"

#import "MySegmentedControl.h"

@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    
    NSArray *_longArray;
    NSArray *_shortArray;
    
    MySegmentedControl *segmented;
}
@end

@implementation DetailViewController

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
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    
    segmented = [[MySegmentedControl alloc] initWithFrame:CGRectMake(0, 100 - 40, self.view.frame.size.width, 40)];
    segmented.items = @[@"整片", @"短片"];
    segmented.selectedIndex = 0;
    
    __weak typeof(_tableView) WeakTableView = _tableView;
    //Capture，捕获
    segmented.didSelectedAtIndex = ^(MySegmentedControl *sender, NSInteger index){
        [WeakTableView reloadData];
    };
    [headerView addSubview:segmented];
    return headerView;
}

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 60) style:UITableViewStylePlain];
    _tableView.tableHeaderView = [self tableViewHeader];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _longArray = @[@"爸爸去哪",@"古剑男神", @"仙剑女神", @"李易峰"];
    _shortArray = @[@"周大福", @"周大生", @"周生生"];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(didBack:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"NavigationBarBackBackground.png"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 10, 40);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"《我的纪录片》 古剑男神女神";
    label.frame = CGRectMake(0, 0, 80, 40);
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    
    UIButton *infoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [infoBtn addTarget:self action:@selector(didShowInfo:) forControlEvents:UIControlEventTouchUpInside];
    [infoBtn setImage:[UIImage imageNamed:@"ColumnDetailIcon.png"] forState:UIControlStateNormal];
    infoBtn.frame = CGRectMake(0, 0, 40, 40);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoBtn];
    
    //创建tableView
    [self createTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didShowInfo:(id)sender
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (segmented.selectedIndex == 0)
    {
        return _longArray.count;
    }
    else
    {
        return _shortArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    //检查是否有可以重用cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        //创建cell
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (segmented.selectedIndex == 0) {
        cell.textLabel.text = _longArray[indexPath.row];
    }
    else {
        cell.textLabel.text = _shortArray[indexPath.row];
    }
    
    return cell;
}
@end
