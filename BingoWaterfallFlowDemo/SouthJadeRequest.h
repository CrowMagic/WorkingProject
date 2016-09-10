//
//  SouthJadeRequest.h
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/9/5.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SouthJadeModel;
@interface SouthJadeRequest : NSObject
//+ (void)ss_firstRequestModel:(NSString *)str request:(void(^)(NSDictionary *dic))complete;
+ (void)ss_southJadeHTTPRequest:(SouthJadeModel *)model request:(void(^)(NSMutableArray *object))complete;

@end
