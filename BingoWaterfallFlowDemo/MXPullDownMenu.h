//
//  MXPullDownMenu000.h
//  MXPullDownMenu
//
//  Created by on 14-8-21.
//  Copyright (c) 2016年 Mx. All rights reserved.
//



#import <UIKit/UIKit.h>

@class MXPullDownMenu;

typedef enum
{
    IndicatorStateShow = 0,
    IndicatorStateHide
}
IndicatorStatus;

typedef enum
{
    BackGroundViewStatusShow = 0,
    BackGroundViewStatusHide
}
BackGroundViewStatus;

@protocol MXPullDownMenuDelegate <NSObject>

- (void)PullDownMenu:(MXPullDownMenu *)pullDownMenu didSelectRowAtColumn:(NSInteger)column row:(NSInteger)row;

@end

@interface MXPullDownMenu : UIView<UITableViewDelegate, UITableViewDataSource>

- (MXPullDownMenu *)initWithArray:(NSArray *)array selectedColor:(UIColor *)color;

@property (nonatomic, weak) id<MXPullDownMenuDelegate> delegate;

@end


// CALayerCategory
@interface CALayer (MXAddAnimationAndValue)

- (void)addAnimation:(CAAnimation *)anim andValue:(NSValue *)value forKeyPath:(NSString *)keyPath;

@end
