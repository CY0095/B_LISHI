//
//  MyViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "MyViewController.h"
#import "MyTableViewCell.h"
#import "LoginViewController.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *headView;// 头视图
@property (weak, nonatomic) IBOutlet UITableView *mytableView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;// 用户头像
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;// 立即登录按钮



@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 给头像切圆角
    self.headerImg.layer.cornerRadius = 5;
    self.headerImg.layer.masksToBounds = YES;
    // 注册cell
    [self.mytableView registerNib:[UINib nibWithNibName:@"MyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:MyTableViewCell_Identify];
    self.mytableView.bounces = NO;// 取消反弹
    
}
// 立即登录
- (IBAction)loginAction:(id)sender {
    
    LoginViewController *logVC = [LoginViewController new];
    // logVC.rootVC.LSTabBar.hidden = YES;
    [self.navigationController pushViewController:logVC animated:YES];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rootVC.LSTabBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ------ myTableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyTableViewCell_Identify];
    
    
    if (indexPath.row == 0) {
        cell.myLabel.text = @"我的好友";
        cell.ImgView.image = [UIImage imageNamed:@"haoyou"];
    }else if (indexPath.row == 1){
        cell.myLabel.text = @"我的关注";
        cell.ImgView.image = [UIImage imageNamed:@"guanzhu"];
    }else if (indexPath.row == 2){
        cell.myLabel.text = @"我报名的活动";
        cell.ImgView.image = [UIImage imageNamed:@"huodong"];
    }else if (indexPath.row == 3){
        cell.myLabel.text = @"意见反馈";
        cell.ImgView.image = [UIImage imageNamed:@"yijian"];
    }else if (indexPath.row == 4){
        cell.myLabel.text = @"清理缓存";
        cell.ImgView.image = [UIImage imageNamed:@"qingchu"];
    }
    
    
    return cell;
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
