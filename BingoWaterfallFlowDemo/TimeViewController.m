//
//  TimeViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/6.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "TimeViewController.h"
#import "TimeScrollView.h"
#import "UserCell.h"
@interface TimeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)TimeScrollView *tScrollView;
//@property(nonatomic,strong)UITableView *MyTableView;
@property(nonatomic,strong)NSMutableDictionary *dict;
@end

@implementation TimeViewController
-(void)loadView
{
    self.tScrollView = [[TimeScrollView alloc]initWithFrame:CGRectMake(0, 0, wKscreen, hKscreen*4)];
    self.tScrollView.backgroundColor = [UIColor whiteColor];
    self.tScrollView.contentSize = CGSizeMake(wKscreen, hKscreen*6);
    self.view = self.tScrollView;
    //自定义高度
    /*CGFloat tempHeight  =  [self heightForUILabel];
    CGRect tempRect = self.tScrollView.custumerLabel.frame;
    tempRect.size.height = tempHeight;
    self.tScrollView.custumerLabel.frame = tempRect;*/
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _MyTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 90+CGRectGetMaxY(self.tScrollView.phoneLabel.frame), wKscreen, 150)];
//    _MyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:_MyTableView];
    self.tScrollView.MyTableView.delegate = self;
    self.tScrollView.MyTableView.dataSource = self;
    [self.tScrollView.MyTableView registerNib:[UINib nibWithNibName:@"UserCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.dict = [NSMutableDictionary dictionary];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[self.dict valueForKey:@"0"]isEqualToString:@"0"]) {
        return 4;
    }
    else
    {
        return 0;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    if ([[self.dict valueForKey:[NSString stringWithFormat:@"0"]]isEqualToString:@"0"]) {
        [btn setTitle:@"收起" forState:UIControlStateNormal];
    }
    else
    {
        [btn setTitle:@"查看更多" forState:UIControlStateNormal];
    }
    return btn;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cell_id = @"cell";
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    if (cell == nil) {
        cell = [[UserCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cell_id];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  30;
}
-(void)btnAction:(UIButton *)sender
{
    if ([[self.dict valueForKey:[NSString stringWithFormat:@"0"]]isEqualToString:@"0"]) {
        [self.dict setValue:@"1" forKey:[NSString stringWithFormat:@"0"]];
    }
    else
    {
        [self.dict setValue:@"0" forKey:[NSString stringWithFormat:@"0"]];
    }
    [self.tScrollView.MyTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
-(CGFloat)heightForUILabel
{
    CGFloat f = self.tScrollView.custumerLabel.frame.size.height;
    if ([[self.dict valueForKey:@"0"]isEqualToString:@"0"]) {
        return f = 4 *70 +250;
    }
    else
    {
        return f = 200;
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
