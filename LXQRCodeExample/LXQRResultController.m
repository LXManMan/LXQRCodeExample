//
//  LXQRResultController.m
//  LXQRCodeExample
//
//  Created by 漫漫 on 2018/4/8.
//  Copyright © 2018年 漫漫. All rights reserved.
//

#import "LXQRResultController.h"
#import <WebKit/WebKit.h>
#import "LXWebViewProgressView.h"
@interface LXQRResultController ()<WKNavigationDelegate,WKUIDelegate>
{
    BOOL isFirstLoad;
}
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) LXWebViewProgressView *progressView;

@end

@implementation LXQRResultController

-(void)setNavTitle:(NSString *)navTitle{
    _navTitle  = navTitle;
}
-(void)setUrl:(NSString *)url{
    _url = url;
}
-(void)setIsPresent:(BOOL)isPresent{
    _isPresent  = isPresent;
}
-(void)viewWillAppear:(BOOL)animated{
    
    if (isFirstLoad) {
        [self.webView reload];
    }else{
        isFirstLoad = YES;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = self.navTitle;
    [self setup];
    [self responData];
}

-(void)responData{
    
    
    [NSObject showMessag:@"加载中..." toView:self.view];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
}
-(void)setup{
    [self.view addSubview:self.webView];
    
    [self.view addSubview:self.progressView];
    
    
}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    // js 里面的alert实现，如果不实现，网页的alert函数无效
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:^{}];
    
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler {
    //  js 里面的alert实现，如果不实现，网页的alert函数无效  ,
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler(YES);
                                                      }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action){
                                                          completionHandler(NO);
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:^{}];
    
}
#pragma KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        
        double progress = self.webView.estimatedProgress;
        
        self.progressView.progress = progress;
        
        if (progress >= 1.00) {
            [NSObject hideforView:self.view];
        }
    }
}
-(WKWebView *)webView{
    if (!_webView) {
        _webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.allowsBackForwardNavigationGestures = YES;
        _webView.configuration.allowsInlineMediaPlayback = YES;
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        
    }
    return _webView;
}
-(LXWebViewProgressView *)progressView{
    if (!_progressView) {
        
        CGFloat ProgressY = 0;
        if (self.navigationController.navigationBar && !self.navigationController.navigationBar.hidden) {
            ProgressY = NAVH;
        }
        if (!self.navigationController.navigationBar.translucent) {
            ProgressY = 0;
        }
        _progressView =[[LXWebViewProgressView alloc]initWithFrame:CGRectMake(0, ProgressY, CGRectGetWidth(self.view.frame), 2.5)];
        _progressView.progress = 0.00;
        
    }
    return _progressView;
}
-(void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
@end


