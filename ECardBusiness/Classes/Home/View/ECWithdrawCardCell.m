//
//  ECWithdrawCardCell.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/13.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECWithdrawCardCell.h"

@interface ECWithdrawCardCell()
@property (nonatomic, strong) UILabel *bankNameLabel;
/** 显示选择按钮 */
@property (nonatomic, strong) UIImageView *selectImageView;
@end

@implementation ECWithdrawCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColorFromHex(0xffffff);
        UILabel *bankNameLabel = [[UILabel alloc] init];
        bankNameLabel.textColor = UIColorMain_Gray;
        bankNameLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:bankNameLabel];
        self.bankNameLabel = bankNameLabel;
        
        _selectImageView = [[UIImageView alloc] init];
        _selectImageView.contentMode = UIViewContentModeScaleAspectFit;
        _selectImageView.image = [UIImage imageNamed:@"home_current_select"];
        _selectImageView.hidden = YES;
        [self.contentView addSubview:_selectImageView];
    }
    return self;
}

- (void)setBankCardModel:(ECBankCardModel *)bankCardModel {
    self.bankNameLabel.text = [NSString stringWithFormat:@"%@(%@)",@"", bankCardModel.fsName];
    self.bankNameLabel.frame = CGRectMake(15, 0, SCREEN_WIDTH - 30, 44);
    
    _selectImageView.frame = CGRectMake(SCREEN_WIDTH - 30, 0, 15, 10);
    _selectImageView.centerY = self.bankNameLabel.centerY;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"ECWithdrawCardCell";
    ECWithdrawCardCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ECWithdrawCardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)setCellSelected:(BOOL)selected {
    self.selectImageView.hidden = !selected;
}

@end
