//
//  ss_settingViewController.m
//  NSURLSession
//
//  Created by 李 宇亮 on 5/26/16.
//  Copyright © 2016 李 宇亮. All rights reserved.
//

#import "ss_settingViewController.h"
#import "HeadProtraitCell.h"
#import "OtherDetailsCell.h"


#import "ss_selectDateView.h"


#import "ModifyPasswordViewController.h"
@interface ss_settingViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) ss_selectDateView *datePickerView;
@property (nonatomic, strong) UIDatePicker *datePicker;
@end

@implementation ss_settingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.title = @"设置";
    // Do any additional setup after loading the view.
    [self.view addSubview:self.myTableView];
    NSArray *array = @[@"",@"用户名",@"昵称",@"性别",@"出生日期",@"个性签名",@"修改密码"];
    self.dataSource = [[NSMutableArray alloc] init];
    for (NSString *str in array) {
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:NSMakeRange(0, str.length)];

        [self.dataSource addObject:string];
    }
    
    
    //添加选择日期视图
    self.datePickerView = [ss_selectDateView initWithView];
    self.datePickerView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 260);
    [self.view addSubview:self.datePickerView];
    [self.datePickerView.cancleButton addTarget:self action:@selector(cancleAndDoNothing) forControlEvents:UIControlEventTouchUpInside];
    [self.datePickerView.ensureButton addTarget:self action:@selector(selectTheDate) forControlEvents:UIControlEventTouchUpInside];
    self.datePicker = [[UIDatePicker alloc] init];
//    self.datePicker.center = self.datePickerView.center;
    self.datePicker.frame = CGRectMake(50, 0, [UIScreen mainScreen].bounds.size.width-100, 200);
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    [self.datePickerView addSubview:self.datePicker];
    
}

- (void)cancleAndDoNothing {
 
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.datePickerView.frame;
        frame.origin.y += 300;
        self.datePickerView.frame = frame;
        self.view.backgroundColor = [UIColor whiteColor];
    }];
    
}

- (void)selectTheDate {
    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年-MM月-dd日";
    NSString *timestamp = [formatter stringFromDate:self.datePicker.date];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:4 inSection:0];
    OtherDetailsCell *cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    cell.detailLabel.text = timestamp;
    [self.myTableView reloadData];
    
    
    /*单行刷新有问题，暂时未解决
    NSArray *arr = [NSArray arrayWithObject:indexPath];
    [self.myTableView reloadRowsAtIndexPaths:arr withRowAnimation:UITableViewRowAnimationAutomatic];
    debugLog(@"刷新了");
     */
    [self cancleAndDoNothing];
    
}


#pragma mark - UITableViewDelegateAndDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        HeadProtraitCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeadProtraitCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        OtherDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OtherDetailsCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.nameLabel.attributedText = self.dataSource[indexPath.row];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 80;
    } else {
        return 44;
    }
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OtherDetailsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //修改头像
    if (indexPath.row == 0) {
//        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"选择头像" message:nil  preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                imagePickerController.delegate = self;
                imagePickerController.allowsEditing = YES;
                imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                [self presentViewController:imagePickerController animated:YES completion:nil];
            }];
        
        
            [vc addAction:action1];
            [vc addAction:action2];
            [self presentViewController:vc animated:YES completion:^{
                
            }];
//        }
    }
    
    
    //修改用户名
    if (indexPath.row == 1) {
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"请输入用户名" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [vc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入用户名";
            [textField addTarget:self action:@selector(accountTextFieldChange:) forControlEvents:UIControlEventEditingChanged];
        }];
        
         UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        __weak typeof(vc) weakVC = vc;
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            cell.detailLabel.text = weakVC.textFields.firstObject.text;
            [self.myTableView reloadData];
        }];
        action2.enabled = NO;
        [vc addAction:action1];
        [vc addAction:action2];
        [self presentViewController:vc animated:YES completion:nil];
    }
    //修改昵称
    if (indexPath.row == 2) {
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"请输入昵称" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [vc addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入昵称";
            [textField addTarget:self action:@selector(accountTextFieldChange:) forControlEvents:UIControlEventEditingChanged];
        }];
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
       
        __weak typeof(vc) weakVC = vc;
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (weakVC.textFields.firstObject.text.length != 0) {
                cell.detailLabel.text = weakVC.textFields.firstObject.text;
                [self.myTableView reloadData];
            }
        }];
        action2.enabled = NO;
        [vc addAction:action1];
        [vc addAction:action2];
        [self presentViewController:vc animated:YES completion:nil];
    }
    //选择性别
    if (indexPath.row == 3) {
        UIAlertController *vc = [UIAlertController alertControllerWithTitle:@"请选择性别" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"男" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            cell.detailLabel.text = @"男";
            [self.myTableView reloadData];
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"女" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            cell.detailLabel.text = @"女";
            [self.myTableView reloadData];
        }];
        [vc addAction:action1];
        [vc addAction:action2];
        [self presentViewController:vc animated:YES completion:nil];
    }
    //选择出生日期
    if (indexPath.row == 4) {
        
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = self.datePickerView.frame;
            frame.origin.y -= 300;
            self.datePickerView.frame = frame;
            self.view.backgroundColor = [UIColor lightGrayColor];
            
        }];

        
    }
    
    //修改密码
    if (indexPath.row == 6) {
        ModifyPasswordViewController *vc = [[ModifyPasswordViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    HeadProtraitCell *cell = [self.myTableView cellForRowAtIndexPath:indexPath];
    cell.myHeadImage.layer.cornerRadius = 30;
    cell.myHeadImage.layer.masksToBounds = YES;
    cell.myHeadImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSLog(@" ==== %@",info);
}


#pragma mark - lazyLoad
- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
     
        [_myTableView registerNib:[UINib nibWithNibName:@"HeadProtraitCell" bundle:nil] forCellReuseIdentifier:@"HeadProtraitCell"];
        [_myTableView registerNib:[UINib nibWithNibName:@"OtherDetailsCell" bundle:nil] forCellReuseIdentifier:@"OtherDetailsCell"];
        _myTableView.delegate = self;
        _myTableView.dataSource = self;
        
        self.myTableView.tableFooterView = [UIView new];
    }
    return _myTableView;
}

#pragma mark - actionEvents

- (void)accountTextFieldChange:(UITextField *)textField {
    
    //获取alertController
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    //拿到doneAction按钮
    UIAlertAction * doneAction = alertController.actions[1];
    //判断语句
    if (textField.text.length != 0) {
        doneAction.enabled = YES;
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
