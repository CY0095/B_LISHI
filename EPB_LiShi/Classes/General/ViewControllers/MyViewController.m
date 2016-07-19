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
#import "MyAttentionViewController.h"
#import "ChangeMydataViewController.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *headView;// 头视图
@property (weak, nonatomic) IBOutlet UITableView *mytableView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;// 用户头像
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;// 立即登录按钮

// 退出登录按钮
@property (weak, nonatomic) IBOutlet UIButton *quiteBtn;


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
    self.headerImg.userInteractionEnabled = YES;
    // 给头像添加手势
    UITapGestureRecognizer *tapImg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgAction:)];
    [self.headerImg addGestureRecognizer:tapImg];
    // 添加个人资料按钮
    [self addRightButton];
    
}


// 添加右按钮
-(void)addRightButton{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mydata"] style:(UIBarButtonItemStylePlain) target:self action:@selector(changeMydata)];
    
}
// 修改个人资料按钮
-(void)changeMydata{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLog"]) {
        ChangeMydataViewController *changeVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ChangeMydataViewController"];
        [self.navigationController pushViewController:changeVC animated:YES];
    }else{
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还没有登录" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"去登录" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }];
        [alertC addAction:okaction];
        
        [self presentViewController:alertC animated:YES completion:^{
            
        }];
    }
    
    
    
    
}

// 立即登录
- (IBAction)loginAction:(id)sender {
    
    if ([self.loginBtn.titleLabel.text isEqualToString:@"立即登录"]) {
        LoginViewController *logVC = [LoginViewController new];
        
        [self.navigationController pushViewController:logVC animated:YES];
    }
    
}
// 头像点击事件
-(void)tapImgAction:(UITapGestureRecognizer *)sender{
    NSLog(@"我是点击手势");
}

// 判断是否登录
-(void)judgeLogin{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLog"]) {
        NSString *nickname = [[NSUserDefaults standardUserDefaults] objectForKey:@"nickname"];
        NSString *headicon = [[NSUserDefaults standardUserDefaults] objectForKey:@"headicon"];
        if (headicon) {
            [self.headerImg setImageWithURL:[NSURL URLWithString:headicon] placeholderImage:[UIImage imageNamed:@"boy_default"]];
        }
        [self.loginBtn setTitle:nickname forState:(UIControlStateNormal)];
        
        
        
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 判断是否登录
    [self judgeLogin];
    // 判断是否出现退登按钮
    [self judgeShowQuiteBtn];
    
}


// 判断是否出现退登按钮
-(void)judgeShowQuiteBtn{
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLog"] == YES) {
        self.quiteBtn.hidden = NO;
        
    }else{
        // 隐藏退登按钮
        self.quiteBtn.hidden = YES;
    }
    
    
    
}


// 退出当前账号按钮
- (IBAction)quiteLoginAction:(id)sender {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"您是否要退出当前账号" preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        // 在主线程刷新数据
        dispatch_async(dispatch_get_main_queue(), ^{
            // 清除登录信息
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isLog"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_id"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"nickname"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"headicon"];
            
            [self.loginBtn setTitle:@"立即登录" forState:(UIControlStateNormal)];
            self.headerImg.image = [UIImage imageNamed:@"boy_default"];
            // 判断是否登录
            [self judgeLogin];
            // 判断是否出现退登按钮
            [self judgeShowQuiteBtn];
        });
        
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alertC addAction:okaction];
    [alertC addAction:cancelAction];
    [self presentViewController:alertC animated:YES completion:nil];
    
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

// cell点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BOOL isLog = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLog"];
    if (isLog) {
        if (indexPath.row == 0) {
            
        }else if (indexPath.row == 1){
            MyAttentionViewController *myAttVC = [[MyAttentionViewController alloc] init];
            [self.navigationController pushViewController:myAttVC animated:YES];
        }else if (indexPath.row == 2){
            
        }else if (indexPath.row == 3){
            
        }else if (indexPath.row == 4){
            
        }
        
        
    }else{
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还没有登录" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"去登录" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            LoginViewController *loginVC = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:loginVC animated:YES];
        }];
        [alertC addAction:okaction];
        
        [self presentViewController:alertC animated:YES completion:^{
            
        }];
    }
    
    
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
