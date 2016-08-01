//
//  CommunityLuyingVideoCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/18.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "CommunityLuyingVideoCell.h"
#import "AttentionRequest.h"
@implementation CommunityLuyingVideoCell

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
    [self.videoimg setImageWithURL:[NSURL URLWithString:model.videoimg] placeholderImage:nil];
    self.update_time.text = model.update_time;
    self.videoid = model.videoid;
    self.likeNum.text = [NSString stringWithFormat:@"%ld",model.likeNum];
    self.uid = model.user_id;
}

- (IBAction)attentionAction:(UIButton *)sender {
    
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
                self.contentBtn.titleLabel.text = @"已关注";
                self.contentBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
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

@end
