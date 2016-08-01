//
//  DetailsViewController.m
//  MyProject
//
//  Created by lanou3g on 16/4/23.
//  Copyright © 2016年 刘亚彬. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()
@property(strong,nonatomic)UIImageView *imgView;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.model.title;
    
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"社区" style:(UIBarButtonItemStylePlain) target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WindownWidth, WindowHeight)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.tempUrl]]];
    
    [self.view addSubview:webView];
    
}

- (void)setModel:(CommunityListModel *)model {
    if (_model != model) {
        _model = nil;
        _model = model;
    }
}


- (void)leftAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
