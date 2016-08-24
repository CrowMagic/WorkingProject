//
//  ss_loginRequest.h
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 5/31/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ss_loginModel;
@interface ss_loginRequest : NSObject
/**
 *  登录请求
 *
 *  @param model    <#model description#>
 *  @param complete <#complete description#>
 */
+ (void)ss_loginHTTPRequestModel:(ss_loginModel *)model request:(void(^)(NSDictionary *dic))complete;

/**
 *  登出请求
 *
 *  @param complete <#complete description#>
 */
+ (void)ss_logoutHTTPRequest:(void(^)(NSDictionary *dic))complete;


@end
