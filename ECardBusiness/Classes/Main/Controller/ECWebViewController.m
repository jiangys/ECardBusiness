//
//  ECWebViewController.m
//  ECardBusiness
//
//  Created by yongsheng.jiang on 2018/1/20.
//  Copyright © 2018年 bige. All rights reserved.
//

#import "ECWebViewController.h"
#import "WebViewJavascriptBridge.h"

@interface ECWebViewController ()

@end

@implementation ECWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    WKWebView* webView = [[NSClassFromString(@"WKWebView") alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [webView loadRequest:request];
}

@end
