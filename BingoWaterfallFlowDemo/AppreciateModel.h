//
//  AppreciateModel.h
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/9/9.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppreciateModel : NSObject
@property (nonatomic, copy) NSString *appreciateID;  //商品ID
@property (nonatomic, copy) NSString *logoUrl;       //图标URL
@property (nonatomic, assign) int logoWidth;         //图标宽度
@property (nonatomic, assign) int logoHeight;        //图标高度
@property (nonatomic, copy) NSString *imageUrl;      //图片URL
@property (nonatomic, assign) int imageWidth;        //图片宽度
@property (nonatomic, assign) int imageHeight;       //图片高度
@property (nonatomic, copy) NSString *title;         //商品标题
@property (nonatomic, copy) NSString *propaganda;    //商品宣传语

+ (instancetype)appreciateDictionary:(NSDictionary *)dictionary;

- (instancetype)initWithAppreciateDictionary:(NSDictionary *)dictionary;

@end
