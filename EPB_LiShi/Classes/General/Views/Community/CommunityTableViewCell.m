//
//  CommunityTableViewCell.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "CommunityTableViewCell.h"
#import "AttentionRequest.h"
#import "MBProgressHUD.h"
@implementation CommunityTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



//@property (weak, nonatomic) IBOutlet UILabel *replyNumLabel;

- (void)setModel:(CommunityListModel *)model {
    
    _model = model;
    if (model.attenStatus == 1) {
        self.attentionBtn.hidden = YES;
    }else{
        self.attentionBtn.titleLabel.text = @"+关注";
        self.attentionBtn.hidden = NO;
    }
    self.titleLabel.text = model.title;
    self.nicknameLabel.text = model.nickname;
    [self.headiconImg setImageWithURL:[NSURL URLWithString:model.headicon] placeholderImage:nil];
    [self.communityImg setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    self.replyNumLabel.text = [NSString stringWithFormat:@"%@则回复",model.reply_num];
    self.type = model.type;
    self.url = model.url;
    self.uid = model.user_id;
    self.attenState = model.attenStatus;
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
                NSLog(@"000");
                self.attentionBtn.titleLabel.text = @"已关注";
                self.attentionBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
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
