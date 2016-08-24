//
//  ZiView.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/6/8.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "ZiView.h"
#import "HCollectionLayout.h"
@implementation ZiView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self set_up];
    }
    return self;
}
-(void)set_up
{
    self.backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.backScrollView.contentSize = CGSizeMake(0, self.frame.size.height *2);
    self.backScrollView.bounces = NO;
    self.backScrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.backScrollView];
    
    self.apprSearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
    self.apprSearchBar.layer.borderWidth = 8;
    self.apprSearchBar.layer.borderColor = [UIColor whiteColor].CGColor;
    self.apprSearchBar.layer.cornerRadius = 8;
    self.apprSearchBar.layer.masksToBounds = YES;
    self.apprSearchBar.keyboardType = UIKeyboardTypeDefault;
    self.apprSearchBar.placeholder = @"sousuo";
    
    //[self addSubview:self.apprSearchBar];
    self.mingyuLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    self.mingyuLbl.textAlignment = NSTextAlignmentCenter;
    self.mingyuLbl.text = @"名玉鉴赏";
    [self.backScrollView addSubview:self.mingyuLbl];
    HCollectionLayout *hLayout = [[HCollectionLayout alloc]init];
    hLayout.itemSize = CGSizeMake(150, 150);
    CGFloat collectionW = self.frame.size.width;
    CGFloat collectionH = self.frame.size.height/2.4;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.mingyuLbl.frame), collectionW, collectionH) collectionViewLayout:hLayout];
    self.collectionView.backgroundColor = [UIColor grayColor];
    [self.backScrollView addSubview:self.collectionView];
    self.inforYuLbl = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.collectionView.frame)+10, self.frame.size.width-20, self.frame.size.height-CGRectGetMaxY(self.collectionView.frame)-10)];
   // self.inforYuLbl.backgroundColor = [UIColor redColor];
    self.inforYuLbl.text = @"   软玉是中国矿物学家对英文Nephrite 的译名。这一英文名称源于希腊语，有“肾脏”之意。这是因为古代洲认为将这种玉石佩挂在腰部可以治愈肾病（久术武夫：《宝石贵金属辞典》）。然而不论欧洲人也好，喜欢玉器的墨西哥和新西兰人也好，都没有中国人使用软玉的历史悠久。中国在世界上有“玉石之国”之称，这同发现和使用软玉的悠久历史有关。软玉在中国有白玉、青玉、碧玉、黄玉和墨玉等品种。它们与硬玉不同，是由角闪石族矿物中透闪石阳起石矿物（以透闪石为主）组成的致密块体。在显微镜下观察，软玉同硬玉一样也呈纤维状结构。这种由透闪石或阳起石组成的纤维状结构，是软玉具有细腻和坚韧性质的主要原因。透闪石是一种含水和氟的钙镁硅酸盐，其成分中常含有 4%以下的铁，当铁含量超过4%时即过渡为阳起石。软玉常见颜色有白、灰白、绿、暗绿、黄、黑等色。多数不透明，个别半透明，有玻璃光泽。软玉的品种主要是按颜色不同来划分的。白玉中最佳者白如羊脂，称“羊脂玉”。青玉呈灰白至青白色，有人将灰白色的青玉称为“青白玉”。碧玉呈绿至暗绿色，有时可见黑色脏点，是含杂质如铬尖晶石矿物等所致。当含杂质多而 呈黑色时，即为珍贵的墨玉。黄玉也是一种较珍贵的品种。青玉中有糖水黄色皮壳，现有人称其为“糖玉”。白色略带粉红色者有人称为“粉玉”。虎皮色的则称为 “虎皮玉”等。所知，国内除台湾丰田地区产软玉外（包括透闪石猫眼石），主要产地在新疆。新疆和田玉的悠久历史";
    self.inforYuLbl.textColor = [UIColor grayColor];
    self.inforYuLbl.font = [UIFont systemFontOfSize:14];
    self.inforYuLbl.numberOfLines = 0;
    self.inforYuLbl.lineBreakMode = NSLineBreakByCharWrapping;
    [self.backScrollView addSubview:self.inforYuLbl];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
