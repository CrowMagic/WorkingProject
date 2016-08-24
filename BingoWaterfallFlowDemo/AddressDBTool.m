//
//  AddressDBTool.m
//  BingoWaterfallFlowDemo
//
//  Created by 李 宇亮 on 5/23/16.
//  Copyright © 2016 Bing. All rights reserved.
//

#import "AddressDBTool.h"
#import "AddressModel.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
@implementation AddressDBTool

static FMDatabase *_db = nil;

+ (NSString *)pathString {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *addressPath = [path stringByAppendingPathComponent:@"address.sqlite"];
    debugLog(@"%@",addressPath);
    return addressPath;
}


+ (void)ss_initDB {
    _db = [FMDatabase databaseWithPath:[self pathString]];
    if (![_db open]) {
        debugLog(@"open address database error");
    } else {
        debugLog(@"open address database success");
        if (![_db tableExists:@"addressTable"]) {
            BOOL isOK = [_db executeUpdate:@"create table addressTable (addressID integer primary key autoincrement,name text,phone text,address text)"];
            debugLog(@"create addressTable:%@",isOK?@"success":@"fail");
        }
    }
    [_db close];
}

+ (void)ss_insertAddress:(AddressModel *)address {
    if ([_db open]) {
        BOOL isOK = [_db executeUpdate:@"insert into addressTable (name,phone,address) values (?,?,?)",address.name,address.phone,address.address];
        debugLog(@"insert addressTable:%@",isOK?@"success":@"fail");
    }
    [_db close];
}

+ (NSArray *)ss_selectAllAddress {
    NSMutableArray *addressArray = [NSMutableArray array];
    if ([_db open]) {
        FMResultSet *set = [_db executeQuery:@"select * from addressTable"];
        while ([set next]) {
            AddressModel *model = [[AddressModel alloc] init];
            model.name = [set stringForColumnIndex:1];
            model.phone = [set stringForColumnIndex:2];
            model.address = [set stringForColumnIndex:3];
            [addressArray addObject:model];
        }
        [set close];
    }
    [_db close];
    return addressArray;
}

+ (void)ss_deleteAllAddress:(AddressModel *)address  {
    if ([_db open]) {
    
       
//        BOOL isOK = [_db executeUpdate:@"delete from addressTable where name = 12"];
        
     BOOL isOK = [_db executeUpdateWithFormat:@"delete from addressTable where name = %@;",address.name];
        
    debugLog(@"delete addressTable:%@",isOK?@"success":@"error");
    }
    [_db close];
}

+ (void)ss_updateAddress:(AddressModel *)model index:(NSInteger)index {
    if ([_db open]) {
//
//        FMResultSet *set = [_db executeQuery:@"select * from addressTable"];
//        while ([set next]) {
//            AddressModel *modelOld = [[AddressModel alloc] init];
//            NSMutableArray *array = [NSMutableArray array];
//            modelOld.name = [set stringForColumnIndex:1];
//        
//            [array addObject:modelOld.name];
//            
//            debugLog(@"数组中的个数==%lu",(unsigned long)array.count);
    
    NSNumber *ID = [NSNumber numberWithInteger:index];
    
            BOOL isOK = [_db executeUpdateWithFormat:@"update addressTable set name = %@,phone = %@,address = %@ where addressID = %@",model.name,model.phone,model.address,ID];
            debugLog(@"update addressTable:%@",isOK?@"success":@"error");
//        }
//        [set close];
    
      
    }
    [_db close];
}

+ (void)ss_dropAddress {
    
    if ([_db open]) {
        if ([_db tableExists:@"addressTable"]) {
            BOOL isOK = [_db executeUpdate:@"drop table if exists addressTable;"];
            debugLog(@"drop %@",isOK?@"success":@"error");
        }
    }
    [_db close];
    
  
}


@end
