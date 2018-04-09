//
//  LXQRCodeScanView.h
//  LXQRCodeExample
//
//  Created by 漫漫 on 2018/4/8.
//  Copyright © 2018年 漫漫. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    /// 默认与边框线同中心点
    CornerLoactionDefault,
    /// 在边框线内部
    CornerLoactionInside,
    /// 在边框线外部
    CornerLoactionOutside,
} CornerLoaction;
@interface LXQRCodeScanView : UIView

@property(nonatomic,strong)UIColor *borderColor;
/** 边角位置，默认 CornerLoactionDefault */
@property (nonatomic, assign) CornerLoaction cornerLocation;
/** 边角颜色，默认微信颜色 */
@property (nonatomic, strong) UIColor *cornerColor;
/** 边角宽度，默认 2.f */
@property (nonatomic, assign) CGFloat cornerWidth;

/** 扫描区周边颜色的 alpha 值，默认 0.5f */
@property (nonatomic, assign) CGFloat backgroundAlpha;

/** 扫描间隔 默认0.02 */
@property (nonatomic, assign) CGFloat timeInterval;

//闪光灯
@property (nonatomic, strong) UIButton *lightBtn;
//添加定时器
-(void)addTimer;
//移除定时器
-(void)removeTimer;

//根据灯光判断
-(void)lightBtnChangeWithBrightnessValue:(CGFloat)brightnessValue;
@end
