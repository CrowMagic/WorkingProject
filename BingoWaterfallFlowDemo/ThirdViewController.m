//
//  ThirdViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/4/19.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "ThirdViewController.h"
//#import "leftCollectionViewCell.h"
#import "rightTitleTableViewCell.h"
//#import "SpCollectionViewCell.h"
#import "DataTools.h"
#import "ThiredModel.h"
#import "XHLWaterLayout.h"
#import "FenleiCollectionViewCell.h"
#define ZXColor(r,g,b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1];
#define   kScreen    CGRectGetWidth([UIScreen mainScreen].bounds)
@interface ThirdViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,XHLWaterLayoutDelegate>
@property(nonatomic,strong)NSArray *nameProductArray;
@property(nonatomic,strong)NSMutableArray *array;
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
    _nameProductArray = [NSArray arrayWithObjects:@"产品高端",@"整体分类",@"潮流品牌",@"潮流女装",@"时尚男装",@"酒水饮品",@"家具",@"电器",@"手机数码",@"电脑办公",@"奢侈礼品",@"汽车用品",@"玩具",@"时尚女装",@"产品高端",@"整体分类",@"潮流品牌",@"潮流女装",@"时尚男装",@"酒水饮品",@"家具",@"电器",@"手机数码",@"电脑办公",@"奢侈礼品",@"汽车用品",@"玩具",@"时尚女装", nil];
    [self creatView];
    
}
-(void)getData
{
    NSString *productcategoryUrl = [ALLUrl stringByAppendingString:@"productcategory/view"];
    [[DataTools shareDataTool] getDataWithUrlWithString:productcategoryUrl WithPassValue:^(NSDictionary *dictionary) {
        NSArray *array = dictionary[@"message"];
        self.array = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            ThiredModel *model = [[ThiredModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.array addObject:model];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.rightTitleTableView reloadData];
            });
        }
    }];
}
-(void)creatView
{
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 20, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)/15)];
    self.headerView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_headerView];
    self.kindSeacherBar = [[UISearchBar alloc]initWithFrame:CGRectMake(kScreen/15, 2,kScreen-kScreen/15*2 , CGRectGetHeight(self.headerView.frame)-3)];
    self.kindSeacherBar.layer.cornerRadius = 10;
    self.kindSeacherBar.layer.masksToBounds = YES;
    [self.kindSeacherBar setBackgroundImage:[UIImage imageNamed:@"searchBackg.jpg"]];
    [self.kindSeacherBar.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.headerView addSubview:_kindSeacherBar];
    
    
    
    self.rightTitleTableView = [[UITableView alloc]initWithFrame:CGRectMake(kScreen-80, CGRectGetMaxY(self.headerView.frame), 80, CGRectGetHeight([UIScreen mainScreen].bounds)-CGRectGetHeight(self.headerView.frame)-49) style:UITableViewStylePlain];
    self.rightTitleTableView.delegate = self;
    self.rightTitleTableView.dataSource = self;
    self.rightTitleTableView.bounces = NO;
    self.rightTitleTableView.showsVerticalScrollIndicator = NO;
    self.rightTitleTableView.showsHorizontalScrollIndicator = NO;
    self.rightTitleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_rightTitleTableView];
    NSIndexPath *first = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.rightTitleTableView selectRowAtIndexPath:first animated:YES scrollPosition:UITableViewScrollPositionTop];
    [self.rightTitleTableView registerNib:[UINib nibWithNibName:@"rightTitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"rCell"];
   
    /*UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 10.f;
    flowLayout.minimumInteritemSpacing = 10.f;
    //设置header大小
    flowLayout.headerReferenceSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds)-100, 20);
    
    _leftCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), kScreen-100, CGRectGetHeight([UIScreen mainScreen].bounds)-CGRectGetHeight(self.headerView.frame)-49) collectionViewLayout:flowLayout];
    _leftCollectionView.delegate = self;
    _leftCollectionView.dataSource = self;
    _leftCollectionView.backgroundColor = [UIColor whiteColor];
    _leftCollectionView.bounces = NO;
    _leftCollectionView.showsHorizontalScrollIndicator = NO;
    _leftCollectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_leftCollectionView];
    [self.leftCollectionView registerNib:[UINib nibWithNibName:@"leftCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"lCell"];
    //注册SpCollectionCell
    [self.leftCollectionView registerNib:[UINib nibWithNibName:@"SpCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    //collectionView加headerView   需要注册才可以使用
    [self.leftCollectionView registerNib:[UINib nibWithNibName:@"SQSupplementaryView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerIdentifier"];*/
    XHLWaterLayout *layout = [[XHLWaterLayout alloc]init];
    layout.delegate = self;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), self.view.frame.size.width-80, self.view.frame.size.height) collectionViewLayout:layout];
    //
    collectionView.contentInset = UIEdgeInsetsMake(40, 0, 0, 0);
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"searchBackg"]];
    imageV.frame = CGRectMake(0, -40, self.view.frame.size.width-80, 40);
    UILabel *lineFLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, (self.view.frame.size.width-80)/3-10, 1)];
    lineFLbl.backgroundColor = [UIColor grayColor];
    [imageV addSubview:lineFLbl];
    UILabel *titleLbl = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.size.width-80)/3, 0, (self.view.frame.size.width-80)/3, 40)];
    titleLbl.text = @"奢品男装";
    titleLbl.textColor = [UIColor grayColor];
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [imageV addSubview:titleLbl];
    UILabel *lineSLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLbl.frame)+10, 20, (self.view.frame.size.width-80)/3-10, 1)];
    lineSLbl.backgroundColor = [UIColor grayColor];
    [imageV addSubview:lineSLbl];
    
    [collectionView addSubview:imageV];
    //
    collectionView.dataSource = self;
    collectionView.delegate   = self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    [collectionView registerNib:[UINib nibWithNibName:@"FenleiCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _nameProductArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   rightTitleTableViewCell *rCell = [tableView dequeueReusableCellWithIdentifier:@"rCell" forIndexPath:indexPath];
    ThiredModel *tModel = _array[indexPath.row];
    //rCell.nameProductLabel.text = tModel.name;
   rCell.nameProductLabel.text = _nameProductArray[indexPath.row];
    //rCell.backgroundColor = ZXColor(240, 240, 240);
    UIView *selectedBackgroundView = [[UIView alloc]initWithFrame:rCell.frame];
    selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    rCell.selectedBackgroundView = selectedBackgroundView;
    //左侧示意条
    UIView *liner = [[UIView alloc]initWithFrame:CGRectMake(75, 0, 5, 30)];
    liner.backgroundColor = [UIColor redColor];
    [selectedBackgroundView addSubview:liner];
    
    
    return rCell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  30;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.rightTitleTableView scrollToNearestSelectedRowAtScrollPosition:UITableViewScrollPositionTop animated:YES];
    [_leftCollectionView scrollRectToVisible:CGRectMake(0, 0, self.leftCollectionView.frame.size.width, self.leftCollectionView.frame.size.height) animated:YES];
    
    
    _selectedIndex = indexPath.row;
    
    [_leftCollectionView reloadData];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 40;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   // SpCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    FenleiCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    //根据右边点击的indepath更新左边内容;
    switch (_selectedIndex)
    {
        case 0:
            cell.storeImage.image = [UIImage imageNamed:@"3.jpg"];
            break;
        case 1:
            cell.storeImage.image = [UIImage imageNamed:@"2.jpg"];
            break;
        case 2:
            cell.storeImage.image = [UIImage imageNamed:@"3.jpg"];
            break;
        case 3:
            cell.storeImage.image = [UIImage imageNamed:@"2.jpg"];
            break;
        default:
            break;
    }
    
    return cell;
}
/*-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 0, 0);
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemW = (self.leftCollectionView.frame.size.width-30) / 3.f;
    return CGSizeMake(itemW,CGRectGetHeight(self.view.frame)/5.333);
}
//添加collectionView的headerView
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reuseIdentifier = @"headerIdentifier";
    }
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    return view;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = {CGRectGetWidth(self.leftCollectionView.frame),50};
    return size;
}*/
-(CGFloat)waterLayout:(UICollectionViewLayout *)waterLayout itemWidth:(CGFloat)itemWidth indexPath:(NSIndexPath *)indexPath
{
    return 80 + arc4random_uniform(100);
}

-(UIEdgeInsets)edgeInsetsInWaterflowLayout:(UICollectionViewLayout *)layout
{
    return UIEdgeInsetsMake(0, 2, 0, 0);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"items = %ld",indexPath.row);
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
