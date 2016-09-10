//
//  BrandModel.h
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/9/6.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandModel : NSObject
@property (nonatomic, copy) NSString *brandID;     //品牌ID
@property (nonatomic, copy) NSString *createDate;  //创建时间
@property (nonatomic, copy) NSString *modifyDate;  //修改时间
@property (nonatomic, copy) NSString *name;        //品牌名字
@property (nonatomic, copy) NSString *imageUrl;    //品牌图片
@property (nonatomic, assign) int imageWidth;  //品牌图片宽度
@property (nonatomic, assign) int imageHeight; //品牌图片高度
@property (nonatomic, copy) NSString *logoUrl;     //品牌图标
@property (nonatomic, assign) int logoWidth;   //品牌图标宽度
@property (nonatomic, assign) int logoHeight;  //品牌图标高度


+ (instancetype)brandDictionary:(NSDictionary *)dictionary;

- (instancetype)initWithBrandDictionary:(NSDictionary *)dictionary;


@end
