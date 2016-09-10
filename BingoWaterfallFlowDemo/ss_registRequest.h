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




/**
 *  注册时获取图形验证码
 *
 *  @param complete 返回图片的Data数据
 */
+ (void)ss_registGetImageHTTPRequest:(void(^)(NSData *data))complete;


/**
 *  注册时获取手机验证码
 *
 *  @param phoneNUmber 输入的手机号，用于接受验证码信息
 *  @param complete
 */
+ (void)ss_registGetPhoneVerifyNumberHTTPRequest:(NSString *)phoneNUmber request:(void(^)())complete;



/**
 *  注册时校验图形验证码
 *
 *  @param verifyCode 输入要验证的图片中的字符
 *  @param complete
 */
+ (void)ss_registVerifyImageHTTPRequest:(NSString *)verifyCode request:(void(^)())complete;



//注册时校验手机号是否存在
+ (void)ss_registVerifyPhoneHTTPRequestModel:(ss_registModel *)model request:(void(^)(NSDictionary *dictionary))complete;

//注册时校验用户名是否存在
+ (void)ss_registVerifyUsernameHTTPRequestModel:(ss_registModel *)model request:(void(^)(NSDictionary *dictionary))complete;

//注册时校验邮箱是否存在
+ (void)ss_registVerifyEmailHTTPRequestModel:(ss_registModel *)model request:(void(^)())complete;



//注册请求
+ (void)ss_registHTTPRequestModel:(ss_registModel *)model request:(void(^)())complete;


@end
