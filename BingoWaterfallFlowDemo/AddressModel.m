//
//  AddressModel.m
//  MyAddress
//
//  Created by 李 宇亮 on 5/21/16.
//  Copyright © 2016 李 宇亮. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"姓名：%@ == 电话：%@ == 地址：%@",_name,_phone, _address];
}


@end
