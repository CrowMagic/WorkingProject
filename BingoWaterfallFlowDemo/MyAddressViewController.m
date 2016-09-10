//
//  MyAddressViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 5/23/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import "MyAddressViewController.h"

#import "AddressCell.h"
#import "AddressModel.h"
#import "AddressDBTool.h"

#import "BuildNewAddressViewController.h"


@interface MyAddressViewController ()<UITableViewDelegate,UITableViewDataSource,BuildNewAddressViewControllerDelegate>
@property (nonatomic, strong) UITableView *addressTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;//收货地址数据源
//@property (nonatomic, strong) BuildNewAddressViewController *modifyNewAddressVC;
@end

@implementation MyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收货地址";
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.addressTableView];
    self.dataArray = [[NSMutableArray alloc] init];

    
    

//    self.modifyNewAddressVC = [[BuildNewAddressViewController alloc] init];
//    self.modifyNewAddressVC.passInsertDBIndex = self.dataArray.count;
//    self.modifyNewAddressVC.delegate = self;
    
//    BuildNewAddressViewController *vc = [[BuildNewAddressViewController alloc] init];
//    vc.passInsertDBIndex = self.dataArray.count;
//    vc.delegate = self;
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    [AddressDBTool ss_initDB];
    self.dataArray = (NSMutableArray *)[AddressDBTool ss_selectAllAddress];
    //数据源赋值以后，把默认地址放在第一个显示
    for (int i = 0; i < self.dataArray.count; i++) {
        AddressModel *model = self.dataArray[i];
        if ([model.currentAddress isEqualToString:@"yes"]) {
            [self.dataArray exchangeObjectAtIndex:i withObjectAtIndex:0];
        }
    }

}



/**
 *  新建收货地址
 *
 *  @param sender
 */
- (IBAction)motifyAddressButton:(UIButton *)sender {
    
    BuildNewAddressViewController *buildNewAddressVC = [[BuildNewAddressViewController alloc] init];
    buildNewAddressVC.delegate = self;
    buildNewAddressVC.receiveAddNewButtonTag = 10000;
    
    [self.navigationController pushViewController:buildNewAddressVC animated:YES];
}

#pragma mark - BuildNewAddressViewControllerDelegate

- (void)viewController:(UIViewController *)viewController model:(AddressModel *)model {
    [self.dataArray addObject:model];
    debugLog(@"%@",self.dataArray.description);
    [self.addressTableView reloadData];
}

- (void)modifyViewController:(UIViewController *)viewController model:(AddressModel *)model index:(NSInteger)index {
    [self.dataArray replaceObjectAtIndex:index withObject:model];
    [self.addressTableView reloadData];
}


#pragma mark - UITableViewDelegateAndDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.editButton addTarget:self action:@selector(editCell:) forControlEvents:UIControlEventTouchUpInside];
    cell.editButton.tag = indexPath.section;
    
    
    [cell.deleteButton addTarget:self action:@selector(deleteCell:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteButton.tag = indexPath.section;
    
    [cell.addressMoRenButton addTarget:self action:@selector(isSetMoRenAddress:) forControlEvents:UIControlEventTouchUpInside];
    cell.addressMoRenButton.tag = indexPath.section;
    
    
    
    
    AddressModel *model = self.dataArray[indexPath.section];

    UIColor *selectColor = [UIColor colorWithRed:28/255.0 green:164/255.0 blue:70/255.0 alpha:1];
    BOOL selectAddress = [model.currentAddress isEqualToString:@"yes"];
    [self configAddressFlag:cell.addressMoRenButton
                      color:selectAddress ? selectColor : [UIColor lightGrayColor]
                   isSelect:selectAddress];
    
    
    cell.nameLabel.text = model.name;
    cell.phoneLabel.text = model.phone;
    
    NSMutableString *addressString =[[NSMutableString alloc] initWithString:model.selectLocation];
    [addressString appendString:model.address];
    cell.addressLabel.text = addressString;
    
    debugLog(@"第 %ld model.currentAddress = %@",(long)indexPath.section, model.currentAddress);
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (void)configAddressFlag:(UIButton *)button color:(UIColor *)color isSelect:(BOOL)select {
    
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
    circleView.layer.borderColor = color.CGColor;
    circleView.layer.borderWidth = 1;
    circleView.layer.cornerRadius = 8;
    //只有设置了默认地址，才会创建中间绿色view的对象，并添加到circleView上
    if (select == YES) {
        UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(4, 4, 8, 8)];
        blueView.backgroundColor = color;
        blueView.layer.cornerRadius = 4;
        [circleView addSubview:blueView];
    }
    UIGraphicsBeginImageContext(circleView.bounds.size);
    [circleView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [button setImage:image forState:UIControlStateNormal];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -2, 0, 0);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -4);

}



