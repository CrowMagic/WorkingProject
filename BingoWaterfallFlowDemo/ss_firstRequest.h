//
//  ss_firstRequest.h
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/9/5.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ss_firstRequest : NSObject
+ (void)ss_firstRequestModel:(NSString *)str request:(void(^)(NSDictionary *dic))complete;

@end
