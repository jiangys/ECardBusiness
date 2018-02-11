//
//  ECAddressOpeningTimeViewCell.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/8.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECAddressOpeningTimeViewCell.h"
#import "ECAddressModel.h"
#import "ECOpenTimeItemView.h"

@interface ECAddressOpeningTimeViewCell() <UIAlertViewDelegate>
@property(nonatomic, weak) UILabel *addressLabel; // 详细地址
@property(nonatomic, weak) UILabel *addressTitle;
@property(nonatomic, weak) UIImageView *addressImageView;
@property(nonatomic, weak) UIView *lineView;
@property(nonatomic, weak) UILabel *openTimeTitle;
@property(nonatomic, weak) UIImageView *openTimeImageView;
@property(nonatomic, weak) UIButton *saveButton;
@property(nonatomic, strong) UIView *timeView;
@property(nonatomic, strong) ECOpenTimeItemView *openTimeItemView;
@property (nonatomic, copy) void(^eventTouchUpInsideHandler)(void);
@end

@implementation ECAddressOpeningTimeViewCell

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
        
        UIImageView *openTimeImageView = [[UIImageView alloc] init];
        openTimeImageView.image = [UIImage imageNamed:@"setting_address"];
        [self.contentView addSubview:openTimeImageView];
        self.openTimeImageView = openTimeImageView;
        
        UILabel *openTimeTitle = [[UILabel alloc] init];
        openTimeTitle.textColor = UIColorMain_Gray;
        openTimeTitle.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:openTimeTitle];
        self.openTimeTitle = openTimeTitle;
        
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
        
        _openTimeItemView = [[ECOpenTimeItemView alloc] init];
        _openTimeItemView.hidden = YES;
        [self.contentView addSubview:_openTimeItemView];
    }
    return self;
}

- (void)setOpenModel:(ECOpeningModel *)openModel {
    CGFloat padding = 16;
    ECAddressModel *addressModel = openModel.userStoreProfile;
    
    self.addressImageView.frame = CGRectMake(padding, 22, 16, 16);
    self.addressTitle.text = [NSString stringWithFormat:@"地址%@",openModel.openNo];
    self.addressTitle.frame = CGRectMake(self.addressImageView.right + 10, 20, 100, 20);
    
    // 详细地址 //@"12-54 Estates Lane, Bayside, NY, 11360";
    NSString *detailAddress = [NSString stringWithFormat:@"%@,%@",addressModel.fullAddress, addressModel.zipCode];
    self.addressLabel.text = detailAddress;
    self.addressLabel.frame = CGRectMake(150, 0, SCREEN_WIDTH - padding - 150, 80);
    
    self.lineView.frame = CGRectMake(padding, 80, SCREEN_WIDTH - 2 * padding, 0.5);
    
    self.openTimeImageView.frame = CGRectMake(padding, self.lineView.bottom + 22, 16, 16);
    self.openTimeTitle.text = [NSString stringWithFormat:@"营业时间%@",openModel.openNo];
    self.openTimeTitle.frame = CGRectMake(self.openTimeImageView.right + 10, self.openTimeImageView.top, 100, 20);
    
    if (openModel.hasOpenTime) {
        _openTimeItemView.hidden = NO;
        _openTimeItemView.frame = CGRectMake(0, self.openTimeTitle.bottom + 10, SCREEN_WIDTH, 35 * 7);
        _openTimeItemView.openDayList = openModel.openDayList;
        [self.saveButton setTitle:@"修改营业时间" forState:UIControlStateNormal];
        self.saveButton.frame = CGRectMake(60, self.openTimeTitle.bottom + 35 * 7 + 20, SCREEN_WIDTH - 120, 44);
    } else {
        _openTimeItemView.hidden = YES;
        [self.saveButton setTitle:@"添加营业时间" forState:UIControlStateNormal];
        self.saveButton.frame = CGRectMake(60, self.openTimeTitle.bottom + 25, SCREEN_WIDTH - 120, 44);
    }
}

- (void)addEventTouchUpInsideHandler:(void (^)(void))handler {
    self.eventTouchUpInsideHandler = handler;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"ECAddressOpeningTimeViewCell";
    ECAddressOpeningTimeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ECAddressOpeningTimeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellAccessoryNone;
    return cell;
}

@end
