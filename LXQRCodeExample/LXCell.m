//
//  LXCell.m
//  LXQRCodeExample
//
//  Created by 漫漫 on 2018/4/9.
//  Copyright © 2018年 漫漫. All rights reserved.
//

#import "LXCell.h"

@implementation LXCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle= UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    

}
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    
    [super setHighlighted:highlighted animated:animated];

}
@end
