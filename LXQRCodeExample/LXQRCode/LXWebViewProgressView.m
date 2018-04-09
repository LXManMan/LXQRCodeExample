//
//  LXWebViewProgressView.m
//  LXWKWebViewController
//
//  Created by chenergou on 2018/2/11.
//  Copyright © 2018年 漫漫. All rights reserved.
//

#import "LXWebViewProgressView.h"

@interface  LXWebViewProgressView()
@property(nonatomic,strong)CAGradientLayer *gradient;
@end

@implementation LXWebViewProgressView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        [self.layer addSublayer:self.gradient];
    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self.layer addSublayer:self.gradient];

}
-(void)setProgress:(double)progress{
    _progress = progress;
    
    _gradient.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame) * progress, CGRectGetHeight(self.frame));
    if (progress >= 1.00) {
        self.hidden = YES;
    }
    
}
-(CAGradientLayer *)gradient{
    if (!_gradient) {
        _gradient = [CAGradientLayer layer];
        _gradient.frame  = CGRectMake(0, 0, 0, CGRectGetHeight(self.frame));
        _gradient.colors = @[(id)[UIColor hexStringToColor:@"#0ccd4c"].CGColor,(id)[UIColor hexStringToColor:@"#0fe255"].CGColor];
    }
    return _gradient;
}


@end
