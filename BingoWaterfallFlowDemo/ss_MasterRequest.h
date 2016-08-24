//
//  ss_MasterRequest.h
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/6/21.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ss_MasterModel;
@interface ss_MasterRequest : NSObject

/**
 *  大师首页网络请求
 *
 *  @param model    <#model description#>
 *  @param complete <#complete description#>
 */
+ (void)ss_MasterHTTPRequestModel:(ss_MasterModel *)model request:(void(^)(NSDictionary *dic))complete;



@end
