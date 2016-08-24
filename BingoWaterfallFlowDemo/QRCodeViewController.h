//
//  QRCodeViewController.h
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/5/10.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IS_VAILABLE_IOS8  ([[[UIDevice currentDevice] systemVersion] intValue] >= 8)
@interface QRCodeViewController : UIViewController

typedef void (^QRCodeDidReceiveBlock)(NSString *result);
@property(nonatomic,copy,readonly) QRCodeDidReceiveBlock didReceiveBlock;
-(void)setDidReceiveBlock:(QRCodeDidReceiveBlock)didReceiveBlock;
@end
