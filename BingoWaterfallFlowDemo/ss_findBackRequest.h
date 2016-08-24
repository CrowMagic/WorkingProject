//
//  ss_findBackRequest.h
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 6/1/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ss_findBackModel;
@interface ss_findBackRequest : NSObject

//发送邮箱验证码
+ (void)ss_sendEmailVerifyCodeHTTPRequestModel:(ss_findBackModel *)model request:(void(^)(NSMutableArray *object))complete;

//验证邮箱验证码是否正确
+ (void)ss_checkTheEmailVerifyCodeHTTPRequest:(ss_findBackModel *)model request:(void(^)(NSDictionary *dictionary))complete;

//通过邮箱验证修改密码
+ (void)ss_modifyPasswordByEmailHTTPRequestModel:(ss_findBackModel *)model request:(void(^)())complete;

@end
