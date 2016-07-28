//
//  PostMessageViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/28.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "PostMessageViewController.h"
#import "PostRequest.h"
@interface PostMessageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UIImageView *postImg;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *addImgBtn;

// 创建UIImagepickerController
@property(strong,nonatomic)UIImagePickerController *pickerController;
@end

@implementation PostMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:(UIBarButtonItemStyleDone) target:self action:@selector(postMessageAction)];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rootVC.LSTabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.rootVC.LSTabBar.hidden = NO;
}
// 发布信息
-(void)postMessageAction{
    if (self.titleTextField.text.length > 0 && self.contentTextView.text.length > 0) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
        UIImage *image = [UIImage imageNamed:@"zhuangbei.jpg"];
        [[PostRequest sharePostRequest] postMessageRequestWithUser_id:user_id content:self.contentTextView.text title:self.titleTextField.text image:image success:^(NSDictionary *dic) {
            NSString *status = [dic objectForKey:@"status"];
            if ([status isEqualToString:@"OK"]) {
                NSString *topics_id = [[dic objectForKey:@"data"] objectForKey:@"topics_id"];
                NSLog(@"topics_id = %@",topics_id);
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:@"发布成功!" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    // 在主线程执行
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                }];
                [alertC addAction:okaction];
                [self presentViewController:alertC animated:YES completion:nil];
        
            }else{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                NSLog(@"%@",dic);
            }
        } failure:^(NSError *error) {
            NSLog(@"error = %@",error);
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
        
    }else{
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"标题不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
        [alertC addAction:okaction];
        [self presentViewController:alertC animated:YES completion:nil];
    }
    
    
}

// 添加图片按钮
- (IBAction)addImgBtnAction:(id)sender {
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
    self.postImg.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
