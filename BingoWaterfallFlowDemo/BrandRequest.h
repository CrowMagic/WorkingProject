//
//  BrandRequest.h
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/9/6.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BrandModel;
@interface BrandRequest : NSObject
+ (void)ss_brandHTTPRequestPara:(NSString *)modelPara request:(void(^)(NSMutableArray *object))complete;
@end
