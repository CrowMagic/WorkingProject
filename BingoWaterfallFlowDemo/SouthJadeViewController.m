//
//  SouthJadeViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/6/24.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "SouthJadeViewController.h"
#import "UICollectionViewWaterfallLayout.h"
#import "SouthJadeCollectionViewCell.h"
#define  WIDTH (([UIScreen mainScreen].bounds.size.width -30)/2)

#import "SouthJadeModel.h"
#import "SouthJadeRequest.h"
#import "UIImageView+WebCache.h"


#import "BuyShowViewController.h"

@interface SouthJadeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateWaterfallLayout,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UICollectionView *myCollectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *imageHeightArray;
@property (nonatomic, strong) NSMutableArray *imageWidthArray;

@property (nonatomic, strong) UIView *maskViewShadow;//
@property (nonatomic, strong) UITableView *rightTableView;//右边栏的选择表
@property (nonatomic, strong) NSArray *rightTableDataSource;//右边栏数据
@property (nonatomic, strong) NSMutableArray *rightButtonArray;

//@property (nonatomic, strong)  UIImageView *imageView;
@property (nonatomic, assign) NSInteger numberOfWold;
@property (nonatomic, strong) NSMutableArray *realTableDataSource;
@end

@implementation SouthJadeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myCollectionView];

    [self.view addSubview:[self rightControlButton]];
    [self.view addSubview:[self topSelectSegmentControl]];
    [self configRightTableViewWidth];
    [self.view addSubview:self.rightTableView];

    //页面加载的时候，由于右侧表实在屏幕右侧还没显示出来，先获取分类的字符串数组self.rightTableDataSource,从中找出最长字符串的长度，然后据此计算出表的宽度
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"leftWhite@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popCurrentViewController)];
    /**
     *  设置此代理是为了让从屏幕左边缘返回的手势不失效
     */
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    #pragma mark - 南玉网络请求
  
    [SouthJadeRequest ss_southJadeHTTPRequest:nil request:^(NSMutableArray *object) {
        self.dataSource = object;
        debugLog(@"数据源self.dataSource.count = %lu",(unsigned long)self.dataSource.count);
        [self.myCollectionView reloadData];

    }];
}

- (UIImage *)preDownLoadImage:(NSString *)str {
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:str]];
    return imageView.image;
}



- (void)popCurrentViewController {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    //从屏幕左边滑动返回未到一版松手还停留到当前页面，但底部的tabBar会露出来，所以要隐藏
    self.tabBarController.tabBar.hidden = YES;
    //给导航条设置背景图
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tabBarBg@2x.png"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}


- (void)configRightTableViewWidth {
    self.realTableDataSource = [NSMutableArray array];
    
    self.rightTableDataSource = @[@"取消",@"确定",@"全部",@"文艺",@"出行",@"娱乐",@"65天",@"的是你你知道我是喜欢好多蚊子我都装不下不说咋办啊我糙真的装不下哎啊",@"服务",@"文艺",@"出行",@"娱乐",@"65天",@"文艺",@"出行",@"娱乐",@"65天",];
    NSMutableArray *sortArray = [NSMutableArray arrayWithCapacity:self.rightTableDataSource.count];
    int cArray[self.rightTableDataSource.count];
    
    //使用并发的枚举块，减少时间，但索引不是一一对应的
    [self.rightTableDataSource enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *i = (NSString *)obj;
        NSUInteger lengthN = i.length;
        debugLog(@"字符串的长度为%lu", (unsigned long)lengthN);

        [sortArray addObject:@(lengthN)];
        if (i.length >= 17) {
            i = [i substringToIndex:17];
        }
        [self.realTableDataSource addObject:i];
        
    }];
    
//    for ( NSString *i in self.rightTableDataSource) {
//        NSUInteger lengthN = i.length;
//        //        debugLog(@"字符串的长度为%d", lengthN);
//        [sortArray addObject:@(lengthN)];
//        NSString *str = i;
//        if (i.length >= 17) {
//            str = [i substringToIndex:17];
//        }
//        [self.realTableDataSource addObject:str];
//    }
    
    debugLog(@"self.realTableDataSource = %@",self.realTableDataSource);
    
    for (NSUInteger i = 0; i < self.realTableDataSource.count; i++) {
        NSString *str = self.realTableDataSource[i];
        cArray[i] = (int)str.length;
        printf("cArray = %d\n", cArray[i]);
    }
    
    debugLog(@"sortArray = %@, cArray = ", sortArray);
    
    
    [self bubbleSort:cArray len:sizeof(cArray)/sizeof(int)];
    
//    for (int i = 0; i < sizeof(cArray)/sizeof(int); i++) {
//        debugLog(@"排序后的结果=%d", cArray[i]);
//        
//    }
    self.numberOfWold = cArray[self.rightTableDataSource.count - 1];
    
    debugLog(@"最大的数字为 = %ld", (long)self.numberOfWold);
    

}