- (void)isSetMoRenAddress:(UIButton *)sender {
    debugLog(@"设置默认地址");
    
    //如果用户点击了此按钮，说明他设置此地址为默认地址，我们用字符串@"yes"来表示，然后写入数据库
    debugLog(@"sender.tag == %ld", (long)sender.tag);
    
    
    //由于数据库中的ID是从1开始的，所以创建一个临时的数组并占据第一个元素，这样就可以按照索引使用self.dataArray了
    NSMutableArray *currentArray = [NSMutableArray arrayWithObject:@"空的占位元素"];
    //由于self.dataArray 是在viewDidLoad中赋值的，相当于从database中copy一份数据，新建地址后，虽然都更新了数据（self.dataArray, database),如果用self.dataArray,那么此时的数据块始终属于self.dataArray中的数据，并没有修改database中的数据，所以要重新查询表（），然后下面同步更新self.dataArray
    //后来为了保证新建的识货地址能够新建以后马上删除，要一一对应表中的recordIDNumber(一开始的写法是新建地址返回，虽然刷新表了，且也写入数据库了，但此时要删除新建的recordIDNumber 为0，这个值只有再次查询表时才会和数据库表中的addressID同步)， 把sel.dataArray的赋值操作放在了方法viewWillAppear中，相当于每次刷新表或进入这个页面都是从数据库中取值，使
    [currentArray addObjectsFromArray:[AddressDBTool ss_selectAllAddress]];
    
    for (int i = 1; i < currentArray.count; i++) {
        //更新数据库中所有的currentAddress = no
        AddressModel *modelSqlite = currentArray[i];
        modelSqlite.currentAddress = @"no";
        [AddressDBTool ss_updateAddress:modelSqlite index:modelSqlite.recordIDNumber];
    }
    //更新选中某一行设置为默认地址的 currentAddress = yes
    AddressModel *model = currentArray[sender.tag+1];
    model.currentAddress = @"yes";
    
    debugLog(@"此处传递额行号为：%ld",(long)model.recordIDNumber);
    [AddressDBTool ss_updateAddress:model index:model.recordIDNumber ];
    
    
    
    // 同步更新当前数据源中所有的currentAddress = no,简单暴力，不用再去交换是否选中的索引
    for (AddressModel *modelDataArray in self.dataArray) {
        modelDataArray.currentAddress = @"no";
    }
    //同步更新当前数据源中所选中的 currentAddress = yes
    AddressModel *modelDataArray = self.dataArray[sender.tag];
    modelDataArray.currentAddress = @"yes";

    [self.addressTableView reloadData];
}


- (void)editCell:(UIButton *)sender {
    debugLog(@"编辑收货地址");
    BuildNewAddressViewController *buildNewAddressVC = [[BuildNewAddressViewController alloc] init];
    buildNewAddressVC.delegate = self;
    buildNewAddressVC.receiveModifyButtonTag = sender.tag;
    
    [self.navigationController pushViewController:buildNewAddressVC animated:YES];
    
}

- (void)deleteCell:(UIButton *)sender {
    debugLog(@"删除收货地址");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定要删除？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AddressModel *model = self.dataArray[sender.tag];
        debugLog(@"要删除的行号为 = %ld", (long)sender.tag);
        debugLog(@"要删除的model.recordNumber为 = %d", model.recordIDNumber);
        [self.dataArray removeObjectAtIndex:sender.tag];
        [self.addressTableView reloadData];
        
        [AddressDBTool ss_deleteAllAddress:model];
        
        
        if (self.dataArray.count == 0) {
            [AddressDBTool ss_dropAddress];
        }
        
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - lazyLoad


- (UITableView *)addressTableView {
    if (!_addressTableView) {
        _addressTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, wKscreen, hKscreen - 44 - 50-64) style:UITableViewStyleGrouped];
        _addressTableView.delegate = self;
        _addressTableView.dataSource = self;
        _addressTableView.rowHeight = 155;
         [_addressTableView registerNib:[UINib nibWithNibName:@"AddressCell" bundle:nil] forCellReuseIdentifier:@"AddressCell"];
    }
    return _addressTableView;
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
