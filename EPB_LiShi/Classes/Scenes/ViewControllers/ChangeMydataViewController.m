//
//  ChangeMydataViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ChangeMydataViewController.h"
#import "UpMydataRequest.h"
@interface ChangeMydataViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *headImg;

@property (weak, nonatomic) IBOutlet UITextField *nickNameText;

@end

@implementation ChangeMydataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 为头像图片切圆角
    self.headImg.layer.cornerRadius = 50.0;
    self.headImg.layer.masksToBounds = YES;
    NSString *nickname = [[NSUserDefaults standardUserDefaults] objectForKey:@"nickname"];
    self.nickNameText.text = nickname;
    // 添加右按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:(UIBarButtonItemStyleDone) target:self action:@selector(saveMyData)];

}



// 保存个人资料方法
-(void)saveMyData{
    if (self.nickNameText.text.length == 0) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"昵称不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
        [alertC addAction:okaction];
    }else{
        NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
        [[UpMydataRequest shareUpmyDataRequest] upMydataWithNickname:self.nickNameText.text user_id:user_id success:^(NSDictionary *dic) {
            NSString *status = [dic objectForKey:@"status"];
            if ([status isEqualToString:@"ERR"]) {
                NSString *error = [[dic objectForKey:@"data"] objectForKey:@"error"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:error preferredStyle:(UIAlertControllerStyleAlert)];
                    UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
                    [alertC addAction:okaction];
                    [self presentViewController:alertC animated:YES completion:nil];
                });
                
            }else if ([status isEqualToString:@"OK"]){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSUserDefaults standardUserDefaults] setObject:self.nickNameText.text forKey:@"nickname"];
                    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"修改成功!" preferredStyle:(UIAlertControllerStyleAlert)];
                    UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
                    [alertC addAction:okaction];
                    [self presentViewController:alertC animated:YES completion:nil];
                    });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"修改失败，请重试!" preferredStyle:(UIAlertControllerStyleAlert)];
                    UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
                    [alertC addAction:okaction];
                    [self presentViewController:alertC animated:YES completion:nil];
                });
            }
        } failure:^(NSError *error) {
            NSLog(@"error = %@",error);
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"修改失败，请重试!" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
                [alertC addAction:okaction];
                [self presentViewController:alertC animated:YES completion:nil];
            });
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
