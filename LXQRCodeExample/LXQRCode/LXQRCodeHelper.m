//
//  LXQRCodeHelper.m
//  LXQRCodeExample
//
//  Created by 漫漫 on 2018/4/8.
//  Copyright © 2018年 漫漫. All rights reserved.
//

#import "LXQRCodeHelper.h"

@implementation LXQRCodeHelper
//判断授权状态
+(void)judgeAuthiorizationStatusWithCurrentVc:(UIViewController *)currentVc resultBlock:(void (^)(BOOL goOn))resultBlock{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        if (resultBlock) {
                            resultBlock(YES);
                        }
                    });
                  
                    
                } else {
                    // 用户第一次拒绝了访问相机权限
                    [NSObject showMessag:@"用户第一次拒绝了访问相机权限" toView:currentVc.view afterDelay:1.5];
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            if (resultBlock) {
                resultBlock(YES);
            }
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            
            NSString *message =[NSString stringWithFormat:@"请去-> [设置 - 隐私 - 相机 - %@] 打开访问开关",LXDisplayName];
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            [alertC addAction:alertA];
            [currentVc presentViewController:alertC animated:YES completion:nil];
            
        } else if (status == AVAuthorizationStatusRestricted) {
            [NSObject showMessag:@"因为系统原因, 无法访问相册" toView:currentVc.view afterDelay:1.5];

        }
    } else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alertC addAction:alertA];
        [currentVc presentViewController:alertC animated:YES completion:nil];
    }
}


@end
