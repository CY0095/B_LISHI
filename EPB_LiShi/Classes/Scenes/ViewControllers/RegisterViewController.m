//
//  RegisterViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "RegisterViewController.h"
#import "GetCodeRequest.h"
#import "RegisterRequest.h"
#import "MBProgressHUD.h"
@interface RegisterViewController ()
@property(strong,nonatomic) UIImageView *backgroundImgView;
@property(strong,nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UITextField *username;
@property (strong, nonatomic) UITextField *password;
@property (strong, nonatomic) UITextField *phoneCode;// 验证码

@property (strong, nonatomic) UIButton *getCodeBtn;// 获取验证码按钮
@end

@implementation RegisterViewController

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
    self.backgroundImgView.image = [UIImage imageNamed:@"IMG_5528.jpg"];
    [self.view addSubview:self.backgroundImgView];
    self.backgroundImgView.userInteractionEnabled = YES;
    self.backgroundView = [[UIView alloc] initWithFrame:self.backgroundImgView.bounds];
    self.backgroundView.backgroundColor = [UIColor clearColor];
    self.backgroundView.userInteractionEnabled = YES;
    // 在图片上添加view视图
    [self.backgroundImgView addSubview:self.backgroundView];
    
    // 添加输入框
    self.username = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, WindownWidth*2/3, WindowHeight/15)];
    self.username.backgroundColor = [UIColor whiteColor];
    self.username.layer.cornerRadius = 10;
    self.username.layer.masksToBounds = YES;
    self.username.placeholder = @"手机号:";
    self.username.alpha = 0.8;
    self.username.center = CGPointMake(self.view.center.x, self.view.center.y / 3);
    [self.backgroundView addSubview:self.username];
    
    self.phoneCode = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, WindownWidth*2/3, WindowHeight/15)];
    self.phoneCode.backgroundColor = [UIColor whiteColor];
    self.phoneCode.layer.cornerRadius = 10;
    self.phoneCode.layer.masksToBounds = YES;
    self.phoneCode.placeholder = @"验证码:";
    self.phoneCode.alpha = 0.8;
    self.phoneCode.center = CGPointMake(self.view.center.x, self.view.center.y / 3 + WindowHeight/15+10);
    [self.backgroundView addSubview:self.phoneCode];
    self.getCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.username.bounds.size.width / 3, self.username.bounds.size.height*2/3)];
    [self.getCodeBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    self.getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.getCodeBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.getCodeBtn.backgroundColor = [UIColor grayColor];
    self.getCodeBtn.layer.cornerRadius = 10;
    self.getCodeBtn.layer.masksToBounds = YES;
    self.getCodeBtn.center = CGPointMake(self.phoneCode.center.x + self.phoneCode.bounds.size.width / 3  , self.phoneCode.center.y);
    [self.getCodeBtn addTarget:self action:@selector(getCodeAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backgroundView addSubview:self.getCodeBtn];
    
    // 密码textfield
    self.password = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, WindownWidth*2/3, WindowHeight/15)];
    
    self.password.backgroundColor = [UIColor whiteColor];
    self.password.layer.cornerRadius = 10;
    self.password.layer.masksToBounds = YES;
    self.password.placeholder = @"密码:(6到20位大小写字母和数字)";
    self.password.alpha = 0.8;
    self.password.center = CGPointMake(self.view.center.x, self.view.center.y / 3 + WindowHeight/15 * 2 + 20);
    self.password.secureTextEntry = YES;// 密文输入
    
    [self.backgroundView addSubview:self.password];
    
    // 注册按钮
    UIButton *regisBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WindownWidth*2/3, WindowHeight/13)];
    regisBtn.backgroundColor = [UIColor grayColor];
    regisBtn.layer.cornerRadius = 15;
    regisBtn.layer.masksToBounds = YES;
    regisBtn.alpha = 0.6;
    [regisBtn setTitle:@"确认注册" forState:(UIControlStateNormal)];
    [regisBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    regisBtn.titleLabel.font = [UIFont systemFontOfSize:25];
    regisBtn.center = CGPointMake(self.view.center.x, self.view.center.y / 3 + WindowHeight/15 * 3 + 60);
    [regisBtn addTarget:self action:@selector(registerAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.backgroundView addSubview:regisBtn];
    
}

// 注册方法
-(void)registerAction:(UIButton *)button{
    if (self.username.text.length == 0) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"手机号不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
        [alertC addAction:okaction];
        [self presentViewController:alertC animated:YES completion:nil];
    }else if (self.phoneCode.text.length == 0){
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证码不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
        [alertC addAction:okaction];
        [self presentViewController:alertC animated:YES completion:nil];
    }else if (self.password.text.length == 0){
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
        [alertC addAction:okaction];
        [self presentViewController:alertC animated:YES completion:nil];
    }else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];// 开始加载动画
        [[RegisterRequest shareRegisterRequest] registerRequestWithUsername:self.username.text passWord:self.password.text code:self.phoneCode.text success:^(NSDictionary *dic) {
            NSString *status = [dic objectForKey:@"status"];
            if ([status isEqualToString:@"OK"]) {
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册成功！" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"去登陆" style:(UIAlertActionStyleDefault) handler:nil];
                [alertC addAction:okaction];
                [MBProgressHUD hideHUDForView:self.view animated:YES];// 停止加载动画
                [self presentViewController:alertC animated:YES completion:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }else{
                [MBProgressHUD hideHUDForView:self.view animated:YES];// 停止加载动画
                NSString *error = [[dic objectForKey:@"data"] objectForKey:@"error"];
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:error preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
                [alertC addAction:okaction];
                [self presentViewController:alertC animated:YES completion:nil];
            }
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];// 停止加载动画
            NSLog(@"error = %@",error);
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"注册失败请重试！" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
            [alertC addAction:okaction];
            [self presentViewController:alertC animated:YES completion:nil];
        }];
        
        
        
    }
    
}

// 获取验证码
-(void)getCodeAction:(UIButton *)button{
    
    if (self.username.text.length == 0) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"手机号不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:nil];
        [alertC addAction:okaction];
        [self presentViewController:alertC animated:YES completion:nil];
    }else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[GetCodeRequest shareGetCodeRequest] getCodeRequestWithphoneNumber:self.username.text success:^(NSDictionary *dic) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            // NSString *status = [dic objectForKey:@"status"];
            NSString *result = [[dic objectForKey:@"data"] objectForKey:@"error"];
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:result preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:nil];
            [alertC addAction:okaction];
            [self presentViewController:alertC animated:YES completion:nil];
        } failure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSLog(@"error = %@",error);
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:@"网络超时,请检查网络" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
            [alertC addAction:okaction];
            [self presentViewController:alertC animated:YES completion:nil];
        }];
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
