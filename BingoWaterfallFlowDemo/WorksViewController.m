//
//  WorksViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/7/28.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "WorksViewController.h"

#import "ZWCollectionViewFlowLayout.h"
#import "YiShuCollectionViewCell.h"
#import "XHLWaterLayout.h"

static const NSInteger XHLDefaultColumnCount = 2;

@interface WorksViewController ()<XHLWaterLayoutDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,retain)UICollectionView * collectView;
@end

@implementation WorksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.view.backgroundColor = [UIColor whiteColor];
    XHLWaterLayout * layOut = [[XHLWaterLayout alloc] init];
    layOut.delegate = self;
    self.collectView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:layOut];
    //self.collectView.backgroundColor = [UIColor greenColor];
    self.collectView.delegate =self;
    self.collectView.dataSource =self;
    [self.view addSubview:self.collectView];
    
    [self.collectView registerNib:[UINib nibWithNibName:@"YiShuCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ysCell"];
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
    return arc4random()%100+200;
}

-(NSInteger)columnCountInWaterflowLayout:(UICollectionViewLayout *)layout
{
    return XHLDefaultColumnCount;
}
-(UIEdgeInsets)edgeInsetsInWaterflowLayout:(UICollectionViewLayout *)layout
{
    return UIEdgeInsetsMake(0, 10, 0, 0);
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
