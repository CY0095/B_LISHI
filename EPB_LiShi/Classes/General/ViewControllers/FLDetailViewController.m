//
//  FLDetailViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/8/6.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "FLDetailViewController.h"

@interface FLDetailViewController ()<UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@end

#define Url(ID) [NSString stringWithFormat:@"http://m.lis99.com/club/integralshop/goodDetail/%@/451724",ID]

@implementation FLDetailViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.rootVC.LSTabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.rootVC.LSTabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, WindownWidth, WindowHeight - 64)];
    
    //加载网络数据
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:Url(self.jfID)]]];
    //显示
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
