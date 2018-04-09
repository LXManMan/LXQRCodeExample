//
//  LXQRCodeScanManager.h
//  LXQRCodeExample
//
//  Created by 漫漫 on 2018/4/8.
//  Copyright © 2018年 漫漫. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^GetBrightnessBlock)(CGFloat brightness);

typedef void(^ScanBlock)(NSArray *metadataObjects);

@interface LXQRCodeScanManager : NSObject
/** 单例 */
+ (instancetype)sharedManager;

//设置二维码读取率 数据类型 当前控制器
- (void)setupSessionPreset:(NSString *)sessionPreset metadataObjectTypes:(NSArray *)metadataObjectTypes currentController:(UIViewController *)currentController;


//亮度回调
-(void)brightnessChange:(GetBrightnessBlock)getBrightnessBlock;

//扫描结果
-(void)scanResult:(ScanBlock)scanBlock;

/** 开启会话对象扫描 */
- (void)startRunning;
/** 停止会话对象扫描 */
- (void)stopRunning;
/** 移除 videoPreviewLayer 对象 */
- (void)videoPreviewLayerRemoveFromSuperlayer;
/** 播放音效文件 */
- (void)palySoundName:(NSString *)name;
/** 重置根据光线强弱值打开手电筒的 delegate 方法 */
- (void)resetSampleBufferDelegate;
/** 取消根据光线强弱值打开手电筒的 delegate 方法 */
- (void)cancelSampleBufferDelegate;
@end
