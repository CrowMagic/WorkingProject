//
//  ss_modifyPasswordRequest.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 6/1/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import "ss_modifyPasswordRequest.h"
#import "ss_modifyPasswordModel.h"
#import "AFHTTPRequestOperationManager.h"

@implementation ss_modifyPasswordRequest


+ (void)ss_modifyPasswordByEmailHTTPRequestModel:(ss_modifyPasswordModel *)model request:(void(^)())complete {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
    
    NSString *urlString = @"http://192.168.2.13:8080/shop/password/changePassword";
    NSDictionary *dic = @{@"password":model.password,@"newPassword":model.aNewPassword};
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        debugLog(@"response == %@",[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
        NSDictionary *dicss = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        debugLog(@"error == %@",error);

    }];
}

@end
