//
//  ss_findBackRequest.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 6/1/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import "ss_findBackRequest.h"
//#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "ss_findBackModel.h"
@implementation ss_findBackRequest

+ (void)ss_sendEmailVerifyCodeHTTPRequestModel:(ss_findBackModel *)model request:(void(^)(NSMutableArray *object))complete {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
    
    NSString *urlString = @"http://192.168.2.13:8080/shop/password/mail";
    NSDictionary *dic = @{@"email":model.email};
//    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        debugLog(@"response == %@",[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        debugLog(@"error == %@",error);
//
//    }];
    
}


+ (void)ss_checkTheEmailVerifyCodeHTTPRequest:(ss_findBackModel *)model request:(void(^)(NSDictionary *dictionary))complete {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
    NSString *urlString = @"http://192.168.2.13:8080/shop/password/validate";
    NSDictionary *dic = @{@"valnum":model.valnum};
//    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        debugLog(@"response == %@",[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
//        NSDictionary *dicss = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
//        
//        if (complete) {
//            complete(dicss);
//        }
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        debugLog(@"error == %@",error);
//        
//    }];
   
}




+ (void)ss_modifyPasswordByEmailHTTPRequestModel:(ss_findBackModel *)model request:(void(^)())complete {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
    
    NSString *urlString = @"http://192.168.2.13:8080/shop/password/updatePassword";
    NSDictionary *dic = @{@"password":model.password};
//    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        debugLog(@"response == %@",[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
//        NSDictionary *dicss = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        debugLog(@"error == %@",error);
//        
//    }];
}



@end
