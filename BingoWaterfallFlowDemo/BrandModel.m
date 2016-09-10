//
//  BrandModel.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/9/6.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "BrandModel.h"

@implementation BrandModel

+ (instancetype)brandDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithBrandDictionary:dictionary];
}

- (instancetype)initWithBrandDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.brandID = dictionary[@"id"];
        self.createDate = dictionary[@"createDate"];
        self.modifyDate = dictionary[@"modifyDate"];
        //来自image字典
//        self.imageUrl = dictionary[@"url"];
//        self.imageWidth = dictionary[@"width"];
//        self.imageHeight = dictionary[@"height"];
        //来自logo字典
//        self.logoUrl = dictionary[@"url"];
//        self.logoWidth = dictionary[@"width"];
//        self.logoHeight = dictionary[@"height"];
    }
    return self;
}

@end
