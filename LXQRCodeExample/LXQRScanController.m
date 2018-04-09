//
//  LXQRScanController.m
//  LXQRCodeExample
//
//  Created by 漫漫 on 2018/4/8.
//  Copyright © 2018年 漫漫. All rights reserved.
//

#import "LXQRScanController.h"
#import "LXQRResultController.h"
#import "TZImagePickerController.h"
/**自己调整位置 */
/** 扫描内容的 W 值 */
#define scanBorderW 0.7 * self.view.frame.size.width
/** 扫描内容的 x 值 */
#define scanBorderX 0.5 * (1 - 0.7) * self.view.frame.size.width
/** 扫描内容的 Y 值 */
#define scanBorderY 0.32 * (self.view.frame.size.height - scanBorderW)

@interface LXQRScanController ()<TZImagePickerControllerDelegate>
@property(nonatomic,strong)LXQRCodeScanManager *scanManager;
@property(strong, nonatomic) LXQRCodeScanView *scanningView;
@property(nonatomic,strong)UIView *topContainer;//包一层是防止push动画的的问题（不能为纯透明）
@property(nonatomic,strong)UIView *bottomView;//为了效果
@property (nonatomic, strong) UILabel *promptLabel;//提示文字
@property(nonatomic,strong)LXQRCodeScanView *scanView;
@end

@implementation LXQRScanController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.scanView addTimer];
    [_scanManager startRunning];
    [_scanManager resetSampleBufferDelegate];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.scanView removeTimer];

    [_scanManager stopRunning];
    [_scanManager cancelSampleBufferDelegate];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =[UIColor clearColor];
    
    [self setUp];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:(UIBarButtonItemStyleDone) target:self action:@selector(rightBarButtonItenAction)];
  
  
}
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
-(void)setUp{
    [self.view addSubview:self.topContainer];
    
    [self.topContainer addSubview:self.scanView];
    [self.topContainer addSubview:self.promptLabel];
    [self setupScanManager];
    [self.view addSubview:self.bottomView];
}
-(void)setupScanManager{
    self.scanManager = [LXQRCodeScanManager sharedManager];
    
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    // AVCaptureSessionPreset1920x1080 推荐使用，对于小型的二维码读取率较高
    [_scanManager setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr currentController:self];
    
    WS(weakSelf);
    
     //光扫描结果回调
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
    
}
-(UIView *)topContainer{
    if (!_topContainer) {
        _topContainer =[[UIView alloc]initWithFrame:CGRectMake(0,NAVH , Device_Width, Device_Height -60 -NAVH )];
        _topContainer.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        
    }
    return _topContainer;
}
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0,Device_Height - 60 , Device_Width, 60 )];
        _bottomView.backgroundColor =[[UIColor blackColor]colorWithAlphaComponent:0.5];

    }
    return _bottomView;
}
-(LXQRCodeScanView *)scanView{
    if (!_scanView) {
        _scanView =[[LXQRCodeScanView alloc]initWithFrame:CGRectMake(scanBorderX, scanBorderY, scanBorderW, scanBorderW)];
    }
    return _scanView;
}
-(UILabel *)promptLabel{
    if (!_promptLabel) {
        _promptLabel =[UILabel LXLabelWithText:@"将二维码放入框内, 即可自动扫描" textColor:[[UIColor whiteColor] colorWithAlphaComponent:0.6] backgroundColor:[UIColor clearColor] frame:CGRectMake(0, self.scanView.bottom +50, Device_Width, 20) font:Font(13) textAlignment:NSTextAlignmentCenter];
    }
    return _promptLabel;
}
@end
