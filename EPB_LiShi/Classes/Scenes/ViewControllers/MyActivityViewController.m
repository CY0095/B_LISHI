//
//  MyActivityViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/30.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "MyActivityViewController.h"

@interface MyActivityViewController ()
@property (strong, nonatomic)UITableView *myActivityTableView;
@end

@implementation MyActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置tableView
    self.myActivityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WindownWidth, WindowHeight - 64)];
    

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
