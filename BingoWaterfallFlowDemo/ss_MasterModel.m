//
//  ss_MasterModel.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/6/21.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "ss_MasterModel.h"

@implementation ss_MasterModel


+ (instancetype)masterDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithMasterDictionary:dictionary];
}

- (instancetype)initWithMasterDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.masterID = dictionary[@"id"];
        self.name = dictionary[@"name"];
        self.url = dictionary[@"avatar"][@"url"];
        self.likes = [dictionary[@"likes"] intValue];
    }
    return self;
}

@end
