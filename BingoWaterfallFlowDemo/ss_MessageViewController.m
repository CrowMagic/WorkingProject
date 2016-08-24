//
//  ss_MessageViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/6/22.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "ss_MessageViewController.h"
#import "ss_MessageTableViewCell.h"
@interface ss_MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *messageTableView;
@end

@implementation ss_MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"消息";
    [self.view addSubview:self.messageTableView];
}


#pragma mark - UITableViewDelegateAndDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ss_MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss_MessageTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    debugLog(@"我是第%ld个消息的cell",(long)indexPath.row);
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - lazyLaodUITableView

- (UITableView *)messageTableView {
    if (!_messageTableView) {
        _messageTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        
        [_messageTableView registerNib:[UINib nibWithNibName:@"ss_MessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"ss_MessageTableViewCell"];
        _messageTableView.delegate = self;
        _messageTableView.dataSource = self;
        _messageTableView.rowHeight = 100;

        
        
    }
    return _messageTableView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
