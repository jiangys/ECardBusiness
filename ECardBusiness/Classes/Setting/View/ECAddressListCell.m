//
//  ECAddressListCell.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/27.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECAddressListCell.h"

@interface ECAddressListCell()<UIAlertViewDelegate>
@property(nonatomic, weak) UILabel *addressLabel; // 详细地址
@property(nonatomic, weak) UILabel *addressTitle;
@property(nonatomic, weak) UIImageView *iconImageView;

@property(nonatomic, weak) UILabel *nameLable; // 收货人
@property(nonatomic, weak) UILabel *phoneLable; // 手机号

@property(nonatomic, weak) UIButton *setDefaultButton; // 设为默认地址
@property(nonatomic, weak) UIButton *editButton; // 编辑
@property(nonatomic, weak) UIButton *deleteButton; // 删除

@property(nonatomic,weak) UIView *lineView; // 地址栏与编辑栏 分割线
@property(nonatomic, weak) UIView *editContentView; // 编辑栏

@end

@implementation ECAddressListCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = UIColorFromHex(0xffffff);
        
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.image = [UIImage imageNamed:@"setting_address"];
        [self.contentView addSubview:iconImageView];
        self.iconImageView = iconImageView;
        
        UILabel *addressTitle = [[UILabel alloc] init];
        addressTitle.textColor = UIColorMain_Gray;
        addressTitle.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:addressTitle];
        self.addressTitle = addressTitle;
        
        // 详细地址
        UILabel *addressLabel = [[UILabel alloc] init];
        addressLabel.textColor = UIColorMain_Normal;
        addressLabel.font = [UIFont systemFontOfSize:14];
        addressLabel.numberOfLines = 2;
        addressLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:addressLabel];
        self.addressLabel = addressLabel;
        
//        // 地址栏与编辑栏 分割线
//        UIView *lineView = [[UIView alloc] init];
//        lineView.backgroundColor = UIColorMain_Gray;
//        [self addSubview:lineView];
//        self.lineView = lineView;
//
//        // 底部操作按钮
//        UIView *editContentView = [[UIView alloc] init];
//        editContentView.backgroundColor = [UIColor whiteColor];
//        [self addSubview:editContentView];
//        self.editContentView = editContentView;
        
//        // 设为默认地址
//        UIButton *setDefaultButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        setDefaultButton.titleLabel.font = Font_22;
//        setDefaultButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [setDefaultButton setTitle:@"设为默认" forState:UIControlStateNormal];
//        [setDefaultButton setTitleColor:Color_777777 forState:UIControlStateNormal];
//        [setDefaultButton setImage:[UIImage imageNamed:@"commom_choice_nor"] forState:UIControlStateNormal];
//        [setDefaultButton setImage:[UIImage imageNamed:@"commom_choice_pre"] forState:UIControlStateSelected];
//        [setDefaultButton addTarget:self action:@selector(setDefaultClick:) forControlEvents:UIControlEventTouchUpInside];
//        [editContentView addSubview:setDefaultButton];
//        self.setDefaultButton = setDefaultButton;
//
//        // 编辑按钮
//        UIButton *editButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        editButton.contentMode = UIViewContentModeScaleAspectFit;
//        [editButton setImage:[UIImage imageNamed:@"address_edit"] forState:UIControlStateNormal];
//        [editButton addTarget:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
//        self.editButton = editButton;
//        [editContentView addSubview:editButton];
//
//        // 删除按钮
//        UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [deleteButton setImage:[UIImage imageNamed:@"address_delete"] forState:UIControlStateNormal];
//        [deleteButton addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
//        self.deleteButton = deleteButton;
//        [editContentView addSubview:deleteButton];
        
    }
    return self;
}

- (void)setAddressModel:(ECAddressModel *)addressModel {
    _addressModel = addressModel;
    CGFloat padding = 16;
    
    
    self.iconImageView.frame = CGRectMake(padding, 22, 16, 16);
    
    self.addressTitle.text = [NSString stringWithFormat:@"地址%@",addressModel.addressNo];
    self.addressTitle.frame = CGRectMake(self.iconImageView.right + 10, 20, 100, 20);
    
    // 详细地址 //@"12-54 Estates Lane, Bayside, NY, 11360";
    NSString *detailAddress = [NSString stringWithFormat:@"%@,%@",addressModel.fullAddress, addressModel.zipCode];
    self.addressLabel.text = detailAddress;
    //CGSize addressLabelSize = [detailAddress sizeMakeWithFont:self.addressLabel.font constrainedToWidth:SCREEN_WIDTH - padding - 150];
    self.addressLabel.frame = CGRectMake(150, 0, SCREEN_WIDTH - padding - 150, 80);
    
//    // 收货人
//    self.nameLable.text = addressModel.consignee;
//    CGSize nameLableSize = [addressModel.consignee sizeMakeWithFont:Font_24];
//    self.nameLable.frame = (CGRect){{padding,padding},nameLableSize};
//
//    // 手机号
//    NSString *phone = [addressModel.tel stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
//    self.phoneLable.text = phone;
//    CGSize phoneLableSize = [phone sizeMakeWithFont:Font_24];
//    CGFloat phoneLableX = CGRectGetMaxX(self.nameLable.frame) + padding;
//    self.phoneLable.frame = (CGRect){{phoneLableX, padding},phoneLableSize};

    
    // 地址View
    
//    // 地址栏与编辑栏 分割线
//    self.lineView.frame = CGRectMake(padding, self.addressLabel.bottom + 20, SCREEN_WIDTH, 0.5);
//    
//    // 底部view
//    CGFloat editContentViewH = 34;
//    self.editContentView.frame = CGRectMake(0, self.lineView.bottom, SCREEN_WIDTH, editContentViewH);
//    
//    // 设为默认地址
//    self.setDefaultButton.frame = CGRectMake(padding, 0, 120, editContentViewH);
//    
//    // 编辑
//    self.editButton.frame = CGRectMake(SCREEN_WIDTH - 80, 0, 40, editContentViewH);
//    
//    // 删除
//    self.deleteButton.frame = CGRectMake(SCREEN_WIDTH - 40, 0, 40, editContentViewH);
//    
//    // 设置默认地址
//    if ([addressModel.default_address isEqualToString:@"1"]) {
//        self.setDefaultButton.selected = YES;
//    } else {
//        self.setDefaultButton.selected = NO;
//    }
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"addressListCell";
    ECAddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ECAddressListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
}

#pragma mark - 私有方法，发送代理

- (void)editClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(addressListCellEditClicked:)]) {
        [self.delegate addressListCellEditClicked:self];
    }
}

- (void)deleteClick:(UIButton *)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"确认要删除这条地址" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertView show];
}

/**
 *  默认选中
 */
- (void)setDefaultClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(addressListCellDidSelectedClicked:)]) {
        [self.delegate addressListCellDidSelectedClicked:self];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        // 发送删除代理
        if ([self.delegate respondsToSelector:@selector(addressListCellDeleteClicked:)]) {
            [self.delegate addressListCellDeleteClicked:self];
        }
    }
}

@end
