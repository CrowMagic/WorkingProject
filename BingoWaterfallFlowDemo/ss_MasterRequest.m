//
//  ss_MasterRequest.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/6/21.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "ss_MasterRequest.h"
#import "AFHTTPRequestOperationManager.h"
#import "ss_MasterModel.h"
@implementation ss_MasterRequest

+ (void)ss_MasterHTTPRequestModel:(ss_MasterModel *)model request:(void(^)(NSDictionary *dic))complete {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
    NSString *urlString = @"http://192.168.2.100:8080/wap/master/view";
    NSDictionary *dic = @{@"pageNumber":@(model.pageNumber)};
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
           debugLog(@"success == %@",[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        debugLog(@"error == %@",error);
    }];
}
@end
