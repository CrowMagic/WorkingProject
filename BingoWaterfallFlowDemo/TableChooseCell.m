//
//  TableChooseCell.m
//  BingoWaterfallFlowDemo
//
//  Created by giikylee on 16/7/20.
//  Copyright © 2016年 Bing. All rights reserved.
//

#import "TableChooseCell.h"
#define HorizonGap 15
#define TilteBtnGap 10
#define ColorRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@implementation TableChooseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)drawRect:(CGRect)rect
{
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextSetStrokeColorWithColor(context, ColorRGB(0xf7f7f7).CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - 0.5, rect.size.width, 0.5));
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self MakeView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)MakeView{
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 30)];
    self.titleLabel.textColor = [UIColor darkTextColor];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLabel];
    
    self.SelectIconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.SelectIconBtn.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame), 0, 30, 30);
    [self.SelectIconBtn setImage:[UIImage imageNamed:@"radiobuttons_normal"] forState:UIControlStateNormal];
    [self.SelectIconBtn setImage:[UIImage imageNamed:@"radiobuttons_pressed"] forState:UIControlStateSelected];
    self.SelectIconBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:self.SelectIconBtn];
}
-(void)UpdateCellWithState:(BOOL)select{
    self.SelectIconBtn.selected = select;
    _isSelected = select;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end