- (void)bubbleSort:(int [])array len:(size_t)len {
    for (size_t i = 0; i < len - 1; ++i) {
        for (size_t j = len - 1; j > i; --j) {
            if (array[j] < array[j - 1]) {
                // 交换
                int temp = array[j];
                array[j] = array[j - 1];
                array[j - 1] = temp;
            }
        }
    }
}



//- (void)viewWillAppear:(BOOL)animated {
//    debugLog(@"我将要出现了");
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    debugLog(@"我将要消失了");
//}




- (UISegmentedControl *)topSelectSegmentControl {
    
     UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"最新",@"销量",@"关注",@"推荐"]];
    segmentControl.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds)*4/5+10, 45);
        segmentControl.tintColor = [UIColor clearColor];
    
    segmentControl.backgroundColor = [UIColor whiteColor];
    [segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:18.0f]} forState:UIControlStateNormal];
    segmentControl.selectedSegmentIndex = 0;
    if (segmentControl.selectedSegmentIndex == 0) {
        [segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0/255.0 green:164/255.0 blue:82/255.0 alpha:1]} forState:UIControlStateSelected];
    }

    [segmentControl addTarget:self action:@selector(segmentControlChange:) forControlEvents:UIControlEventValueChanged];
    return segmentControl;
}


- (void)segmentControlChange:(UISegmentedControl *)sender {
    [sender setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0/255.0 green:164/255.0 blue:82/255.0 alpha:1]} forState:UIControlStateSelected];
    
    [self.myCollectionView reloadData];
    debugLog(@"我是第%ld个",(long)sender.selectedSegmentIndex);
}

//鉴于UISegmentControl的特性(当你选中某一个时，再次点击无效)，最右侧的图标选择为UIButton来代替

- (UIButton *)rightControlButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) * 4/5+10, 0, CGRectGetWidth([UIScreen mainScreen].bounds)/5-10, 45);
//    btn.backgroundColor = [UIColor redColor];
    [btn setImage:[[UIImage imageNamed:@"1511副本"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor whiteColor];
    CGFloat edgeInserts = (CGRectGetWidth([UIScreen mainScreen].bounds)/5 - 40)/2;
    
    btn.imageEdgeInsets = UIEdgeInsetsMake(3+3, edgeInserts-2, 3+3, edgeInserts+6);
    
    [btn addTarget:self action:@selector(showTheRightTableView) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)showTheRightTableView {
    debugLog(@"我是最右侧的按钮");
    [self rightTableViewAniamtionOut];

}


- (void)rightTableViewAniamtionOut {
    //一开始位移不是屏幕宽度，有一个遮罩的效果，暂时不删，防止在改动
    
    debugLog(@"我执行了");
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.rightTableView.frame;
        debugLog(@"动画前的原点%f", frame.origin.x);
        
        frame.origin.x -= [self calculateRightTableViewWidth];
        self.rightTableView.frame = frame;
        debugLog(@"frame.origin.x = %f", frame.origin.x);
        debugLog(@"动画时的宽度=%f",[self calculateRightTableViewWidth]);
    } completion:^(BOOL finished) {
        if ([self calculateRightTableViewWidth] < CGRectGetWidth([UIScreen mainScreen].bounds)) {
            [self.view addSubview:self.maskViewShadow];
            self.maskViewShadow.alpha = 0.5;
            debugLog(@"出现遮罩效果");
            debugLog(@"maskView的宽度 = %f", self.maskViewShadow.frame.size.width);
        }
        
    }];
    
}

- (void)rightTableViewAniamtionIn {
//    [UIView animateWithDuration:0.5 animations:^{
//        CGRect frame = self.rightTableView.frame;
//        frame.origin.x += 100;
//        self.rightTableView.frame = frame;
//        self.maskView.alpha = 0;
//    } completion:^(BOOL finished) {
//        [self.maskView removeFromSuperview];
//    }];
    
    
    [UIView animateWithDuration:0.1 animations:^{
//        self.maskViewShadow.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = self.rightTableView.frame;
            frame.origin.x += [self calculateRightTableViewWidth];
            self.rightTableView.frame = frame;
            [self.maskViewShadow removeFromSuperview];
        }];
    }];
    
    
}


#pragma mark - UICollectionViewDelegateAndDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SouthJadeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SouthJadeCollectionViewCell" forIndexPath:indexPath];
    
    SouthJadeModel *model = self.dataSource[indexPath.row];
    
    cell.jadeNameLabel.text = model.name;
    cell.jadePriceLabel.text = [NSString stringWithFormat:@"¥%.2f", model.price];

    [cell.jadeImageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
    BuyShowViewController *mVC = [[BuyShowViewController alloc]init];
    [self.navigationController pushViewController:mVC animated:YES];
   

}


#pragma mark - UICollectionViewDelegateWaterfallLayout

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewWaterfallLayout *)collectionViewLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    debugLog(@"hahaha");
   
    SouthJadeModel *model = self.dataSource[indexPath.row];
    
    return WIDTH * model.height / model.width + 100;
}

#pragma mark - lazyLoadUICollectionView

