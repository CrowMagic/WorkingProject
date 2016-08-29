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
//借用ss_Setting/ss_selectDateView.h中的xib
//#import "ss_selectDateView.h"

@interface BuildNewAddressViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *postcodeTF;
@property (weak, nonatomic) IBOutlet UILabel *choseLocationLabel;

//制作省市区
@property (nonatomic, strong) NSArray *provienceList;//省份列表(包含直辖市)
@property (nonatomic, strong) NSArray *cityList;//城市列表
@property (nonatomic, strong) NSArray *areaList;//城区列表
@property (nonatomic, assign) NSInteger selectOneRow;//第一级选中的下标
@property (nonatomic, assign) NSInteger selectTwoRow;//第二级选中的下标
@property (nonatomic, assign) NSInteger selectThreeRow;//第三级选中的下标



@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, strong) UIButton *leftCancel;
@property (nonatomic, strong) UIButton *rightEnsure;
@property (nonatomic, strong) UIView *maskView;



@end

@implementation BuildNewAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.saveButton.enabled = NO;
    self.saveButton.backgroundColor = [UIColor lightGrayColor];
    
    debugLog(@"self.receiveModifyButtonTag = %d", self.receiveModifyButtonTag);
    
    debugLog(@"self.receiveAddNewButtonTag = %d", self.receiveAddNewButtonTag);
    
    [AddressDBTool ss_initDB];
    
    debugLog(@"model = %@", [AddressDBTool ss_selectAllAddress]);
    
    //只有从编辑跳转过来才需要把已经有的地址信息传递过来
    if (self.receiveAddNewButtonTag != 10000) {
        AddressModel *model = [AddressDBTool ss_selectAllAddress][self.receiveModifyButtonTag];
        self.nameTF.text = model.name;
        self.phoneTF.text = model.phone;
        self.choseLocationLabel.text = model.selectLocation;
        self.addressTF.text = model.address;
        self.postcodeTF.text = model.postcode;
        debugLog(@"传递过来的数据在数据库表中的行号：%@", model.recordIDNumber);
    }
    
    
    
    
    debugLog(@"选择所在地区");
    [self configData];
    [self configPickerView];
    

    
}

/**
 *  选择所在地区
 *
 *  @param sender
 */
- (IBAction)locationInSectionButton:(UIButton *)sender {
    
    [self.view endEditing:YES];
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);

    
        [UIView animateWithDuration:0.5 animations:^{
            self.backgroundView.center = CGPointMake(width/2, height/2);

        } completion:^(BOOL finished) {
                [self.view addSubview:self.maskView];
            [self.view bringSubviewToFront:self.backgroundView];
        }];


}

- (void)configData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *error;
    self.provienceList = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    [self configCityData:0];
    [self configAreaData:0];
}

- (void)configCityData:(NSInteger)row {
    if ([self.provienceList[row][@"type"] intValue] == 0) {
        self.cityList = [[NSArray alloc] initWithObjects:self.provienceList[row], nil];
    } else {
        NSMutableArray *array = [NSMutableArray array];
        for (NSArray *city in self.provienceList[row][@"sub"]) {
            [array addObject:city];
        }
        self.cityList = array;
    }
}

- (void)configAreaData:(NSInteger)row {
    if ([self.provienceList[self.selectOneRow][@"type"] intValue] == 0) {
        NSMutableArray *areaList = [[NSMutableArray alloc] init];
        for (NSArray *cityDict in self.provienceList[self.selectOneRow][@"sub"]) {
            [areaList addObject:cityDict];
        }
        self.areaList = areaList;
    } else {
        NSMutableArray *areaList = [[NSMutableArray alloc] init];
        for (NSArray *cityDict in self.cityList[row][@"sub"]) {
            [areaList addObject:cityDict];
        }
        self.areaList = areaList;

    }
}

- (void)configPickerView {
    [self.backgroundView addSubview:self.picker];
    [self.backgroundView addSubview:self.leftCancel];
    [self.backgroundView addSubview:self.rightEnsure];
//    [self.view addSubview:self.maskView];
    [self.view addSubview:self.backgroundView];
    
}

- (void)cancleSelectLocation {
//   self.choseLocationLabel.text = @"";
//    self.isShowLocation = NO;
//    [self.picker reloadAllComponents];

//    [self ensureSelectLocation];
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
    
            [UIView animateWithDuration:0 animations:^{
        
                self.backgroundView.center = CGPointMake(width/2, height* 3/2);
                [self.maskView removeFromSuperview];
    
            }];
    
    
}

- (void)ensureSelectLocation {
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
    [UIView animateWithDuration:0 animations:^{
        self.backgroundView.center = CGPointMake(width/2, height* 3/2);
        [self.maskView removeFromSuperview];
    }];
   


}


#pragma mark - lazyLoadSelectLocationCompoment

- (UIView *)backgroundView {
    if (!_backgroundView) {
        CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
        CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, width-20, 300)];
        _backgroundView.center = CGPointMake(width/2, height*3/2);
        _backgroundView.backgroundColor = [UIColor whiteColor];
    }
    return _backgroundView;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = [UIColor lightGrayColor];
        _maskView.alpha = 0.7;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancleSelectLocation)];
        [_maskView addGestureRecognizer:tap];
        
        
    }
    return _maskView;
}




