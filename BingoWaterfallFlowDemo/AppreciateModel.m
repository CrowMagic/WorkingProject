//
//  AppreciateModel.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 16/9/9.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "AppreciateModel.h"

@implementation AppreciateModel
+ (instancetype)appreciateDictionary:(NSDictionary *)dictionary {
    return [[self alloc] initWithAppreciateDictionary:dictionary];
}



- (instancetype)initWithAppreciateDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.appreciateID = dictionary[@"id"];
             self.logoUrl = dictionary[@"logo"][@"url"];
           self.logoWidth = [dictionary[@"logo"][@"width"] intValue];
          self.logoHeight = [dictionary[@"logo"][@"height"] intValue];
            self.imageUrl = dictionary[@"image"][@"url"];
          self.imageWidth = [dictionary[@"image"][@"width"] intValue];
         self.imageHeight = [dictionary[@"image"][@"height"] intValue];
               self.title = dictionary[@"title"];
          self.propaganda = dictionary[@"propaganda"];
    }
    return self;
}

@end
