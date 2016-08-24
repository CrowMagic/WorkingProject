//
//  ss_MasterSearchViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/8/23.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "ss_MasterSearchViewController.h"

#import "ss_DetailMasterViewController.h"


@interface ss_MasterSearchViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating,UISearchBarDelegate>
@property (nonatomic, strong) UISearchController *searchController;//导航条的搜索
@property (nonatomic, strong) UITableView *masterTableView;//大师名字列表
@property (nonatomic, strong) NSMutableArray *dataSource;//大师名字数据源
@property (nonatomic, strong) NSMutableArray *filterDataSource;//搜索过滤的数据源，没条件限制等于大师名字数据源
@property (nonatomic, strong) NSMutableArray *tuijianArray;//搜索推荐大师
@property (nonatomic, strong) NSMutableArray *mingqiArray;//搜索名气大师
@property (nonatomic, strong) NSMutableArray *xinjinArray;//搜索新进大师
@property (nonatomic, strong) NSArray *totalArray;

@end

@implementation ss_MasterSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"我是大师搜索";
    [self.view addSubview:self.masterTableView];
    self.dataSource = [NSMutableArray arrayWithObjects:@"张三",@"李四",@"王五",@"蒙娜丽莎",@"第一",@"第0",@"第2",@"大师",@"小弟",@"呵呵",@"笑了",@"什么",@"你猜",@"哈哈",@"1",@"2",@"3",@"4",@"5",@"6",@"7", nil];
    self.filterDataSource = [NSMutableArray array];
    self.tuijianArray = [NSMutableArray arrayWithObjects:@"张三",@"第0",@"第2",@"李四",@"王五",@"蒙娜丽莎",@"第一",@"大牛",@"大师", nil];
    self.mingqiArray = [NSMutableArray arrayWithObjects:@"小弟",@"呵呵",@"笑了",@"什么",@"你猜",@"哈哈", nil];
    self.xinjinArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7", nil];
    self.totalArray = @[self.dataSource, self.tuijianArray, self.mingqiArray, self.xinjinArray];
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.hidesNavigationBarDuringPresentation = YES;
//    self.searchController.obscuresBackgroundDuringPresentation = NO;
//    self.searchController.searchBar.backgroundImage = [UIImage new];
//    self.searchController.searchBar.backgroundColor = [UIColor whiteColor];
    self.definesPresentationContext = YES;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.obscuresBackgroundDuringPresentation = NO;
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.scopeButtonTitles = @[@"全部",@"推荐",@"名气",@"新近"];

    self.masterTableView.tableHeaderView = self.searchController.searchBar;
    self.searchController.searchBar.delegate = self;
    
    
}


//- (void)filterDataSourceForSearchText:(NSString *)searchText scope:(NSString *)scope {
//    [self.filterDataSource removeAllObjects];

//    if ([scope  isEqual: @"推荐"]) {
//        
//        debugLog(@"这是推荐搜索");
//        for (NSString *str  in self.tuijianArray) {
//            if ([str containsString:searchText]) {
//                [self.filterDataSource addObject:str];
//            }
//        }
//    } else if ([scope isEqual:@"名气"]) {
//        debugLog(@"这是名气搜索");
//        for (NSString *str  in self.mingqiArray) {
//            if ([str containsString:searchText]) {
//                [self.filterDataSource addObject:str];
//            }
//        }
//    } else if ([scope isEqual:@"新近"]) {
//        debugLog(@"这是新进搜索");
//        for (NSString *str  in self.xinjinArray) {
//            if ([str containsString:searchText]) {
//                [self.filterDataSource addObject:str];
//            }
//        }
//    } else {
//        for (NSString *str  in self.dataSource) {
//            if ([str containsString:searchText]) {
//                [self.filterDataSource addObject:str];
//            }
//        }
//    }
//}


//- (void)getArray:(NSMutableArray *)array text:(NSString *)searchText {
//    for (NSString *masterName in array) {
//        //中文或数字就使用包含，英文之母都转化为小写在确定是否包含
//        if ([masterName containsString:searchText] || [masterName.lowercaseString containsString:searchText.lowercaseString]) {
//            [self.filterDataSource addObject:masterName];
//        }
//    }
//}



- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    // 修改UISearchBar右侧的取消按钮文字颜色及背景图片
    for (UIView *searchbuttons in [searchBar subviews]){
        if ([searchbuttons isKindOfClass:[UIButton class]]) {
            UIButton *cancelButton = (UIButton*)searchbuttons;
            [cancelButton setTitle:@"取消" forState:UIControlStateSelected];
        }
    }

    
    return YES;
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    UISearchBar *searchBarV = searchController.searchBar;
    
    #pragma mark - 使用KVC修改系统的控件属性
    /**
     *  使用KVC
     */
    [searchBarV setValue:@"取消" forKey:@"_cancelButtonText"];
    NSString *searchText = searchBarV.text;
//    NSString *scope = searchBarV.scopeButtonTitles[searchBarV.selectedScopeButtonIndex];
//    [self filterDataSourceForSearchText:searchController.searchBar.text scope:scope];
    
    //切换不同的范围搜索之前先把过滤数组清空，防止数据叠加和错乱
    [self.filterDataSource removeAllObjects];
    for (NSString *masterName in self.totalArray[searchBarV.selectedScopeButtonIndex]) {
        //中文或数字就使用包含，英文之母都转化为小写在确定是否包含
        if ([masterName containsString:searchText] || [masterName.lowercaseString containsString:searchText.lowercaseString]) {
            [self.filterDataSource addObject:masterName];
        }
    }
    [self.masterTableView reloadData];
    
    debugLog(@"self.filterDataArray = %@, 选择的索引为 = %ld", self.filterDataSource, (long)searchBarV.selectedScopeButtonIndex);
}

#pragma mark - UITableViewDelegateAndDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchController.active && ![self.searchController.searchBar.text  isEqual: @""]) {
        return self.filterDataSource.count;
    }
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (self.searchController.active && ![self.searchController.searchBar.text  isEqual: @""]) {
        cell.textLabel.text = self.filterDataSource[indexPath.row];
    } else {
        cell.textLabel.text = self.dataSource[indexPath.row];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *text = cell.textLabel.text;
    ss_DetailMasterViewController *vc = [[ss_DetailMasterViewController alloc] init];
    vc.titleText = text;
    
    [self.navigationController pushViewController:vc animated:YES];

}




- (UITableView *)masterTableView {
    if (!_masterTableView) {
        _masterTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
        [_masterTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        _masterTableView.delegate = self;
        _masterTableView.dataSource = self;
    }
    return _masterTableView;
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
