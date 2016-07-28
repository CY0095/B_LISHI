//
//  PostReplyViewCell.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/26.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostReplyModel.h"
#define PostReplyViewCell_Identify @"PostReplyViewCell_Identify"
@class PostReplyViewCell;
// 设置代理
@protocol PostReplyTableViewCellDelegate <NSObject>
-(void)PostReplyTableViewReplyBtnClicked:(PostReplyViewCell *)cell;
@end

@interface PostReplyViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *foolLabel;
@property (weak, nonatomic) IBOutlet UIView *replyView;
@property (weak, nonatomic) IBOutlet UILabel *reply_content;
@property (weak, nonatomic) IBOutlet UILabel *reply_fool;
@property (weak, nonatomic) IBOutlet UILabel *reply_nickname;
@property (weak, nonatomic) IBOutlet UIButton *huifuBtn;

// 回复评论所需要的数据
@property (strong, nonatomic) NSString *club_id;
@property (strong, nonatomic) NSString *replytopic_id;


@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) PostReplyModel *model;
@property (weak, nonatomic)id<PostReplyTableViewCellDelegate>delegate;

+(CGFloat)cellHeight:(PostReplyModel *)model;
@end
