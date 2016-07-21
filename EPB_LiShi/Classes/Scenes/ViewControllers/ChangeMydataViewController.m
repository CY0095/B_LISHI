//
//  ChangeMydataViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ChangeMydataViewController.h"
#import "UpMydataRequest.h"
@interface ChangeMydataViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *headImg;

@property (weak, nonatomic) IBOutlet UITextField *nickNameText;
// 创建UIImagepickerController
@property(strong,nonatomic)UIImagePickerController *pickerController;
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

    // 为头像添加手势
    UITapGestureRecognizer *headTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeHeadImg)];
    //打开Img用户交互
    self.headImg.userInteractionEnabled = YES;
    // 添加手势
    [self.headImg addGestureRecognizer:headTap];
}
// 进入相册
-(void)changeHeadImg{
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    // 调用系统相机
    UIAlertAction *xiangjiAction = [UIAlertAction actionWithTitle:@"相机" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        // 判断选择的模式是否为相机模式,如果没有,则弹出警告
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.pickerController = [UIImagePickerController new];
            // 设置代理
            self.pickerController.delegate = self;
            
            // 设置相机模式
            self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:self.pickerController animated:YES completion:nil];
            });
            
        }else{
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"未检测到相机" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:OKAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
        
    }];
    
    // 进入相册
    UIAlertAction *xiangceAction = [UIAlertAction actionWithTitle:@"从相册中选取" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        self.pickerController = [UIImagePickerController new];
        self.pickerController.delegate = self;
        // 允许编辑图片
        self.pickerController.allowsEditing = YES;
        // 设置相册选完照片后,是否调到编辑模式,进行图片剪辑
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:self.pickerController animated:YES completion:nil];
        });
    }];
    // 取消
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
    [alertC addAction:xiangjiAction];
    [alertC addAction:xiangceAction];
    [alertC addAction:cancelAction];
    [self presentViewController:alertC animated:YES completion:nil];
    
    
    
}

// 代理方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = nil;
    // 判断一下我们从哪里获取图片
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        // 修改前的image
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
        
    }else{
        // 可编辑UIImagePickerControllerEditedImage(获取编辑后的图片)
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    }
    
    // 设置图片
    self.headImg.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    [self uploadingHeadImg];
    
}
// 上传头像方法
-(void)uploadingHeadImg{
    
    [[UpMydataRequest shareUpmyDataRequest] upMydataWithImage:self.headImg.image success:^(NSDictionary *dic) {
        NSString *status = [dic objectForKey:@"status"];
        if ([status isEqualToString:@"OK"]) {
            NSLog(@"img = %@",[[dic objectForKey:@"data"] objectForKey:@"img"]);
        }else{
            NSLog(@"dic = %@",dic);
        }
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
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
