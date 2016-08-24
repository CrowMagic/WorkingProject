//
//  ZYSViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/6/8.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "ZYSViewController.h"
#import "ZWCollectionViewFlowLayout.h"
#import "ZzwCollectionViewCell.h"
#import "shopModel.h"
#import "MJExtension.h"
#import "YishuViewController.h"
@interface ZYSViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,ZWwaterFlowDelegate>
@property(nonatomic,retain)UICollectionView * collectView;
@property(nonatomic,strong)NSMutableArray * shops;
@end

@implementation ZYSViewController
-(NSMutableArray *)shops
{
    if (_shops==nil) {
        self.shops = [NSMutableArray array];
    }
    return _shops;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化数据
    NSArray * shopsArray = [shopModel objectArrayWithFilename:@"1.plist"];
    [self.shops addObjectsFromArray:shopsArray];
    //注册cell
    ZWCollectionViewFlowLayout * layOut = [[ZWCollectionViewFlowLayout alloc] init];
    layOut.degelate =self;
    UICollectionView * collectView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layOut];
    collectView.delegate =self;
    collectView.dataSource =self;
    [self.view addSubview:collectView];
    [collectView registerNib:[UINib nibWithNibName:@"ZzwCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    self.collectView = collectView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZzwCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    //cell.shop = self.shops[indexPath.item];
    cell.shopImage.image = [UIImage imageNamed:@"2.jpg"];
    cell.shopName.text = @"《蒙娜丽莎》是一幅享有盛誉的肖像画杰作。它代表达·芬奇的最高艺术成就，成功地塑造了资本主义上升时期一位城市有产阶级的妇女形象。画中人物坐姿优雅，笑容微妙，背景山水幽深茫茫，淋漓尽致地发挥了画家那奇特的烟雾状“无界渐变着色法”般的笔法。画家力图使人物的丰富内心感情和美丽的外形达到巧妙的结合，对于人像面容中眼角唇边等表露感情的关键部位，也特别着重掌握精确与含蓄的辩证关系，达到神韵之境，从而使蒙娜丽莎的微笑具有一种神秘莫测的千古奇韵，那如梦似的妩媚微笑，被不少美术史家称为";
    return cell;
}
//代理方法
-(CGFloat)ZWwaterFlow:(ZWCollectionViewFlowLayout *)waterFlow heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPach
{
//    shopModel * shop = self.shops[indexPach.item];
//    return shop.h/shop.w*width;
    return 300;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YishuViewController *vc = [[YishuViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
