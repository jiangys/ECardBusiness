//
//  ECApi.h
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/2/5.
//  Copyright © 2018年 bige. All rights reserved.
//

#pragma mark - 常量定义
//static NSString *const ECMacro_Api = @"http://34.236.73.23";
static NSString *const ECMacro_Api = @"http://api.ecard";
static NSString *const web_add_bandcard = @"http://dwolla.ecard/dwolla_iav.html?t="; //打开增加银行卡页面

static NSString *const api_login = @"/merchantAuth/merchantLoginByEmailWithPassword.do"; // 邮箱+密码登录
static NSString *const api_login_Code = @"/merchantAuth/merchantLoginByEmailWithCode.do"; // 邮箱+验证码登录
static NSString *const api_login_send_emilCode = @"/auth/authMail.do"; // 发送邮件验证码
static NSString *const api_login_register = @"/merchantAuth/merchantRegister.do"; // 商家注册
static NSString *const api_login_companyType = @"/info/cateType/list.do"; // 商家类型信息查询
static NSString *const api_login_state = @"/info/state/list.do"; // 州信息查询

static NSString *const api_uploadImage = @"/file/avatar/upload"; // 上传头像

static NSString *const api_user_info = @"/userOperation/userInfo.do"; // get 获取用户基本信息
static NSString *const api_user_addAddress = @"/auth/get.do"; // post 保存用户信息
static NSString *const api_user_iavToken = @"/userOperation/getIAVToken"; // get 跳转到H5需要传的参数
static NSString *const api_user_bankcardList = @"/userOperation/getUserFundingSource.do"; // get 获取银行列表，需要session
static NSString *const api_user_bankcardDelete = @"/userOperation/removeUserFundingSource.do"; // post 删除银行卡
static NSString *const api_user_addressList = @"/merchantOperation/queryMerchantStoreAddress.do"; // get 获取商家地址
static NSString *const api_user_addressSave = @"/merchantOperation/saveAddress.do"; // post 添加商家地址
static NSString *const api_user_updateOpenTime = @"/merchantOperation/updateOpenTime.do"; // post 更新地址(商铺)营业时间
static NSString *const api_user_updateContact = @"/merchantOperation/updateContact.do"; // post 更新地址(商铺)联系电话
static NSString *const api_user_queryMerchantStore = @"/merchantOperation/queryMerchantStoreByUserId.do"; // get 获取商家商铺列表
static NSString *const api_user_updateAvatar = @"/userOperation/updateUserAvatarUrl.do"; // get 更新头像
