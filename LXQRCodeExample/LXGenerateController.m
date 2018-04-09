//
//  LXGenerateController.m
//  LXQRCodeExample
//
//  Created by 漫漫 on 2018/4/8.
//  Copyright © 2018年 漫漫. All rights reserved.
//

#import "LXGenerateController.h"
#import "LXCell.h"
@interface LXGenerateController ()

@end

@implementation LXGenerateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor =[UIColor whiteColor];
  
    [self.tableView registerNib:[UINib nibWithNibName:@"LXCell" bundle:nil] forCellReuseIdentifier:@"LXCell"];
    
    self.tableView.rowHeight = 150;
    self.tableView.tableFooterView = [UIView new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LXCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LXCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell =[[LXCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LXCell"];
    }
    
    if (indexPath.row == 0) {
        cell.typeLabel.text = @"普通二维码";
        cell.qrImageView.image =[UIImage LX_ImageOfQRFromURL:@"https://www.jianshu.com/u/3d7c50f31b88" codeSize:100];
    }
    if (indexPath.row == 1) {
        cell.typeLabel.text = @"带logo二维码";
        cell.qrImageView.image =[UIImage LX_ImageOfQRFromURL:@"https://www.jianshu.com/u/3d7c50f31b88" codeSize:100 logoName:@"4b7e25bd43ee" radius:2 borderWidth:1.5 borderColor:[UIColor whiteColor]];
    }
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
