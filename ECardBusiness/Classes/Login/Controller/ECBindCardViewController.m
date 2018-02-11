//
//  ECBindCardViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/20.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECBindCardViewController.h"
#import "WebViewJavascriptBridge.h"

@interface ECBindCardViewController ()<UIWebViewDelegate,WKNavigationDelegate>

@end

@implementation ECBindCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"绑定银行卡";
    
    WKWebView* webView = [[NSClassFromString(@"WKWebView") alloc] initWithFrame:self.view.bounds];
    webView.navigationDelegate = self;
    [self.view addSubview:webView];
    [WebViewJavascriptBridge enableLogging];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://viva.vip.com/act/m/identity_secret_20160707?wapid=vivac_356"]];
    [webView loadRequest:request];
}

@end
