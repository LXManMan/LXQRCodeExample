# LXQRCodeExample
![image](https://github.com/liuxinixn/LXQRCodeExample/blob/master/2018-04-09%2015_13_59.gif)

```
 扫一扫：
   self.scanManager = [LXQRCodeScanManager sharedManager];
    
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    // AVCaptureSessionPreset1920x1080 推荐使用，对于小型的二维码读取率较高
    [_scanManager setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr currentController:self];
    
两个回调


 //扫描结果回调
    [_scanManager scanResult:^(NSArray *metadataObjects) {
//        NSLog(@"metadataObjects - - %@", metadataObjects);
        
        if (metadataObjects != nil && metadataObjects.count > 0) {
             [weakSelf.scanManager palySoundName:@"sound.caf"];
             AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
            NSString *url =[obj stringValue];
           
            LXQRResultController *Vc =[[LXQRResultController alloc]init];
            Vc.navTitle = @"扫描结果";
            if ([url hasPrefix:@"http"]) {
                Vc.url = url;
            }
            [weakSelf.navigationController pushViewController:Vc animated:YES];
        
        } else {
            [NSObject showMessag:@"暂未识别出扫描的二维码" toView:weakSelf.view afterDelay:1];
        }
    }];
    
    
    //光线变化回调
    [_scanManager brightnessChange:^(CGFloat brightness) {
        
        [weakSelf.scanView lightBtnChangeWithBrightnessValue:brightness];
        
    }];
```

```
相册中选择识别二维码：

#pragma mark---借助第三方相册
- (void)rightBarButtonItenAction {
    
  
    TZImagePickerController *pickerController = [[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:self];
    
    WS(weakSelf);
    
    [pickerController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photo, NSArray *assets, BOOL isSelectOriginalPhoto){
        
//        NSLog(@"%@",photo);
        
        UIImage *image = photo[0];
        // CIDetector(CIDetector可用于人脸识别)进行图片解析，从而使我们可以便捷的从相册中获取到二维码
        // 声明一个 CIDetector，并设定识别类型 CIDetectorTypeQRCode
        CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
        
        // 取得识别结果
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
        
        NSString *resultStr;
        if (features.count == 0) {
            
            [NSObject showMessag:@"暂未识别出二维码" toView:self.view afterDelay:1];
        }else{
            for (int index = 0; index < [features count]; index ++) {
                CIQRCodeFeature *feature = [features objectAtIndex:index];
                resultStr = feature.messageString;
            }
            LXQRResultController *Vc =[[LXQRResultController alloc]init];
            Vc.navTitle = @"扫描结果";
            if ([resultStr hasPrefix:@"http"]) {
                Vc.url = resultStr;
            }
            [weakSelf.navigationController pushViewController:Vc animated:YES];
      
        }
        
    }];
    [self presentViewController:pickerController animated:YES completion:nil];
    
}
```
