//
//  LinkStoreViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/4/29.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "LinkStoreViewController.h"
#import "LinkStoreCollectionViewCell.h"
#import "SDCycleScrollView.h"
#import "StoreScrollView.h"
@interface LinkStoreViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate, SDCycleScrollViewDelegate>
@property(nonatomic,strong)NSArray *imageURL;//存放网络图片然后在scrollow上显示
@property(nonatomic,strong)StoreScrollView *scView;
@end

@implementation LinkStoreViewController
-(void)loadView
{
    self.scView = [[StoreScrollView alloc]initWithFrame:CGRectMake(0, 0, wKscreen, hKscreen/2 +hKscreen/6)];
    self.scView.contentSize = CGSizeMake(wKscreen, hKscreen+hKscreen/5+30);
    self.scView.showsVerticalScrollIndicator = NO;
    self.view = _scView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatView];
    [self data];
}
-(void)creatView
{
    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0.f;
    flowLayout.minimumInteritemSpacing = 0.f;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.scView.headerView.frame)+hKscreen/6, wKscreen, hKscreen-hKscreen/6) collectionViewLayout:flowLayout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.bounces = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:collectionView];
    [collectionView registerNib:[UINib nibWithNibName:@"LinkStoreCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    //[collectionView registerClass:[HeaderCell class] forCellWithReuseIdentifier:@"hCell"];
    //[collectionView registerNib:[UINib nibWithNibName:@"AllTitleCell" bundle:nil] forCellWithReuseIdentifier:@"tCell"];
    
}
//数据处理
-(void)data
{
    
            self.imageURL = @[[NSURL URLWithString:@"http://p1.qqyou.com/pic/UploadPic/2013-3/19/2013031923222781617.jpg"],[NSURL URLWithString:@"http://cdn.duitang.com/uploads/item/201409/27/20140927192649_NxVKT.thumb.700_0.png"],[NSURL URLWithString:@"http://img4.duitang.com/uploads/item/201409/27/20140927192458_GcRxV.jpeg"],[NSURL URLWithString:@"http://cdn.duitang.com/uploads/item/201304/20/20130420192413_TeRRP.thumb.700_0.jpeg"]];
            SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.scView.headerView.frame.size.width, self.scView.headerView.frame.size.height) imageURLsGroup:_imageURL];
            NSArray *titles = @[@"感谢",
                                @"支持",
                                @"感谢您的支持",
                                @"您的支持"
                                ];
            [self.scView.headerView addSubview:cycleScrollView];
            cycleScrollView.autoScrollTimeInterval = 100.f;
            cycleScrollView.delegate =self;
            cycleScrollView.titlesGroup = titles;
            cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    //return 3;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    /*if (section == 0) {
        return 1;
    }
    else if (section == 1)
    {
        return 1;
    }
    else
    {
        return 20;
    }*/
    return 20;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        HeaderCell *hCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"hCell" forIndexPath:indexPath];
//        self.imageURL = @[[NSURL URLWithString:@"http://p1.qqyou.com/pic/UploadPic/2013-3/19/2013031923222781617.jpg"],[NSURL URLWithString:@"http://cdn.duitang.com/uploads/item/201409/27/20140927192649_NxVKT.thumb.700_0.png"],[NSURL URLWithString:@"http://img4.duitang.com/uploads/item/201409/27/20140927192458_GcRxV.jpeg"],[NSURL URLWithString:@"http://cdn.duitang.com/uploads/item/201304/20/20130420192413_TeRRP.thumb.700_0.jpeg"]];
//        SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, hCell.myView.frame.size.width, hCell.myView.frame.size.height) imageURLsGroup:_imageURL];
//        NSArray *titles = @[@"感谢",
//                            @"支持",
//                            @"感谢您的支持",
//                            @"您的支持"
//                            ];
//        [hCell.myView addSubview:cycleScrollView];
//        cycleScrollView.autoScrollTimeInterval = 100.f;
//        cycleScrollView.delegate =self;
//        cycleScrollView.titlesGroup = titles;
//        cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
//        return hCell;
//    }
//    else if (indexPath.section == 1)
//    {
//        AllTitleCell *tCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tCell" forIndexPath:indexPath];
//        
//        return tCell;
//    }
//    else
//    {
    LinkStoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
//    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 0) {
//        return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height/3*2);
//    }
//    else if (indexPath.section == 1)
//    {
//        return CGSizeMake(self.view.frame.size.width, 80);
//    }
//    else
//    {
        return CGSizeMake(self.view.frame.size.width/3, self.view.frame.size.height/3.692);
    //}
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
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