- (UIButton *)leftCancel {
    if (!_leftCancel) {
        _leftCancel = [UIButton buttonWithType:UIButtonTypeSystem];
        _leftCancel.frame = CGRectMake(0, 250, 50, 50);
        [_leftCancel setTitle:@"取消" forState:UIControlStateNormal];
        [_leftCancel addTarget:self action:@selector(cancleSelectLocation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftCancel;
}

- (UIButton *)rightEnsure {
    if (!_rightEnsure) {
        _rightEnsure = [UIButton buttonWithType:UIButtonTypeSystem];
        _rightEnsure.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds)-70, 250, 50, 50);
        [_rightEnsure setTitle:@"确定" forState:UIControlStateNormal];
        [_rightEnsure addTarget:self action:@selector(ensureSelectLocation) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightEnsure;
}

- (UIPickerView *)picker {
    if (!_picker) {
        _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 250)];
        _picker.showsSelectionIndicator = YES;
        _picker.delegate = self;
        _picker.dataSource = self;
    }
    return _picker;
}




#pragma mark - UIPickerViewDelegateAndDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    if (component == 0) {
        return self.provienceList.count;
    } else if (component == 1) {
        return self.cityList.count;
    } else {
        return self.areaList.count;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    static NSInteger oneRow = 0;
    static NSInteger tweRow = 0;
    static NSInteger threeRow = 0;
    if (component == 0) {
        
        self.selectOneRow = row;
//        [self getCitydate:row];
        [self configCityData:row];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
//        [self getAreaDate:0];
        [self configAreaData:0];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        if ([self.provienceList[self.selectOneRow][@"type"] intValue] == 0) {
            
            self.selectTwoRow = 0;
        }
        oneRow = row;
        tweRow = 0;
        threeRow = 0;
        
    }
    if (component == 1){
        
        self.selectTwoRow = row;
//        [self getAreaDate:row];
        [self configAreaData:row];
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
        tweRow = row;
        threeRow = 0;
    }
    if (component == 2){
        
        self.selectThreeRow = row;
        threeRow = row;
    }
    
  
        NSMutableString *regionAddress = [[NSMutableString alloc] init];
        if (oneRow > 0 &&[self.provienceList[self.selectOneRow][@"type"] intValue] != 0 ) {
            [regionAddress appendFormat:@"%@省",self.provienceList[self.selectOneRow][@"name"]];
            
        }
        if (tweRow > 0 || [self.provienceList[self.selectOneRow][@"type"] intValue] == 0){
            
            [regionAddress appendFormat:@"%@市",self.cityList[self.selectTwoRow][@"name"]];
        }
        if (threeRow > 0 ){
            [regionAddress appendFormat:@"%@",self.areaList[self.selectThreeRow][@"name"]];
        }
        self.choseLocationLabel.text = regionAddress;

}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    if (component == 0) {
        label.text = self.provienceList[row][@"name"];
        return label;
    } else if (component == 1){
        if ([self.provienceList[self.selectOneRow][@"type"] intValue] == 0) {
            label.text = [NSString stringWithFormat:@"%@市",self.cityList[0][@"name"]];
            return label;
        }else {
            
            label.text = [NSString stringWithFormat:@"%@", self.cityList[row][@"name"]];
//            label.text = self.cityList[row][@"name"];
            return label;
        }
        
    } else {
        label.text = self.areaList[row][@"name"];
        return label;
    }
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 100;
}


/**
 *  保存收货地址按钮
 *
 *  @param sender
 */
- (IBAction)saveButton:(UIButton *)sender {
    
    
    NSMutableString *addressString = [[NSMutableString alloc] initWithString:self.choseLocationLabel.text];
    debugLog(@"self.choseLocationLabel.text = %@", addressString);
    
     // 说明是从新建地址push来的
    if (self.receiveAddNewButtonTag == 10000) {
        if ([self.delegate respondsToSelector:@selector(viewController:model:)]) {
                AddressModel *model = [[AddressModel alloc] init];
                model.name = self.nameTF.text;
                model.phone = self.phoneTF.text;
                model.selectLocation = self.choseLocationLabel.text;
                model.address = self.addressTF.text;
                model.postcode = self.postcodeTF.text;
                model.currentAddress = @"no";
                [self.delegate viewController:self model:model];
                [AddressDBTool ss_insertAddress:model];
        }
    } else {  //  说明是点击修改按钮push来的
        if ([self.delegate respondsToSelector:@selector(modifyViewController:model:index:)]) {
            //你要判断要修改的的数据在在数据库中表中的行号
            AddressModel *model = [AddressDBTool ss_selectAllAddress][self.receiveModifyButtonTag];
             model.name = self.nameTF.text;
            model.phone = self.phoneTF.text;
            model.selectLocation = self.choseLocationLabel.text;
            model.address = self.addressTF.text;;
             model.postcode = self.postcodeTF.text;
            debugLog(@"修改过后的数据在数据库表中的行号：%@", model.recordIDNumber);
            [self.delegate modifyViewController:self model:model index:self.receiveModifyButtonTag];
            [AddressDBTool ss_updateAddress:model index:[model.recordIDNumber integerValue]];
          }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    //self.saveButton.enabled = YES;
    if ((self.nameTF.text.length!=0) && (self.phoneTF.text.length!=0) && (self.addressTF.text.length!=0)) {
        self.saveButton.enabled = YES;
        self.saveButton.backgroundColor = [UIColor colorWithRed:0/255.0 green:164/255.0 blue:82/255.0 alpha:1];
        debugLog(@"输出了");
    } else {
        self.saveButton.enabled = NO;
        self.saveButton.backgroundColor = [UIColor lightGrayColor];
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
