//
//  ZidingViewController.m
//  XLCollectionLayout
//
//  Created by giikylee on 16/6/8.
//  Copyright © 2016年 yuanxiaolong. All rights reserved.
//

#import "ZidingViewController.h"
#import "HCollectionLayout.h"
#import "XLPhotoCell.h"
#import "ZiView.h"
@interface ZidingViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)ZiView *zView;
@end

@implementation ZidingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
    self.view.backgroundColor = [UIColor whiteColor];
//    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    self.zView = [[ZiView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.zView];
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];//allocate titleView
    //UIColor *color =  self.navigationController.navigationBar.tintColor;
    //[titleView setBackgroundColor:color];
    
//    UISearchBar *searchBar = [[UISearchBar alloc] init];
//    searchBar.delegate = self;
//    searchBar.frame = CGRectMake(0, 0, 150, 35);
//    searchBar.backgroundColor = color;
//    searchBar.layer.cornerRadius = 18;
//    searchBar.layer.masksToBounds = YES;
    [titleView addSubview:self.zView.apprSearchBar];
    
    //Set to titleView
    self.navigationItem.titleView = titleView;
    /*UIBarButtonItem *searchButton = [[UIBarButtonItem alloc]initWithCustomView:self.zView.apprSearchBar];
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObject:searchButton];*/
    //设置每个item的大小  这个属性最好在控制器中设置
    //self.navigationItem.titleView = self.zView.apprSearchBar;
    
    
    self.zView.collectionView.delegate = self;
    self.zView.collectionView.dataSource = self;
    [self.zView.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XLPhotoCell class]) bundle:nil] forCellWithReuseIdentifier:@"cell"];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XLPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"photo_sample_0%ld",indexPath.item + 1]];
    
    
    return cell;
    
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击的item---%zd",indexPath.item);
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
