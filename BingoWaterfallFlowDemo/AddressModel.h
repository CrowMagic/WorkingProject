//
//  AddressModel.h
//  MyAddress
//
//  Created by 李 宇亮 on 5/21/16.
//  Copyright © 2016 李 宇亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject
@property (nonatomic, copy) NSString *name;//姓名
@property (nonatomic, copy) NSString *phone;//电话
@property (nonatomic, copy) NSString *selectLocation;//从地区选择器中选择的地址
@property (nonatomic, copy) NSString *address;//手动输入的地址
@property (nonatomic, copy) NSString *postcode;//邮编
@property (nonatomic, copy) NSString *currentAddress;//是否默认地址(根据字符串yes或mo来判断)
@property (nonatomic, assign) int recordIDNumber;//记录当前表的行号(并不在表中创建字段)
@end
