//
//  CommunityLuyingCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "CommunityLuyingCell.h"
#import "AttentionRequest.h"
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation CommunityLuyingCell

- (void)awakeFromNib {
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(LuyingListModel *)model {
    
    _model = model;
    [self.headiconImg setImageWithURL:[NSURL URLWithString:model.headicon] placeholderImage:nil];
    self.nicknameLabel.text = model.nickname;
    self.titleLabel.text = model.title;
    self.contentLabel.text = model.content;
    self.update_time.text = model.update_time;
    self.likeNum.text = [NSString stringWithFormat:@"%ld",model.likeNum];
    self.uid = model.user_id;
    NSArray *images = [NSArray arrayWithObjects:self.shareImg_0,self.shareImg_1,self.shareImg_2,self.shareImg_3,self.shareImg_4,self.shareImg_5, nil];
    for (int i = 0; i < model.images.count; i++) {
        
        [images[i] setImageWithURL:[NSURL URLWithString:[model.images[i] objectForKey:@"image"]] placeholderImage:nil];
        
    }
    
}
- (IBAction)attentionAction:(UIButton *)sender {
    
    NSLog(@"关注");
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    if (user_id) {
        [MBProgressHUD showHUDAddedTo:self.contentView animated:YES];
        [[AttentionRequest shareAttentionRequest] attentionRequestWithFromuid:user_id touid:self.uid success:^(NSDictionary *dic) {
            NSString *status = [dic objectForKey:@"status"];
            // NSString *error = [[dic objectForKey:@"data"] objectForKey:@"error"];
            if ([status isEqualToString:@"OK"]) {
                //                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:@"关注成功！" preferredStyle:(UIAlertControllerStyleAlert)];
                //                UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                //                    dispatch_async(dispatch_get_main_queue(), ^{
                //                        self.attentionBtn.hidden = YES;
                //                    });
                //                }];
                //                [alertC addAction:okaction];
                //                [self.contentView presentViewController:alertC animated:YES completion:nil];
                self.attentionBtn.titleLabel.text = @"已关注";
                
            }else{
                //                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:error preferredStyle:(UIAlertControllerStyleAlert)];
                //                UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
                //                [alertC addAction:okaction];
                //                [self presentViewController:alertC animated:YES completion:nil];
            }
        } failure:^(NSError *error) {
            //            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:@"连接超时！" preferredStyle:(UIAlertControllerStyleAlert)];
            //            UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
            //            [alertC addAction:okaction];
            //            [self presentViewController:alertC animated:YES completion:nil];
        }];
        [MBProgressHUD hideHUDForView:self.contentView animated:YES];
    }else{
        //        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:@"您还没有登录" preferredStyle:(UIAlertControllerStyleAlert)];
        //        UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
        //        [alertC addAction:okaction];
        //        [self presentViewController:alertC animated:YES completion:nil];
        
        
    }

}

//计算cell整体的高度
+ (CGFloat)cellHeight:(LuyingListModel *)model {
    
    // cell固定部分的高度（代指实际开发中不要自适应，有固定高度的控件和间隙所共同占有高度的总和）
    CGFloat staticHeight = 166;
    // cell不固定部分的高度（需要自适应，因内容而变换的控件的高度）
    CGFloat dynamicHeight = ((kScreenWidth - 40)/3.0)*2;
    // cell的高度等于固定的部分 + 变化的部分
    return staticHeight + dynamicHeight;
    
}

@end
