//
//  ReplyViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/27.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ReplyViewController.h"
#import "PostRequest.h"
@interface ReplyViewController ()<UITextViewDelegate>
@property (strong, nonatomic) UITextView *replyTextView;
@property (strong, nonatomic) UILabel *placehoderLabel;
@end
@implementation ReplyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.titleStr;
    [self drawView];
    [self addRightBarButton];
    
}
// 绘制UI
-(void)drawView{
    self.replyTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, WindownWidth, WindowHeight / 3)];
    self.replyTextView.delegate = self;
    self.replyTextView.font = [UIFont systemFontOfSize:17.0];
    [self.view addSubview:self.replyTextView];
    // 自定义placehoder,使用label代替 并初始化!
    self.placehoderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, self.replyTextView.bounds.size.width, 25)];
    // 想要显示的字体
    self.placehoderLabel.text = @"想说点什么......";
    // 字体大小和样式
    self.placehoderLabel.font = self.replyTextView.font;
    // 字体颜色
    self.placehoderLabel.textColor = [UIColor grayColor];
    // 将placehoderlabel的背景颜色去掉
    self.placehoderLabel.backgroundColor = [UIColor clearColor];
    // 添加到self.view
    [self.view addSubview:self.placehoderLabel];
}
// 添加回复按钮
-(void)addRightBarButton{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"回复" style:(UIBarButtonItemStyleDone) target:self action:@selector(replyAction:)];
    
}

#pragma mark ------ 回复方法
// 回复方法
-(void)replyAction:(UIBarButtonItem *)barButton{
    if (self.replyTextView.text.length == 0) {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:@"回复内容不能为空" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"好的" style:(UIAlertActionStyleDefault) handler:nil];
        [alertC addAction:okaction];
        [self presentViewController:alertC animated:YES completion:nil];
    }else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
        if (user_id) {
             [[PostRequest sharePostRequest] replyRequestWithUser_id:user_id club_id:self.club_id parentid:self.topic_id reply_id:self.replytopic_id content:self.replyTextView.text success:^(NSDictionary *dic) {
                 // 判断是否回复成功
                 if ([[dic objectForKey:@"status"] isEqualToString:@"OK"]) {
                     NSString *totpage = [[dic objectForKey:@"data"] objectForKey:@"totpage"];
                     NSLog(@"totpage = %@",totpage);
                     // 进入主线程执行
                     dispatch_async(dispatch_get_main_queue(), ^{
                         [MBProgressHUD hideHUDForView:self.view animated:YES];
                         UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:@"上传成功" preferredStyle:(UIAlertControllerStyleAlert)];
                         UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                             // 成功后跳出界面
                             [self.navigationController popViewControllerAnimated:YES];
                         }];
                         [alertC addAction:okaction];
                         [self presentViewController:alertC animated:YES completion:nil];
                     });
                 }else{
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:@"上传失败！" preferredStyle:(UIAlertControllerStyleAlert)];
                     UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
                     [alertC addAction:okaction];
                     [self presentViewController:alertC animated:YES completion:nil];
                 }
             } failure:^(NSError *error) {
                 [MBProgressHUD hideHUDForView:self.view animated:YES];
                 NSLog(@"error = %@",error);
                 UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:@"网络出错啦！" preferredStyle:(UIAlertControllerStyleAlert)];
                 UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
                 [alertC addAction:okaction];
                 [self presentViewController:alertC animated:YES completion:nil];
             }];
        }else{
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:@"您还没有登录呢" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:nil];
            [alertC addAction:okaction];
            [self presentViewController:alertC animated:YES completion:nil];
        }
    }
    
    
    
}
#pragma mark ------ textView 代理方法

// 开始编辑
-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    // 将要开始编辑的时候,将placehodderlabel的内容移除
    [self.placehoderLabel removeFromSuperview];
    NSLog(@"开始编辑");
}
// 即将结束编辑
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    NSLog(@"即将结束编辑");
    
    // 判断textView是否显示内容
    if (self.replyTextView.text.length == 0) {
        // 如果未输入文字,将placehodderlabel添加上去
        [self.view addSubview:self.placehoderLabel];
    }
    
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based applicati on, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
