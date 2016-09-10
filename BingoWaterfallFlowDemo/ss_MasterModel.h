//
//  ss_MasterModel.h
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/6/21.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ss_MasterModel : NSObject
//@property (nonatomic, assign) int pageNumber;
//@property (nonatomic, assign) long idNumber;

@property (nonatomic, copy) NSString *masterID;//大师头像ID
@property (nonatomic, copy) NSString *name;    //大师名字
@property (nonatomic, copy) NSString *url;     //大师头像URL
@property (nonatomic, copy) NSString *width;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, assign) int likes;       //大师点赞人数

+ (instancetype)masterDictionary:(NSDictionary *)dictionary;

- (instancetype)initWithMasterDictionary:(NSDictionary *)dictionary;



@end
