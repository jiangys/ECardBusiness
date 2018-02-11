//
//  ECMyInfoViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/27.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECMyInfoViewController.h"
#import "YSMine.h"
#import "ECSettingCellDataSource.h"
#import "ECAddressViewController.h"
#import "ECPhoneViewController.h"
#import "ECOpeningTimeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ECUploadTool.h"
#import "ECSettingService.h"

@interface ECMyInfoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) ECSettingCellDataSource *cellDataSource;
@property (nonatomic, strong) UIImageView *iconImageView;
@end

@implementation ECMyInfoViewController

- (ECSettingCellDataSource *)cellDataSource
{
    if (!_cellDataSource) {
        _cellDataSource = [ECSettingCellDataSource itemWithGroupArray:[self setupGroup]];
    }
    return _cellDataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupGroup];
    
    [self setupTableView];
}

- (void)setupTableView {
    _tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    _tableView.dataSource = self.cellDataSource;
    _tableView.delegate = self.cellDataSource;
    _tableView.tableHeaderView = [self tableHeaderView];
    _tableView.tableFooterView = [UIView new];
    _tableView.separatorStyle = UITableViewCellStyleValue1;
    [self.view addSubview:_tableView];
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (UIView *)tableHeaderView {
    UIView *bgView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 145)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 60) * 0.5, 25, 60, 60)];
    iconImageView.contentMode = UIViewContentModeScaleToFill;
    iconImageView.layer.masksToBounds = YES;
    iconImageView.layer.cornerRadius = iconImageView.width * 0.5;
    [bgView addSubview:iconImageView];
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:[ECConfigModel defaultModel].userModel.avatarUrl] placeholderImage:[UIImage imageNamed:@"home_header_default_icon"]];
    self.iconImageView = iconImageView;
    
    UIButton *headerButton = [[UIButton alloc] initWithFrame:CGRectMake(0, iconImageView.bottom + 10, SCREEN_WIDTH, 16)];
    [headerButton setTitle:@"点击上传图片" forState:UIControlStateNormal];
    [headerButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [headerButton setTitleColor:UIColorFromHex(0x666666) forState:UIControlStateNormal];
    [headerButton addTarget:self action:@selector(headerButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:headerButton];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, bgView.height - 10, SCREEN_WIDTH, 10)];
    lineView.backgroundColor = UIColorFromHex(0xf2f6fa);
    [bgView addSubview:lineView];
    
    return bgView;
}

- (NSMutableArray *)setupGroup {
    NSMutableArray *groupArray = [NSMutableArray array];
    // 1.创建组
    YSMineCellGroup *group = [YSMineCellGroup group];
    [groupArray addObject:group];
    
    ECUserInfoModel *userModel = [ECConfigModel defaultModel].userModel;
    // 2.设置组的所有行数据
    YSMineCellItemArrow *address = [YSMineCellItemArrow itemWithTitle:@"添加地址"];
    address.subtitle = [NSString stringWithFormat:@"%@,%@",userModel.fullAddress, userModel.zipCode];//@"12-54 Estates Lane,Bayside, NY, 11360";
    address.destVcClass = [ECAddressViewController class];
    
    YSMineCellItemArrow *phone = [YSMineCellItemArrow itemWithTitle:@"添加电话号码"];
    phone.subtitle = userModel.contact;
    phone.destVcClass = [ECPhoneViewController class];
    
    YSMineCellItemArrow *openingTime = [YSMineCellItemArrow itemWithTitle:@"添加/更改营业时间"];
    openingTime.destVcClass = [ECOpeningTimeViewController class];
    
    YSMineCellItemLabel *email = [YSMineCellItemLabel itemWithTitle:@"Email"];
    email.text = userModel.email;
    
    group.items = @[address, phone, openingTime, email];
    
    return groupArray;
}

#pragma mark - 上传头像
- (void)headerButtonClick {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    __weak typeof(self) weakSelf = self;
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf takePhoto];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf localPhoto];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:^{
        }];
    }];
    [alert addAction:action1];
    [alert addAction:action2];
    [alert addAction:action3];
    [self presentViewController:alert animated:YES completion:nil];
}

//打开相机
- (void)takePhoto {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])//相机
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
    else{
        NSLog(@"模拟器情况下无法打开");
    }
}

//打开相册
- (void)localPhoto {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])//相册
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        
        //先检查相机可用是否
        BOOL cameraIsAvailable = [self checkCamera];
        if (YES == cameraIsAvailable) {
            [self presentViewController:picker animated:YES completion:nil];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请在iPhone的“设置-隐私-相机”选项中，允许本应用程序访问你的相机。" delegate:self cancelButtonTitle:@"好，我知道了" otherButtonTitles:nil];
            [alert show];
        }
    }
    else{
        NSLog(@"相册打不开应该是出问题了");
    }
}

// 检查相机是否可用
- (BOOL)checkCamera {
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(AVAuthorizationStatusRestricted == authStatus ||
       AVAuthorizationStatusDenied == authStatus)
    {
        //相机不可用
        return NO;
    }
    //相机可用
    return YES;
}

//当选择一张图片后进入到这个协议方法里
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"]) {
        //先把图片转成NSData
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        self.iconImageView.image = image;
        
        // 头像的话，需要压缩照片，就设置为200*200，有需要可以自己改
        CGSize imageSize = image.size;
        imageSize.width = 200;
        imageSize.height = (image.size.height/image.size.width) * 200;
        //压缩图片尺寸
        image = [ECUploadTool imageWithImageSimple:image scaledToSize:imageSize];
        
        //上传到服务器
        [MBProgressHUD showMessage:@"loading" toView:self.view];
        [ECService uploadImage:image success:^(NSString *imageUrl) {
            [ECSettingService updateAvatarWithUrl:imageUrl success:^(id responseObj) {
                [ECConfigModel defaultModel].userModel.avatarUrl = imageUrl;
                [MBProgressHUD hideHUDForView:self.view];
                [MBProgressHUD showToast:@"更新成功" toView:self.view];
            } failure:^(NSString *errorMsg) {
                [MBProgressHUD hideHUDForView:self.view];
            }];
        } failure:^(NSString *errorMsg) {
            [MBProgressHUD hideHUDForView:self.view];
        }];
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            NSLog(@"关闭相册界面");
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
