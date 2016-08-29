//
//  BuildNewAddressViewController.h
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 5/23/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressModel;


@protocol BuildNewAddressViewControllerDelegate <NSObject>
/**
 *  新增收货地址
 *
 *  @param viewController <#viewController description#>
 *  @param model          <#model description#>
 */
- (void)viewController:(UIViewController *)viewController
                 model:(AddressModel *)model;
/**
 *  修改收货地址
 *
 *  @param viewController
 *  @param model                
 *  @param index          区别不同的行号
 */
- (void)modifyViewController:(UIViewController *)viewController
                       model:(AddressModel *)model
                       index:(NSInteger)index;


@end



@interface BuildNewAddressViewController : UIViewController

@property (nonatomic, weak) id <BuildNewAddressViewControllerDelegate> delegate;

@property (nonatomic, assign) NSInteger receiveAddNewButtonTag;
@property (nonatomic, assign) NSInteger receiveModifyButtonTag;//记录修改的的某一行
//@property (nonatomic, assign) NSInteger aCount;


@property (weak, nonatomic) IBOutlet UIView *aView;

@end
