//
//  AppreciateRequest.h
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/9/9.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppreciateRequest : NSObject

+ (void)ss_appreciateHTTPRequest:(NSString *)choseType page:(NSString *)chosePage request:(void(^)(NSMutableArray *object))complete;
@end
