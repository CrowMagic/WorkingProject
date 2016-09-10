//
//  SouthJadeModel.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/9/5.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "SouthJadeModel.h"

@implementation SouthJadeModel
+ (instancetype)southJadeDetailDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithSouthJadeDetailDictionary:dictionary];
}
- (instancetype)initWithSouthJadeDetailDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
            self.jadeID = dictionary[@"id"];
        self.createDate = dictionary[@"createDate"];
        self.modifyDate = dictionary[@"modifyDate"];
              self.name = dictionary[@"name"];
             self.price = [dictionary[@"price"] floatValue];
             self.image = dictionary[@"image"];
             self.width = [dictionary[@"width"] intValue];
            self.height = [dictionary[@"height"] intValue];
            self.signet = dictionary[@"signet"];
    }
    return self;
}
@end
