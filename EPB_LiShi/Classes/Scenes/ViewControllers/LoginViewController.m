//
//  LoginViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginRequest.h"
#import "RegisterViewController.h"
#import "MBProgressHUD.h"
@interface LoginViewController ()
@property(strong,nonatomic) UIImageView *backgroundImgView;
@property(strong,nonatomic) UIView *backgroundView;

@property(strong,nonatomic) UITextField *usernameField;// 用户名
@property(strong,nonatomic) UITextField *passwordField;// 密码
//@property(strong,nonatomic)
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    [self drawView];
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rootVC.LSTabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.rootVC.LSTabBar.hidden = NO;
}

-(void)drawView{
    // 添加背景图片
    self.backgroundImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.backgroundImgView.image = [UIImage imageNamed:@"caoyuan.jpg"];
    [self.view addSubview:self.backgroundImgView];
    self.backgroundImgView.userInteractionEnabled = YES;
    self.backgroundView = [[UIView alloc] initWithFrame:self.backgroundImgView.bounds];
    self.backgroundView.backgroundColor = [UIColor clearColor];
    self.backgroundView.userInteractionEnabled = YES;
    // 在图片上添加view视图
    [self.backgroundImgView addSubview:self.backgroundView];
    // 添加中央视图
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindownWidth - 40, WindowHeight /2 - 20)];
    centerView.backgroundColor = [UIColor whiteColor];
    centerView.center = self.view.center;
    centerView.alpha = 0.85;
    [self.view addSubview:centerView];
    // 添加用户名textfield
    self.usernameField = [[UITextField alloc] initWithFrame:CGRectMake(10, WindowHeight / 24, WindownWidth - 60 , WindowHeight/12)];
    
    self.usernameField.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    self.usernameField.layer.cornerRadius = 10;
    self.usernameField.layer.masksToBounds = YES;
    self.usernameField.placeholder = @"请输入账号";
    self.usernameField.alpha = 1;
    // self.usernameField.center = CGPointMake(centerView.center.x,WindowHeight / 12);
    // 密码textfield
    self.passwordField = [[UITextField alloc] initWithFrame:CGRectMake(10, WindowHeight / 8 + 5, WindownWidth - 60, WindowHeight/12)];
    
    self.passwordField.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    self.passwordField.layer.cornerRadius = 10;
    self.passwordField.layer.masksToBounds = YES;
    self.passwordField.placeholder = @"请输入密码";
    self.passwordField.alpha = 1;
    // self.passwordField.center = CGPointMake(centerView.center.x, WindowHeight / 6 + 10);
    self.passwordField.secureTextEntry = YES;// 密文输入
    
    [centerView addSubview:self.usernameField];
    [centerView addSubview:self.passwordField];
    
    // 添加登录按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(10, WindowHeight * 7 / 24 + 10, WindownWidth - 60, WindowHeight/11);
    [loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:30];
    loginBtn.backgroundColor = [UIColor colorWithRed:0 green:146/255.0 blue:0 alpha:1];
    // loginBtn.layer.cornerRadius = 10;
    loginBtn.layer.masksToBounds = YES;
    loginBtn.alpha = 0.85;
    // loginBtn.center = CGPointMake(self.view.center.x, self.view.center.y  + WindowHeight / 11 );
    [loginBtn addTarget:self action:@selector(loginAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [centerView addSubview:loginBtn];
    
    // 添加注册按钮
    UIButton *regisBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WindownWidth / 5, WindowHeight / 18)];
    [regisBtn setTitle:@"去注册" forState:(UIControlStateNormal)];
    [regisBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    regisBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    regisBtn.center = CGPointMake(loginBtn.center.x + loginBtn.bounds.size.width / 4, loginBtn.center.y + loginBtn.bounds.size.height / 2 + WindowHeight / 36);
    [regisBtn addTarget:self action:@selector(registerAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [centerView addSubview:regisBtn];
    
    
    
}
// 登录
-(void)loginAction:(UIButton *)button{
    
    if (self.usernameField.text.length == 0) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"账号不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:nil];
        [alertC addAction:okaction];
        [self presentViewController:alertC animated:YES completion:nil];
    }else if (self.passwordField.text.length == 0){
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:nil];
        [alertC addAction:okaction];
        [self presentViewController:alertC animated:YES completion:nil];
    }else{
        [self.passwordField resignFirstResponder];// 取消键盘响应
        // 登录
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[LoginRequest shareLoginRequest] loginRequestWithUsername:self.usernameField.text passWord:self.passwordField.text success:^(NSDictionary *dic) {
            NSString *status = [dic objectForKey:@"status"];
            if ([status isEqualToString:@"OK"]) {
                // 登录成功的操作
                dispatch_async(dispatch_get_main_queue(), ^{
                    BOOL isLog = YES;
                    // 设置登录成功
                    [[NSUserDefaults standardUserDefaults] setBool:isLog forKey:@"isLog"];
        
                    // 存储userID
                    NSString *user_id = [[dic objectForKey:@"data"] objectForKey:@"user_id"];
                    [[NSUserDefaults standardUserDefaults] setObject:user_id forKey:@"user_id"];
                    // 存储用户昵称
                    NSString *nickname = [[dic objectForKey:@"data"] objectForKey:@"nickname"];
                    [[NSUserDefaults standardUserDefaults] setObject:nickname forKey:@"nickname"];
                    // 存储用户头像
                    NSString *headicon = [[dic objectForKey:@"data"] objectForKey:@"headicon"];
                    [[NSUserDefaults standardUserDefaults] setObject:headicon forKey:@"headicon"];
                    
                    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录成功!" preferredStyle:(UIAlertControllerStyleAlert)];
                    UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                    [alertC addAction:okaction];
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [self presentViewController:alertC animated:YES completion:nil];
                    
                });
            }else{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录失败,请重试" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:nil];
                [alertC addAction:okaction];
                [self presentViewController:alertC animated:YES completion:nil];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSLog(@"error = %@",error);
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"登录失败,请重试" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:nil];
            [alertC addAction:okaction];
            [self presentViewController:alertC animated:YES completion:nil];
        }];
    }
}
// 注册按钮
-(void)registerAction:(UIButton *)button{
    
    
    RegisterViewController *regisVC = [RegisterViewController new];
    [self.navigationController pushViewController:regisVC animated:YES];   
}
// 释放键盘响应
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if ([self.usernameField isFirstResponder]) {
        [self.usernameField resignFirstResponder];
    }else{
        [self.passwordField resignFirstResponder];
    }
    

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
