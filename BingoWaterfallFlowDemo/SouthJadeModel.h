//
//  SouthJadeModel.h
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/9/5.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SouthJadeModel : NSObject

@property (nonatomic, copy) NSString *code;//返回码，0成功，其他值失败
@property (nonatomic, copy) NSString *msg;//返回码提示信息

@property (nonatomic, copy) NSString *jadeID;//商品id
@property (nonatomic, copy) NSString *createDate;//发布时间
@property (nonatomic, copy) NSString *modifyDate;//修改时间
@property (nonatomic, copy) NSString *name;//商品名称
@property (nonatomic, assign) float price;//商品价格
@property (nonatomic, copy) NSString *image;//商品图片
@property (nonatomic, assign) int width;//图片宽度
@property (nonatomic, assign) int height;//图片高度
@property (nonatomic, copy) NSString *signet;//商品印章

@property (nonatomic, assign) int start;//开始页码
@property (nonatomic, assign) int count;//每页大小
+ (instancetype)southJadeDetailDictionary:(NSDictionary *)dictionary;
- (instancetype)initWithSouthJadeDetailDictionary:(NSDictionary *)dictionary;
@end
