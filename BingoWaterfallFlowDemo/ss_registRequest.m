//
//  ss_registRequest.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 5/30/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import "ss_registRequest.h"
//#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
#import "ss_registModel.h"
@implementation ss_registRequest

+ (void)ss_registHTTPRequestModel:(ss_registModel *)model request:(void(^)())complete {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];

    NSString *urlString = @"http://192.168.2.13:8080//shop/register/register";
    
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 30.f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//    NSNumber *phone = [NSNumber numberWithLong:model.phone];
    
    NSDictionary *dic = @{@"username":model.username,
                          @"password":model.password,
                          @"phone":model.phone,
                          @"email":model.email,
                          @"valicationCode":model.valicationCode};

    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
         debugLog(@"response == %@",[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        debugLog(@"error == %@",error);

    }];
}


+ (void)ss_registVerifyPhoneHTTPRequestModel:(ss_registModel *)model request:(void(^)(NSDictionary *dictionary))complete {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
    
    NSString *urlString = @"http://192.168.2.13:8080//shop/register/validatePhone";
    
//    NSNumber *phone = [NSNumber numberWithLong:model.phone];
    NSDictionary *dic = @{@"phone":model.phone};
    
    debugLog(@"dic ===== %@",dic);
    
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        debugLog(@"response == %@",[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
         NSDictionary *dicss = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
        if (complete) {
            complete(dicss);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        debugLog(@"error == %@",error);

    }];
    
    
}


+ (void)ss_registVerifyUsernameHTTPRequestModel:(ss_registModel *)model request:(void(^)(NSDictionary *dictionary))complete {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
    NSString *urlString = @"http://192.168.2.13:8080/shop/register/validateUsername";
    NSDictionary *dic = @{@"username":model.username};
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        debugLog(@"response == %@",[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
        NSDictionary *dicss = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
        if (complete) {
            complete(dicss);
        }


    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        debugLog(@"error == %@",error);

    }];

}

+ (void)ss_registVerifyEmailHTTPRequestModel:(ss_registModel *)model request:(void(^)())complete {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
    NSString *urlString = @"http://192.168.2.13:8080/shop/register/validateEmail";
    NSDictionary *dic = @{@"email":model.email};
    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        debugLog(@"response == %@",[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        debugLog(@"error == %@",error);

    }];
}


@end
