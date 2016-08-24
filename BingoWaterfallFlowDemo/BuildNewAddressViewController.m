//
//  BuildNewAddressViewController.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 5/23/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import "BuildNewAddressViewController.h"
#import "AddressModel.h"
#import "AddressDBTool.h"

@interface BuildNewAddressViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation BuildNewAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [AddressDBTool ss_initDB];
    self.saveButton.enabled = NO;
}

/**
 *  选择所在地区
 *
 *  @param sender <#sender description#>
 */
- (IBAction)locationInSectionButton:(UIButton *)sender {
    debugLog(@"选择所在地区");
    
}
/**
 *  设置轻松购
 *
 *  @param sender <#sender description#>
 */

- (IBAction)enjoyShoppingButton:(UIButton *)sender {
    debugLog(@"设置轻松购");
}

/**
 *  保存收货地址按钮
 *
 *  @param sender <#sender description#>
 */
- (IBAction)saveButton:(UIButton *)sender {
    
    NSInteger nowIndex = self.passInsertDBIndex;
    debugLog(@"记录的索引值 == %ld",(long)nowIndex);
    /**
     *  说明是从新建地址push来的
     */
    if (self.receiveAddNewButtonTag == 10000) {
        if ([self.delegate respondsToSelector:@selector(viewController:model:)]) {
            AddressModel *model = [[AddressModel alloc] init];
            model.name = self.nameTF.text;
            model.phone = self.phoneTF.text;
            model.address = self.addressTF.text;
            [self.delegate viewController:self model:model];
            [AddressDBTool ss_insertAddress:model];
    
        }
//        ++i;
        ++self.passInsertDBIndex;
        
        debugLog(@"点击新建按钮后的索引值 == %ld",(long)self.passInsertDBIndex);
    }
    /**
     *  说明是点击修改按钮push来的
     */
    else {
        if ([self.delegate respondsToSelector:@selector(modifyViewController:model:index:)]) {
            AddressModel *model = [[AddressModel alloc] init];
            model.name = self.nameTF.text;
            model.phone = self.phoneTF.text;
            model.address = self.addressTF.text;
            [self.delegate modifyViewController:self model:model index:self.receiveModifyButtonTag];
//            [AddressDBTool ss_updateAddress:model];
//            debugLog(@"记录的索引值11 == %ld",(long)self.passInsertDBIndex);
//            if (nowIndex == self.passInsertDBIndex) {
                 [AddressDBTool ss_updateAddress:model index:self.receiveModifyButtonTag + 1];
//            } else {
            
//                [AddressDBTool ss_updateAddress:model index:self.passInsertDBIndex];

//            }
          }
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    //self.saveButton.enabled = YES;
    if ((self.nameTF.text.length!=0)  && (self.phoneTF.text.length!=0) && (self.addressTF.text.length!=0)) {
        self.saveButton.enabled = YES;
       
       
    }
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
