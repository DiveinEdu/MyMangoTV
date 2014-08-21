//
//  DetailViewController.m
//  MyMangoTV
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 戴维营教育. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
{
    UITableView *_tableView;
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

- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 60) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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

@end