- (UICollectionView *)myCollectionView {
    if (!_myCollectionView) {
        
        UICollectionViewWaterfallLayout *layout = [[UICollectionViewWaterfallLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        layout.itemWidth = WIDTH;
        layout.columnCount = 2;
        layout.delegate = self;
        _myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-40) collectionViewLayout:layout];
        _myCollectionView.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:240/255.0 alpha:1];
        
        [_myCollectionView registerNib:[UINib nibWithNibName:@"SouthJadeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SouthJadeCollectionViewCell"];
        
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
    }
    return _myCollectionView;
}


#pragma mark - UITableViewDelegateAndDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rightTableDataSource.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//在此不复用单元格
    UITableViewCell *cell = [[UITableViewCell alloc] init];
     if (indexPath.row == 0) {
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"取消" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0/255.0 green:164/255.0 blue:82/255.0 alpha:1],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
    
        [cell.textLabel setAttributedText:str];
    } else if (indexPath.row == 1) {
         NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"确定"
                                                                   attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:0/255.0 green:164/255.0 blue:82/255.0 alpha:1],NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
        [cell.textLabel setAttributedText:str];
    } else {
        if (indexPath.row == 2) {
            NSAttributedString *str = [[NSAttributedString alloc] initWithString:@"全部" attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17.0f]}];
            [cell.textLabel setAttributedText:str];

        }
        
        cell.textLabel.text = self.rightTableDataSource[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            [self rightTableViewAniamtionIn];
            break;
        case 1:
            [self rightTableViewAniamtionIn];
            break;
            
        default:
            break;
    }
}


- (void)isChoseButton:(UIButton *)sender {
    debugLog(@"我是第%ld个按钮",(long)sender.tag);
    sender.selected = !sender.selected;
//    debugLog(@"sender.selected刚开始 = %d",sender.selected);

    if (sender.selected) {
        if (sender.tag == 2) {
            for (UIButton *btn in self.rightButtonArray) {
                [btn setImage:[UIImage imageNamed:@"white.png"]
                     forState:UIControlStateNormal];
                btn.selected = YES;
            }
        } else {
            [sender setImage:[UIImage imageNamed:@"white.png"]
                    forState:UIControlStateNormal];
            UIButton *btn = self.rightButtonArray.firstObject;
            [btn setImage:[UIImage imageNamed:@"white.png"]
                    forState:UIControlStateNormal];
            btn.selected = YES;
            
        }
//        debugLog(@"sender.selected11 = %d",sender.selected);
    } else {
        if (sender.tag == 2) {
            for (UIButton *btn in self.rightButtonArray) {
                [btn setImage:[UIImage imageNamed:@"xuanze.png"]
                     forState:UIControlStateNormal];
                btn.selected = NO;

            }
        } else {
            [sender setImage:[UIImage imageNamed:@"xuanze.png"]
                    forState:UIControlStateNormal];
        }
//        debugLog(@"sender.selected22 = %d",sender.selected);

    }
    

   
}

#pragma mark - lazyLaodUITableView 

- (CGFloat)calculateRightTableViewWidth {
    CGFloat widthCacularate = (self.numberOfWold == 17) ? CGRectGetWidth([UIScreen mainScreen].bounds)-0.05 : (self.numberOfWold * 15 + 60);
    return  MIN(widthCacularate, CGRectGetWidth([UIScreen mainScreen].bounds));
}


- (UITableView *)rightTableView {
    if (!_rightTableView) {
        
       CGFloat width = [self calculateRightTableViewWidth];
        debugLog(@"右侧表的宽度 = %f", width);
        if (width < CGRectGetWidth([UIScreen mainScreen].bounds)) {
             _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds), 0, width, CGRectGetHeight([UIScreen mainScreen].bounds) - 64) style:UITableViewStylePlain];
        }
        _rightTableView.delegate = self;
        _rightTableView.dataSource = self;
        _rightTableView.tableFooterView = [UIView new];
        
        self.rightButtonArray = [NSMutableArray array];
        for (int i = 2; i < _rightTableDataSource.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(0, 44 * i, width, 44);
            [btn setImage:[UIImage imageNamed:@"xuanze.png"] forState:UIControlStateNormal];
//            btn.backgroundColor = [UIColor redColor];
            btn.imageEdgeInsets = UIEdgeInsetsMake(10, width-35, 10, 6);
            btn.tag = i;
            [btn addTarget:self action:@selector(isChoseButton:) forControlEvents:UIControlEventTouchUpInside];
            
            [self.rightButtonArray addObject:btn];
            [_rightTableView addSubview:btn];
        }
        
        
    }
    return _rightTableView;
}




#pragma mark - lazyLoadMaskView

- (UIView *)maskViewShadow {
    if (!_maskViewShadow) {
        
        CGFloat width = [self calculateRightTableViewWidth];
        _maskViewShadow = [[UIView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth([UIScreen mainScreen].bounds) - width, CGRectGetHeight([UIScreen mainScreen].bounds) - 64)];
        _maskViewShadow.backgroundColor = [UIColor lightGrayColor];
//        _maskView.alpha = 0.5;
    }
    return _maskViewShadow;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self rightTableViewAniamtionIn];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
