//
//  ViewController.m
//  LXQRCodeExample
//
//  Created by 漫漫 on 2018/4/8.
//  Copyright © 2018年 漫漫. All rights reserved.
//

#import "ViewController.h"
#import "LXGenerateController.h"
#import "LXQRScanController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSArray *dataA;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.navigationItem.title = @"LXQRCode";
    [self.tableView  registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView =[UIView new];
    
    self.dataA = @[@"生成二维码",@"二维码扫描"];
    
     YYImage *image =[YYImage imageNamed:@"WXJaqof"];
    UIImageView *backImageView=[[YYAnimatedImageView alloc]initWithFrame:self.view.bounds];
    backImageView.image = image;
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.tableView.backgroundView = backImageView;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataA.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataA[indexPath.row];
    cell.textLabel.textColor =[[UIColor whiteColor]colorWithAlphaComponent:0.5];
    cell.backgroundColor =[UIColor clearColor];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        LXGenerateController *Vc =[[LXGenerateController alloc]init];
        Vc.navigationItem.title = self.dataA[indexPath.row];
        [self.navigationController pushViewController:Vc animated:YES];
    }
    if (indexPath.row == 1) {
        
        WS(weakSelf);
        [LXQRCodeHelper judgeAuthiorizationStatusWithCurrentVc:self resultBlock:^(BOOL goOn) {

            if (goOn) {
                LXQRScanController *Vc =[[LXQRScanController alloc]init];
                Vc.navigationItem.title = self.dataA[indexPath.row];
                
                [weakSelf.navigationController pushViewController:Vc animated:YES];
            }
        }];

       
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
