//
//  ECBalanceCell.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/11.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECBalanceCell.h"

@interface ECBalanceCell()

/** 账户类型    number    1-balance 2-cashback */
//@property (nonatomic, copy) NSString *accountType;
///** 金额 */
//@property (nonatomic, copy) NSString *amount;
///** 返现比例    number    当accountType=2 && transactionType=201时有效 */
//@property (nonatomic, copy) NSString *cashbackRate;
///** 头像url */
//@property (nonatomic, copy) NSString *avatarUrl;
///** 明细id */
//@property (nonatomic, copy) NSString *journlId;
///** 头像对应名称 */
//@property (nonatomic, copy) NSString *name;
///** 交易状态 number    1-处理中 2-待处理 3-成功 4-失败 5-取消 6-拒绝 */
//@property (nonatomic, copy) NSString *status;
///** 交易发生时间 */
//@property (nonatomic, copy) NSString *submitTime;
///**  交易类型    number    101-余额充值 102-余额提现 201-支付支出 202-支付收入 301-返现兑换 */
//@property (nonatomic, copy) NSString *transactionType;

@property(nonatomic, strong) UIImageView *avatarImageView; // 详细地址
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *submitTimeLabel;
@property (nonatomic, strong) UILabel *amountLabel;
@property (nonatomic, strong) UILabel *nameDescLabel;
@end

@implementation ECBalanceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColorFromHex(0xffffff);

        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.contentMode = UIViewContentModeScaleToFill;
        iconImageView.layer.masksToBounds = YES;
        iconImageView.layer.cornerRadius = 40 * 0.5;
        [self.contentView addSubview:iconImageView];
        self.avatarImageView = iconImageView;

        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = UIColorMain_Gray;
        nameLabel.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;

        UILabel *nameDescLabel = [[UILabel alloc] init];
        nameDescLabel.textColor = UIColorMain_Normal;
        nameDescLabel.font = [UIFont systemFontOfSize:13];
        nameDescLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:nameDescLabel];
        self.nameDescLabel = nameDescLabel;

        UILabel *submitTimeLabel = [[UILabel alloc] init];
        submitTimeLabel.textColor = UIColorFromHex(0x999999);
        submitTimeLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:submitTimeLabel];
        self.submitTimeLabel = submitTimeLabel;

        UILabel *amountLabel = [[UILabel alloc] init];
        amountLabel.textColor = UIColorFromHex(0xff3f56);
        amountLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:amountLabel];
        self.amountLabel = amountLabel;
    }
    return self;
}

- (void)setBalanceModel:(ECBalanceBillModel *)balanceModel {
    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:balanceModel.avatarUrl] placeholderImage:[UIImage imageNamed:@"home_header_default_icon"]];
    _avatarImageView.frame = CGRectMake(15, 20, 40, 40);
    
    _nameLabel.text = @"Starbucks";
    CGSize nameSize = [_nameLabel.text sizeMakeWithFont:_nameLabel.font];
    _nameLabel.frame = CGRectMake(_avatarImageView.right + 10, _avatarImageView.top, nameSize.width, nameSize.height);
    
    _submitTimeLabel.text = @"03-10-2017";
    CGSize submitTimeSize = [_submitTimeLabel.text sizeMakeWithFont:_submitTimeLabel.font];
    _submitTimeLabel.frame = CGRectMake(_nameLabel.right + 10, _avatarImageView.top + 3, submitTimeSize.width, submitTimeSize.height);
    
    _nameDescLabel.text = @"已充值 - 正在处理";
    CGSize nameDescSize = [_nameDescLabel.text sizeMakeWithFont:_nameDescLabel.font];
    _nameDescLabel.frame = CGRectMake(_avatarImageView.right + 10, _nameLabel.bottom + 8, nameDescSize.width, nameDescSize.height);
    
    _amountLabel.text = [NSString stringWithFormat:@"- $ %.2f",5.0];
    CGSize amountSize = [_amountLabel.text sizeMakeWithFont:_amountLabel.font];
    _amountLabel.frame = CGRectMake(SCREEN_WIDTH - amountSize.width - 20, _avatarImageView.top + 10, amountSize.width, amountSize.height);
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"ECBalanceCell";
    ECBalanceCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ECBalanceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
}

@end
