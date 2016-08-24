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
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) BuildNewAddressViewController *modifyNewAddressVC;
@end

@implementation MyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view addSubview:self.addressTableView];
    self.dataArray = [[NSMutableArray alloc] init];

    
    
    [AddressDBTool ss_initDB];
    self.dataArray = (NSMutableArray *)[AddressDBTool ss_selectAllAddress] ;
    
    
    self.modifyNewAddressVC = [[BuildNewAddressViewController alloc] init];
    self.modifyNewAddressVC.passInsertDBIndex = self.dataArray.count;
    self.modifyNewAddressVC.delegate = self;
    
}
/**
 *  新建收货地址
 *
 *  @param sender <#sender description#>
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
    [cell.editButton addTarget:self action:@selector(editCell:) forControlEvents:UIControlEventTouchUpInside];
    cell.editButton.tag = indexPath.section;
    
    
    [cell.deleteButton addTarget:self action:@selector(deleteCell:) forControlEvents:UIControlEventTouchUpInside];
    cell.deleteButton.tag = indexPath.section;
    AddressModel *model = self.dataArray[indexPath.section];
    cell.nameLabel.text = model.name;
    cell.phoneLabel.text = model.phone;
    cell.addressLabel.text = model.address;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}


- (void)editCell:(UIButton *)sender {
    debugLog(@"编辑收货地址");
//    BuildNewAddressViewController *buildNewAddressVC = [[BuildNewAddressViewController alloc] init];
//    self.modifyNewAddressVC.delegate = self;
    self.modifyNewAddressVC.receiveModifyButtonTag = sender.tag;
    
    [self.navigationController pushViewController:self.modifyNewAddressVC animated:YES];

}

- (void)deleteCell:(UIButton *)sender {
    debugLog(@"删除收货地址");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定要删除？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        AddressModel *model = self.dataArray[sender.tag];

        [self.dataArray removeObjectAtIndex:sender.tag];
        [self.addressTableView reloadData];
        
        
        
        debugLog(@"%@",model);
        
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
