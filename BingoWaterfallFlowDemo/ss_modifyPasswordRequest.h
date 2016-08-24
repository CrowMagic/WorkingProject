//
//  ss_modifyPasswordRequest.h
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 6/1/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ss_modifyPasswordModel;
@interface ss_modifyPasswordRequest : NSObject

+ (void)ss_modifyPasswordByEmailHTTPRequestModel:(ss_modifyPasswordModel *)model request:(void(^)())complete;


@end
