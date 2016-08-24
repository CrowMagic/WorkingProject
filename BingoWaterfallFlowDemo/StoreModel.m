//
//  StoreModel.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/31.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "StoreModel.h"

@implementation StoreModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        self.pictureID = value;
    }
}
@end
