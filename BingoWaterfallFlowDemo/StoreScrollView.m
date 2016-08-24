//
//  StoreScrollView.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/5.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "StoreScrollView.h"
#import "TitleCell.h"
@implementation StoreScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setupView];
    }
    return self;
}
-(void)p_setupView
{
    self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, wKscreen, hKscreen/2)];
    [self addSubview:_headerView];
    
    self.storeView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headerView.frame), self.frame.size.width, 30)];
    [self addSubview:self.storeView];
    self.youhuiBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.youhuiBtn.frame = CGRectMake(0, 0, self.frame.size.width/3, 30);
    [self.youhuiBtn setTitle:@"本店优惠" forState:UIControlStateNormal];
    [self.youhuiBtn setTitleColor:[UIColor colorWithRed:28/255.0 green:164/255.0 blue:70/255.0 alpha:1] forState:UIControlStateNormal];
    [self.youhuiBtn addTarget:self action:@selector(youhuiAction ) forControlEvents:UIControlEventTouchUpInside];
    [self.storeView addSubview:self.youhuiBtn];
    
    self.collectionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.collectionBtn.frame = CGRectMake(self.frame.size.width/3, 0, self.frame.size.width/3, 30);
    [self.collectionBtn setTitle:@"🌟" forState:UIControlStateNormal];
    [self.collectionBtn addTarget:self action:@selector(collectionAction ) forControlEvents:UIControlEventTouchUpInside];
    [self.storeView addSubview:self.collectionBtn];
    
    self.lingquanBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.lingquanBtn.frame = CGRectMake(self.frame.size.width/3*2, 0, self.frame.size.width/3, 30);
    [self.lingquanBtn setTitle:@"领券中心" forState:UIControlStateNormal];
    [self.lingquanBtn setTitleColor:[UIColor colorWithRed:28/255.0 green:164/255.0 blue:70/255.0 alpha:1] forState:UIControlStateNormal];
    [self.lingquanBtn addTarget:self action:@selector(lingquanAction ) forControlEvents:UIControlEventTouchUpInside];
    [self.storeView addSubview:self.lingquanBtn];
    
    
    UICollectionViewFlowLayout *cFlowLayout = [[UICollectionViewFlowLayout alloc]init];
    cFlowLayout.minimumLineSpacing = 0.f;
    cFlowLayout.minimumInteritemSpacing = 0.f;
    cFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CGSize item =   CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds)/7, hKscreen/6-30);
    cFlowLayout.itemSize = item;
    cFlowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    UICollectionView *tcollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.storeView.frame)+1, wKscreen, hKscreen/6-30) collectionViewLayout:cFlowLayout];
    tcollectionView.backgroundColor = [UIColor whiteColor];
    tcollectionView.delegate = self;
    tcollectionView.dataSource = self;
    //collectionView.showsVerticalScrollIndicator = YES;
    tcollectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:tcollectionView];
    [tcollectionView registerNib:[UINib nibWithNibName:@"TitleCell" bundle:nil] forCellWithReuseIdentifier:@"titleCell"];
    self.titleArray = [NSArray arrayWithObjects:@"情调",@"美食",@"美妆",@"母婴",@"居家",@"健康",@"跨境",@"情调",@"美食",@"美妆",@"母婴",@"居家",@"健康",@"跨境",@"情调",@"美食",@"美妆",@"母婴",@"居家",@"健康", nil];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TitleCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"titleCell" forIndexPath:indexPath];
    titleCell.backLabel.text = self.titleArray[indexPath.row];
    return titleCell;
}
-(void)youhuiAction
{
    //NSLog(@"我是 本店优惠");
}
-(void)collectionAction
{
    //NSLog(@"我是星星");
}
-(void)lingquanAction
{
    //NSLog(@"我是领券中心");
}
@end