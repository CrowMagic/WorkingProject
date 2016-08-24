//
//  LikeViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/24.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LikeViewController.h"
#import "LikeCollectionViewCell.h"
#import "FirstSemTableViewController.h"

//
#import "LDX_EditCollectionView.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "MyCollectionViewCell.h"
//
@interface LikeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, EditCollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, strong) LDX_EditCollectionView *col;
@property (nonatomic, strong) UIButton *editButton;

@end

@implementation LikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatView];
    
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
//    flowLayout.minimumLineSpacing = 0.f;
//    flowLayout.minimumInteritemSpacing = 0.f;
//    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, wKscreen, hKscreen) collectionViewLayout:flowLayout];
//    self.collectionView.delegate = self;
//    self.collectionView.dataSource = self;
//    self.collectionView.backgroundColor = [UIColor whiteColor];
//    self.collectionView.bounces = NO;
//    self.collectionView.showsVerticalScrollIndicator = NO;
//    self.collectionView.showsHorizontalScrollIndicator = NO;
//    [self.view addSubview:self.collectionView];
//    [self.collectionView registerNib:[UINib nibWithNibName:@"LikeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"collectionCell"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.frame.size.width/2.222222222, 250);
    //    layout.minimumLineSpacing = 10.f;
    //    layout.minimumInteritemSpacing = 0.f;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
//#warning 1. 创建对象, 设置editDelegate代理人
    self.col = [[LDX_EditCollectionView alloc] initWithFrame:CGRectMake(0, 40,self.view.frame.size.width, self.view.frame.size.height-40) collectionViewLayout:layout];
    self.col.backgroundColor = [UIColor whiteColor];
    self.col.editDelegate = self;
    
//#warning 2. 注册自定义CollectionViewCell以及重用池标识
    [self.col registerEditClassForCell:[MyCollectionViewCell class] identifier:@"myCell"];
    
    AFHTTPSessionManager *man = [AFHTTPSessionManager manager];
    [man.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html",@"application/json",@"text/plain", nil]];
    [man GET:@"http://c.3g.163.com/nc/article/headline/T1348647909107/0-140.html" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *arr = responseObject[@"T1348647909107"];
        for (NSDictionary *dic in arr) {
            [self.col.dataArray addObject:dic[@"imgsrc"]];
        }
//#warning 3.设置数据源 给self.col.dataArray 赋值
        [self.col reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
    
//#warning 4. 根据需求设置cell上选中按钮样式等
    [self.col setSelectButtonProperty:CGRectMake(140, 20, 20, 20) selectYesImage:[UIImage imageNamed:@"Yes.png"] selectNoImage:[UIImage imageNamed:@"No.png"] isCirl:YES alpha:1];
    
    [self.view addSubview:self.col];
    
//#warning 5. 设置功能按钮(如果用我给你的, 只需要设置位置以及一些属性)
    self.col.selectButton.frame = CGRectMake(wKscreen-50, 0, 50, 35);
    self.col.selectButton.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.col.selectButton];
    
    //self.col.delView.frame = CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44);
    [self.view addSubview:self.col.delView];
    
    //self.col.selectAllButton.frame = CGRectMake(10, 0, 100, 40);
    self.col.selectAllButton.backgroundColor = [UIColor blackColor];
    [self.col.delView addSubview:self.col.selectAllButton];
    
    //self.col.deleteButton.frame = CGRectMake(200, 0, 100, 40);
    self.col.deleteButton.backgroundColor = [UIColor blackColor];
    [self.col.delView addSubview:self.col.deleteButton];

}

-(void)leftAction:(UIButton *)sender
{
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
    self.navigationController.navigationBarHidden = YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)creatView
{
    //self.view.backgroundColor = [UIColor whiteColor];
    _usefullBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _usefullBtn.frame = CGRectMake(0, 0, (wKscreen-50)/2, 35);
    [_usefullBtn setTitle:@"全部宝贝" forState:UIControlStateNormal];
    [_usefullBtn setTintColor:[UIColor grayColor]];
    //_usefullBtn.backgroundColor = [UIColor redColor];
    [_usefullBtn addTarget:self action:@selector(usefullBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_usefullBtn];
    
    _uselessBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _uselessBtn.frame = CGRectMake((wKscreen-50)/2, 0, (wKscreen-50)/2, 35);
    [_uselessBtn setTitle:@"失效宝贝" forState:UIControlStateNormal];
    [_uselessBtn setTintColor:[UIColor grayColor]];
    //_uselessBtn.backgroundColor = [UIColor redColor];
    [_uselessBtn addTarget:self action:@selector(uselessBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_uselessBtn];
    _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_uselessBtn.frame), 0, 1, 35)];
    _lineLabel.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_lineLabel];
    _levelLbl = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_lineLabel.frame), wKscreen, 1)];
    _levelLbl.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_levelLbl];
    
//    _rubbishBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    _rubbishBtn.frame = CGRectMake(wKscreen-40, 0, 30, 30);
//    //[_rubbishBtn setBackgroundImage:[UIImage imageNamed:@"rubbsh"] forState:UIControlStateNormal];
//    [_rubbishBtn setTitle:@"垃圾" forState:UIControlStateNormal];
//    //[_rubbishBtn setTitle:@"取消" forState:UIControlStateSelected];
//    [_rubbishBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [_rubbishBtn addTarget:self action:@selector(rubbishBtnAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_rubbishBtn];
    
    
    
}
#warning 6. 遵守协议, 并实现2个必须实现的协议方法
- (void)collectionCellForItemAtIndexPath:(NSIndexPath *)indexPath cell:(UICollectionViewCell *)cell identifier:(NSString *)identifier
{
    
    MyCollectionViewCell *tCell = (MyCollectionViewCell *)cell;
    tCell.backgroundColor = [UIColor yellowColor];
    [tCell.myLabel setText:[NSString stringWithFormat:@"%ld", indexPath.row]];
    NSString *imageU = self.col.dataArray[indexPath.row];
    [tCell.imageV sd_setImageWithURL:[NSURL URLWithString:imageU]];
    
    //    CollectionViewCell *tCell = (CollectionViewCell *)cell;
    //        tCell.backgroundColor = [UIColor greenColor];
    //            [tCell.simpleBtn setTitle:[NSString stringWithFormat:@"%d", indexPath.row] forState:UIControlStateNormal];
    //        NSString *imageV = self.col.dataArray[indexPath.row];
    //        [tCell.imageU sd_setImageWithURL:[NSURL URLWithString:imageV]];
}

#warning 7. 获取选中的cell的下标, 自己删除对应的数据源.
- (void)getSelectCellData:(NSArray *)cellArr
{
    NSLog(@"%@", cellArr);
}
-(void)usefullBtnAction:(UIButton *)sender
{
    NSLog(@"usefullBtnAction");
}
-(void)uselessBtnAction:(UIButton *)sender
{
    NSLog(@"uselessBtnAction");
}
/*-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LikeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(wKscreen/2, hKscreen/2.24);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(void)usefullBtnAction:(id)sender
{
    
}
-(void)rubbishBtnAction:(id)sender
{
    if (self.isClick) {
        
        [self.rubbishBtn setTitle:@"垃圾" forState:UIControlStateNormal];
        [self.rubbishBtn setTintColor:[UIColor grayColor]];
        self.isClick = NO;
        NSLog(@"点击了垃圾桶");
    }
    else
    {
        
        [self.rubbishBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.rubbishBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.isClick = YES;
        NSLog(@"取消");
    }
    
}*/




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
