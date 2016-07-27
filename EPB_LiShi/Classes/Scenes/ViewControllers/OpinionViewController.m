//
//  OpinionViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/23.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "OpinionViewController.h"

@interface OpinionViewController ()
@property (weak, nonatomic) IBOutlet UITextField *OpinionTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (weak, nonatomic) IBOutlet UIButton *referBtn;

@end

@implementation OpinionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)referBtnAction:(id)sender {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"你说了也不见得有用,洗洗睡吧!" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"去洗澡" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertC addAction:okaction];
    [self presentViewController:alertC animated:YES completion:nil];

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
