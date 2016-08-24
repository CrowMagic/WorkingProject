//
//  YishuViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/6/7.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "YishuViewController.h"
#import "ZLScrolling.h"
#define kWith  self.view.frame.size.width
#define kHeight  self.view.frame.size.height
#import "YiShuCollectionViewCell.h"
#import "XHLWaterLayout.h"

static const NSInteger XHLDefaultColumnCount = 2;
static const CGFloat XHLDefaultRowMargin = 5;
static const UIEdgeInsets XHLDefaultEdgeInsets = {0, 0, 0, 0};
@interface YishuViewController ()<ZLScrollingDelegate,XHLWaterLayoutDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,retain)UICollectionView * collectView;
@end

@implementation YishuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *url = @[@"http://e.hiphotos.baidu.com/lvpics/h=800/sign=61e9995c972397ddc97995046983b216/35a85edf8db1cb134d859ca8db54564e93584b98.jpg", @"http://e.hiphotos.baidu.com/lvpics/h=800/sign=1d1cc1876a81800a71e5840e813533d6/5366d0160924ab185b6fd93f33fae6cd7b890bb8.jpg", @"http://f.hiphotos.baidu.com/lvpics/h=800/sign=8430a8305cee3d6d3dc68acb73176d41/9213b07eca806538d9da1f8492dda144ad348271.jpg", @"http://d.hiphotos.baidu.com/lvpics/w=1000/sign=81bf893e12dfa9ecfd2e521752e0f603/242dd42a2834349b705785a7caea15ce36d3bebb.jpg", @"http://f.hiphotos.baidu.com/lvpics/w=1000/sign=4d69c022ea24b899de3c7d385e361c95/f31fbe096b63f6240e31d3218444ebf81a4ca3a0.jpg"];
    NSMutableArray *urlarr = [NSMutableArray array];
    for (NSString *str in url) {
        NSURL *imurl = [NSURL URLWithString:str];
        [urlarr addObject:imurl];
    }
    UIImage *placeholder = [UIImage imageNamed:@"timeline_image_loading.png"];
    // NSArray *array = @[@"home_1",@"home_2",@"home_3",@"home_4",@"home_5",@"home_6",@"home_7"];
    self.backScrollow = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, wKscreen, hKscreen+40)];
    self.backScrollow.contentSize = CGSizeMake(wKscreen, hKscreen*1.9);
    [self.view addSubview:self.backScrollow];
    self.picLbl = [[UILabel alloc]initWithFrame:CGRectMake(5, kHeight/1.7777777, kWith-10, kHeight/2.4)];
    //self.picLbl.backgroundColor = [UIColor redColor];
    self.picLbl.layer.borderWidth = 1;
    self.picLbl.layer.borderColor = [UIColor grayColor].CGColor;
    self.picLbl.layer.masksToBounds = YES;
    [self.backScrollow addSubview:self.picLbl];
    self.titleLbel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.picLbl.frame), wKscreen, 40)];
    self.titleLbel.backgroundColor = [UIColor greenColor];
    self.titleLbel.text = @"作品集";
    self.titleLbel.textAlignment = NSTextAlignmentCenter;
    self.titleLbel.font = [UIFont systemFontOfSize:20];
    [self.backScrollow addSubview:self.titleLbel];
    ZLScrolling *zl = [[ZLScrolling alloc] initWithCurrentController:self frame:CGRectMake(10, kHeight/1.745454545, kWith-20, kHeight/2.526) photos:urlarr placeholderImage:placeholder];
    // zl.timeInterval = 1;
    //zl.pageControl.pageIndicatorTintColor = [UIColor redColor];
    zl.delegate= self;
    [self.backScrollow addSubview:zl.view];
    [self creatView];
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, hKscreen*1.2, wKscreen, 40)];
    lbl.backgroundColor = [UIColor redColor];
    //[self.backScrollow addSubview:lbl];
    XHLWaterLayout * layOut = [[XHLWaterLayout alloc] init];
    layOut.delegate = self;
    self.collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleLbel.frame), wKscreen, hKscreen-64-40) collectionViewLayout:layOut];
    self.collectView.backgroundColor = [UIColor whiteColor];
    self.collectView.delegate =self;
    self.collectView.dataSource =self;
    [self.backScrollow addSubview:self.collectView];
    
    [self.collectView registerNib:[UINib nibWithNibName:@"YiShuCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ysCell"];
}
-(void)creatView
{
    self.backLbl = [[UILabel alloc]initWithFrame:CGRectMake(kWith/2-kWith/6, 15, kWith/3, kWith/3)];
    self.backLbl.layer.borderWidth = 1;
    self.backLbl.layer.borderColor = [UIColor grayColor].CGColor;
    self.backLbl.layer.masksToBounds = YES;
    self.backLbl.layer.cornerRadius = self.backLbl.frame.size.width/2;
    [self.backScrollow addSubview:self.backLbl];
    self.peopleImage = [[UIImageView alloc]initWithFrame:CGRectMake((kWith/3-kWith/3.2)/2, (kWith/3-kWith/3.2)/2, kWith/3.2, kWith/3.2)];
    self.peopleImage.layer.cornerRadius = self.peopleImage.frame.size.width/2;
    self.peopleImage.layer.masksToBounds = YES;
    [self.backLbl addSubview:self.peopleImage];
    self.peopleImage.image = [UIImage imageNamed:@"2.jpg"];
    self.nameLbl = [[UILabel alloc]initWithFrame:CGRectMake(kWith/2-kHeight/8, CGRectGetMaxY(self.backLbl.frame), kHeight/4, kHeight/16)];
    self.nameLbl.text = @"霸王别姬";
    self.nameLbl.textAlignment = NSTextAlignmentCenter;
    [self.backScrollow addSubview:self.nameLbl];
    self.jinaLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.firLineLbl.frame)+5, CGRectGetMaxY(self.nameLbl.frame), kWith/10, kHeight/16)];
    //self.jinaLbl.backgroundColor = [UIColor greenColor];
    self.jinaLbl.text = @"简介";
    self.jinaLbl.font = [UIFont systemFontOfSize:15];
    [self.backScrollow addSubview:self.jinaLbl];
    self.informationLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.jinaLbl.frame), CGRectGetMaxY(self.nameLbl.frame), kWith-kWith/6.9565, kHeight/9.6)];
    self.informationLbl.text = @"通俗的说法，美石为玉，玉是石头的精华，佛道雅称为大地舍利子，是具有祛邪避凶的灵石，在世界（尤其是东亚）各地区受到广泛欢迎的一个宝石的分类。从广义上讲，只要是美丽的石头就是玉，包括和田玉、岫岩玉、缅玉、南阳玉、蛇纹石玉、石英石玉、水晶石";
    self.informationLbl.font = [UIFont systemFontOfSize:11];
    self.informationLbl.numberOfLines = 0;
    self.informationLbl.lineBreakMode = NSLineBreakByWordWrapping;
    [self.backScrollow addSubview:self.informationLbl];
    self.firLineLbl = [[UILabel alloc]initWithFrame:CGRectMake(2, CGRectGetMaxY(self.informationLbl.frame), 1, kHeight/16)];
    self.firLineLbl.backgroundColor = [UIColor grayColor];
    [self.backScrollow addSubview:self.firLineLbl];
    self.sayLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.firLineLbl.frame)+5, CGRectGetMaxY(self.informationLbl.frame), kHeight/16, kHeight/16)];
    self.sayLbl.text = @"名言";
    self.sayLbl.font = [UIFont systemFontOfSize:15];
    [self.backScrollow addSubview:self.sayLbl];
    self.hengLineLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.sayLbl.frame), 100, 1)];
    self.hengLineLbl.backgroundColor = [UIColor grayColor];
    [self.backScrollow addSubview:_hengLineLbl];
    self.sayingLbl = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.firLineLbl.frame), CGRectGetMaxY(self.hengLineLbl.frame), kWith-10, kHeight/16)];
    //self.sayingLbl.backgroundColor = [UIColor greenColor];
    self.sayingLbl.text = @"通俗的说法，美石为玉，玉是石头的精华，佛道雅称为大地舍利子";
    self.sayingLbl.lineBreakMode = NSLineBreakByCharWrapping;
    self.sayingLbl.numberOfLines = 0;
    self.sayingLbl.font = [UIFont systemFontOfSize:11];
    [self.backScrollow addSubview:self.sayingLbl];
    self.seconLbl = [[UILabel alloc]initWithFrame:CGRectMake(kWith-2-1, CGRectGetMaxY(self.hengLineLbl.frame), 1, kHeight/16)];
    self.seconLbl.backgroundColor = [UIColor grayColor];
    [self.backScrollow addSubview:self.seconLbl];
    self.sHLineLbl = [[UILabel alloc]initWithFrame:CGRectMake(kWith - kWith/3.2, CGRectGetMaxY(self.sayingLbl.frame), kWith/3.2, 1)];
    self.sHLineLbl.backgroundColor = [UIColor grayColor];
    [self.backScrollow addSubview:self.sHLineLbl];
    //    self.picLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.seconLbl.frame)+10, kWith - 20, 200)];
    //    self.picLbl.backgroundColor = [UIColor redColor];
    //    [self.view addSubview:self.picLbl];
}
- (void)zlScrolling:(ZLScrolling *)zlScrolling clickAtIndex:(NSInteger)index
{
   // NSLog(@"点击到------%d",index);
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YiShuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ysCell" forIndexPath:indexPath];
    return cell;
}
-(CGFloat)waterLayout:(UICollectionViewLayout *)waterLayout itemWidth:(CGFloat)itemWidth indexPath:(NSIndexPath *)indexPath
{
    return 200;
}

-(NSInteger)columnCountInWaterflowLayout:(UICollectionViewLayout *)layout
{
    return XHLDefaultColumnCount;
}
-(CGFloat)rowMarginInWaterflowLayout:(UICollectionViewLayout *)layout
{
    return XHLDefaultRowMargin;
}
//-(UIEdgeInsets)edgeInsetsInWaterflowLayout:(UICollectionViewLayout *)layout
//{
//    return XHLDefaultEdgeInsets;
//}


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
