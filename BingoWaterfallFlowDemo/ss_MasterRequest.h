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
 *  大师网络请求
 *
 *  @param choseType 分为推荐,名气,新进
 *  @param chosePage 选择加载的页数
 *  @param complete  完成返回的数据
 */
+ (void)ss_masterHTTPRequest:(NSString *)choseType page:(NSString *)chosePage request:(void(^)(NSMutableArray *object))complete;

/**
 *  大师点赞网络请求
 *
 *  @param idString 大师id编号
 *  @param complete
 */
+ (void)ss_masterUpHTTPRequest:(NSString *)idString request:(void(^)())complete;

/**
 *  大师取消点赞网络请求
 *
 *  @param idString 大师id编号
 *  @param complete
 */
+ (void)ss_masterDownHTTPRequest:(NSString *)idString request:(void(^)())complete;

@end
