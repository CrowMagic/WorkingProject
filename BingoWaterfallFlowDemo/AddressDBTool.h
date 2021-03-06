//
//  AddressDBTool.h
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 5/23/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressModel;
@interface AddressDBTool : NSObject
/**
 *  创建收货地址数据库
 */
+ (void)ss_initDB;
/**
 *  插入收货地址
 *
 *  @param address
 */
+ (void)ss_insertAddress:(AddressModel *)address;
/**
 *  查询收货地址
 *
 *  @return
 */
+ (NSArray *)ss_selectAllAddress;
/**
 *  删除收货地址
 *
 *  @param addressName
 */
+ (void)ss_deleteAllAddress:(AddressModel *)address;

/**
 *  修改收货地址
 *
 *  @param model
 *  @param index    
 */
+ (void)ss_updateAddress:(AddressModel *)model
                   index:(NSInteger)index;

/**
 *  销毁数据库
 */
+ (void)ss_dropAddress;

@end
