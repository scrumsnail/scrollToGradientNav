//
//  ViewController.m
//  ScrollToGradientNavColor
//
//  Created by allthings_LuYD on 16/8/8.//
//  Copyright © 2016年 scrum_snail. All rights reserved.
//

#import "ViewController.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIImageView * _topImageView;
}
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat topContentInset;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.subviews[0].alpha = 0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:nil action:nil];
    _topContentInset = 136;
    [self.view addSubview:self.tableView];
    [self belowTheTableView];
}

- (void)belowTheTableView{
    _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*871/828.0)];
    _topImageView.image = [UIImage imageNamed:@"backImage"];
    [self.view insertSubview:_topImageView belowSubview:self.tableView];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = ({
            _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
            _tableView.delegate = self;
            _tableView.dataSource = self;
            _tableView.contentInset = UIEdgeInsetsMake(64+_topContentInset, 0, 0, 0);
            _tableView.backgroundColor = [UIColor clearColor];
            _tableView;
        });
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = @"scrum_snail@yeah.net";

    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y + self.tableView.contentInset.top;
    NSLog(@"%f",offsetY);
    if (offsetY < 0) {
        _topImageView.transform = CGAffineTransformMakeScale(1 + offsetY/(-500), 1 + offsetY/(-500));
    }
    if (offsetY<=_topContentInset*2 && offsetY>(_topContentInset - 64)) {
        CGFloat alpa = offsetY >= _topContentInset *2 ? 1 : offsetY/(_topContentInset * 2);
        self.navigationController.navigationBar.subviews[0].alpha = alpa;
    }
    if (offsetY <= (_topContentInset - 64)) {
        self.navigationController.navigationBar.subviews[0].alpha = 0;
    }
    CGRect rect = _topImageView.frame;
    rect.origin.y = 0;
    _topImageView.frame = rect;
}
@end
