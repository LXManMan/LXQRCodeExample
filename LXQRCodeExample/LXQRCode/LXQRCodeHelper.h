//
//  LXQRCodeHelper.h
//  LXQRCodeExample
//
//  Created by 漫漫 on 2018/4/8.
//  Copyright © 2018年 漫漫. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LXQRCodeHelper : NSObject
//判断授权状态
+(void)judgeAuthiorizationStatusWithCurrentVc:(UIViewController *)currentVc resultBlock:(void (^)(BOOL goOn))resultBlock;


@end
