//
//  ECAddressPhoneCell.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/7.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECAddressPhoneCell.h"

@interface ECAddressPhoneCell() <UIAlertViewDelegate>
@property(nonatomic, weak) UILabel *addressLabel; // 详细地址
@property(nonatomic, weak) UILabel *addressTitle;
@property(nonatomic, weak) UIImageView *addressImageView;
@property(nonatomic, weak) UIView *lineView;
@property(nonatomic, weak) UILabel *phoneLabel;
@property(nonatomic, weak) UILabel *phoneTitle;
@property(nonatomic, weak) UIImageView *phoneImageView;
@property(nonatomic, weak) UIButton *saveButton;

@property (nonatomic, copy) void(^eventTouchUpInsideHandler)(void);
@end

@implementation ECAddressPhoneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColorFromHex(0xffffff);
        
        UIImageView *iconImageView = [[UIImageView alloc] init];
        iconImageView.image = [UIImage imageNamed:@"setting_address"];
        [self.contentView addSubview:iconImageView];
        self.addressImageView = iconImageView;
        
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
        
        // 地址栏与编辑栏 分割线
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = UIColorMain_line;
        [self.contentView addSubview:lineView];
        self.lineView = lineView;
        
        UIImageView *phoneImageView = [[UIImageView alloc] init];
        phoneImageView.image = [UIImage imageNamed:@"setting_address"];
        [self.contentView addSubview:phoneImageView];
        self.phoneImageView = phoneImageView;
        
        UILabel *phoneTitle = [[UILabel alloc] init];
        phoneTitle.textColor = UIColorMain_Normal;
        phoneTitle.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:phoneTitle];
        self.phoneTitle = phoneTitle;
        
        UILabel *phoneLabel = [[UILabel alloc] init];
        phoneLabel.textColor = UIColorMain_Normal;
        phoneLabel.font = [UIFont systemFontOfSize:14];
        phoneLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:phoneLabel];
        self.phoneLabel = phoneLabel;
        
        UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        saveButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [saveButton setTitle:@"添加电话号码" forState:UIControlStateNormal];
        [saveButton setTitleColor:UIColorMain_Highlighted forState:UIControlStateNormal];
        saveButton.layer.borderColor = UIColorMain_Highlighted.CGColor;
        saveButton.layer.borderWidth = 1.f;
        saveButton.layer.masksToBounds = YES;
        saveButton.layer.cornerRadius = 3.f;
        [self.contentView addSubview:saveButton];
        self.saveButton = saveButton;
        @weakify(self);
        [saveButton bk_addEventHandler:^(id sender) {
            @strongify(self)
            if (self.eventTouchUpInsideHandler) {
                self.eventTouchUpInsideHandler();
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setAddressModel:(ECAddressModel *)addressModel {
    CGFloat padding = 16;
    
    self.addressImageView.frame = CGRectMake(padding, 22, 16, 16);
    self.addressTitle.text = [NSString stringWithFormat:@"地址%@",addressModel.addressNo];
    self.addressTitle.frame = CGRectMake(self.addressImageView.right + 10, 20, 100, 20);
    
    // 详细地址 //@"12-54 Estates Lane, Bayside, NY, 11360";
    NSString *detailAddress = [NSString stringWithFormat:@"%@,%@",addressModel.fullAddress, addressModel.zipCode];
    self.addressLabel.text = detailAddress;
    //CGSize addressLabelSize = [detailAddress sizeMakeWithFont:self.addressLabel.font constrainedToWidth:SCREEN_WIDTH - padding - 150];
    self.addressLabel.frame = CGRectMake(150, 0, SCREEN_WIDTH - padding - 150, 80);
    
    self.lineView.frame = CGRectMake(padding, 80, SCREEN_WIDTH - 2 * padding, 0.5);
    
    if (addressModel.contact.length > 0) {
        self.phoneImageView.hidden = NO;
        self.phoneLabel.hidden = NO;
        self.phoneTitle.hidden = NO;
        self.saveButton.hidden = YES;
        
        self.phoneImageView.frame = CGRectMake(padding, self.lineView.bottom + 22, 16, 16);
        self.phoneTitle.text = [NSString stringWithFormat:@"电话%@",addressModel.addressNo];
        self.phoneTitle.frame = CGRectMake(self.phoneImageView.right + 10, self.phoneImageView.top, 100, 20);
        
        self.phoneLabel.text = addressModel.contact;
        self.phoneLabel.frame = CGRectMake(self.addressLabel.left, self.lineView.bottom, SCREEN_WIDTH - padding - 150, 60);
    } else {
        self.phoneImageView.hidden = YES;
        self.phoneLabel.hidden = YES;
        self.phoneTitle.hidden = YES;
        self.saveButton.hidden = NO;
        
        self.saveButton.frame = CGRectMake(60, self.lineView.bottom + 12, SCREEN_WIDTH - 120, 44);
    }
}

- (void)addEventTouchUpInsideHandler:(void (^)(void))handler {
    self.eventTouchUpInsideHandler = handler;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"ECAddressPhoneCell";
    ECAddressPhoneCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ECAddressPhoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
}

@end
