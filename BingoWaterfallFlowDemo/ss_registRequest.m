//
//  ss_registRequest.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 5/30/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import "ss_registRequest.h"
//#import "AFNetworking.h"
//#import "AFHTTPRequestOperationManager.h"
#import "AFHTTPSessionManager.h"
#import "ss_registModel.h"
@implementation ss_registRequest

//+ (void)ss_registHTTPRequestModel:(ss_registModel *)model request:(void(^)())complete {
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
//
//    NSString *urlString = @"http://192.168.2.13:8080//shop/register/register";
//    
//    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    manager.requestSerializer.timeoutInterval = 30.f;
//    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
////    NSNumber *phone = [NSNumber numberWithLong:model.phone];
//    
//    NSDictionary *dic = @{@"username":model.username,
//                          @"password":model.password,
//                          @"phone":model.phone,
//                          @"email":model.email,
//                          @"valicationCode":model.valicationCode};
//
////    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
////         debugLog(@"response == %@",[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
////    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
////        debugLog(@"error == %@",error);
////
////    }];
//}


+ (void)ss_registGetImageHTTPRequest:(void(^)(NSData *data))complete {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",@"image/jpeg",nil];
    NSString *urlString = @"http://192.168.2.22:8090/wap/common/captcha?captchaID=uuid";

    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        debugLog(@"success == %@",responseObject);
        NSData *data = [[NSData alloc] initWithData:responseObject];
        if (complete) {
            complete(data);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        debugLog(@"error == %@", error);
    }];
}

/**
 *  注册时获取手机验证码
 *
 *  @param complete
 */
+ (void)ss_registGetPhoneVerifyNumberHTTPRequest:(NSString *)phoneNUmber request:(void(^)())complete {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",@"image/jpeg",nil];
    NSString *urlString = @"http://192.168.2.22:8090/wap/register/verifyCode";
    [manager.requestSerializer setValue:@"RbpQ8flsM61Wh6QDB1HCIy2rYMfba626" forHTTPHeaderField:@"appid"];
    [manager.requestSerializer setValue:@"capitalofsouthjadeinchina" forHTTPHeaderField:@"appsecret"];
    [manager.requestSerializer setValue:@"xxxxxxxxxxx" forHTTPHeaderField:@"sessionid"];
    
    [manager POST:urlString parameters:@{@"phone":phoneNUmber} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        debugLog(@"获取手机验证码success == %@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        debugLog(@"error == %@", error);

    }];

    
}



+ (void)ss_registVerifyImageHTTPRequest:(NSString *)verifyCode request:(void(^)())complete {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
    NSString *urlString = @"http://192.168.2.22:8090/wap/register/validCaptcha";
    NSDictionary *dic = @{@"captcha":verifyCode, @"captchaId":@"test@163.com"};
    [manager.requestSerializer setValue:@"RbpQ8flsM61Wh6QDB1HCIy2rYMfba626" forHTTPHeaderField:@"appid"];
    [manager.requestSerializer setValue:@"capitalofsouthjadeinchina" forHTTPHeaderField:@"appsecret"];
    [manager.requestSerializer setValue:@"xxxxxxxxxxx" forHTTPHeaderField:@"sessionid"];
    [manager POST:urlString parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           debugLog(@"success == %@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        debugLog(@"error == %@", error);
    }];

}









+ (void)ss_registVerifyPhoneHTTPRequestModel:(ss_registModel *)model request:(void(^)(NSDictionary *dictionary))complete {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
    
    NSString *urlString = @"http://192.168.2.13:8080//shop/register/validatePhone";
    
//    NSNumber *phone = [NSNumber numberWithLong:model.phone];
    NSDictionary *dic = @{@"phone":model.phone};
    
    debugLog(@"dic ===== %@",dic);
    
//    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        debugLog(@"response == %@",[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
//         NSDictionary *dicss = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
//        if (complete) {
//            complete(dicss);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        debugLog(@"error == %@",error);
//
//    }];
    
    
}

+ (void)ss_registVerifyUsernameHTTPRequestModel:(ss_registModel *)model request:(void(^)(NSDictionary *dictionary))complete {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
    NSString *urlString = @"http://192.168.2.13:8080/shop/register/validateUsername";
    NSDictionary *dic = @{@"username":model.username};
//    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        debugLog(@"response == %@",[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
//        NSDictionary *dicss = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingMutableContainers error:nil];
//        if (complete) {
//            complete(dicss);
//        }
//
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        debugLog(@"error == %@",error);
//
//    }];

}

+ (void)ss_registVerifyEmailHTTPRequestModel:(ss_registModel *)model request:(void(^)())complete {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",nil];
    NSString *urlString = @"http://192.168.2.13:8080/shop/register/validateEmail";
    NSDictionary *dic = @{@"email":model.email};
//    [manager POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        debugLog(@"response == %@",[[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        debugLog(@"error == %@",error);
//
//    }];
}


+ (void)ss_registHTTPRequestModel:(ss_registModel *)model request:(void (^)())complete {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",@"image/jpeg",nil];
    [manager.requestSerializer setValue:@"RbpQ8flsM61Wh6QDB1HCIy2rYMfba626" forHTTPHeaderField:@"appid"];
    [manager.requestSerializer setValue:@"capitalofsouthjadeinchina" forHTTPHeaderField:@"appsecret"];
    [manager.requestSerializer setValue:@"xxxxxxxxxxx" forHTTPHeaderField:@"sessionid"];
    
    NSString *urlString = @"http://192.168.2.22:8090/wap/register/register";
    NSDictionary *paraDic = @{@"phone":model.phone, @"username":model.username, @"password":model.password, @"captcha":model.valicationCode};
    [manager POST:urlString parameters:paraDic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         debugLog(@"注册success == %@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        debugLog(@"注册error == %@", error);
    }];
   

}


@end
