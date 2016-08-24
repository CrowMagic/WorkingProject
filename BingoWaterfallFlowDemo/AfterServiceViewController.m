//
//  AfterServiceViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 5/24/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import "AfterServiceViewController.h"

#import "ss_zeroFirstCell.h"
#import "ss_secondCell.h"
#import "ss_thirdCell.h"
#import "ss_fourthCell.h"
#import "ss_fifthCell.h"

@interface AfterServiceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation AfterServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.myTableView];
}

#pragma mark - UITableViewDelegateAndDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            ss_zeroFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss_zeroFirstCell" forIndexPath:indexPath];
            return cell;
        }
            break;
            
        case 1:{
            ss_secondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss_secondCell" forIndexPath:indexPath];
            return cell;
        }
            break;
        case 2: {
            ss_thirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss_thirdCell" forIndexPath:indexPath];
            return cell;
        }
            break;
        case 3:{
            ss_fourthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss_fourthCell" forIndexPath:indexPath];
            return cell;
        }
            break;
        case 4:{
            ss_fifthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss_fifthCell" forIndexPath:indexPath];
            return cell;
        }
            break;
        case 5:{
            ss_fifthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ss_fifthCell" forIndexPath:indexPath];
            cell.sectionLabel.text = @"上传图片";
            [cell.describeQuestionTF removeFromSuperview];
            return cell;
        }
            break;
            
        default:
            break;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 5) {
        UIView  *aview = [[UIView alloc] init];
//        aview.backgroundColor = [UIColor redColor];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.center = CGPointMake(wKscreen/2, 40);
        btn.bounds = CGRectMake(0, 0, 200, 50);
        [btn setTitle:@"下一步" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor greenColor];
        [btn addTarget:self action:@selector(nextStep:) forControlEvents:UIControlEventTouchUpInside];
        [aview addSubview:btn];
        return aview;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 5) {
        return 80;
    }
    return 10;
}


#pragma mark - lazyLoad
- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, wKscreen, hKscreen) style:UITableViewStyleGrouped];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        _myTableView.rowHeight = 100;
        _myTableView.sectionHeaderHeight = 0;
//        _myTableView.sectionFooterHeight = 10;
        [_myTableView registerNib:[UINib nibWithNibName:@"ss_zeroFirstCell" bundle:nil] forCellReuseIdentifier:@"ss_zeroFirstCell"];
        [_myTableView registerNib:[UINib nibWithNibName:@"ss_secondCell" bundle:nil] forCellReuseIdentifier:@"ss_secondCell"];
        [_myTableView registerNib:[UINib nibWithNibName:@"ss_thirdCell" bundle:nil] forCellReuseIdentifier:@"ss_thirdCell"];
        [_myTableView registerNib:[UINib nibWithNibName:@"ss_fourthCell" bundle:nil] forCellReuseIdentifier:@"ss_fourthCell"];
        [_myTableView registerNib:[UINib nibWithNibName:@"ss_fifthCell" bundle:nil] forCellReuseIdentifier:@"ss_fifthCell"];
      
    }
    return _myTableView;
}

#pragma mark - buttonClickEvents

- (void)nextStep:(UIButton *)sender {
    debugLog(@"下一步");
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
