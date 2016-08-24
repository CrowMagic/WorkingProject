//
//  ss_registRequest.h
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 5/30/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ss_registModel;
@interface ss_registRequest : NSObject

//注册请求
+ (void)ss_registHTTPRequestModel:(ss_registModel *)model request:(void(^)())complete;
//注册时校验手机号是否存在
+ (void)ss_registVerifyPhoneHTTPRequestModel:(ss_registModel *)model request:(void(^)(NSDictionary *dictionary))complete;

//注册时校验用户名是否存在
+ (void)ss_registVerifyUsernameHTTPRequestModel:(ss_registModel *)model request:(void(^)(NSDictionary *dictionary))complete;

//注册时校验邮箱是否存在
+ (void)ss_registVerifyEmailHTTPRequestModel:(ss_registModel *)model request:(void(^)())complete;

@end
