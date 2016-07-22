//
//  CommunityDetailModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface CommunityDetailModel : BaseModel

// 关注
@property (nonatomic, assign) BOOL attenStaus;
// 浏览数
@property (nonatomic, copy) NSString *browsenums;
// 俱乐部id
@property (nonatomic, copy) NSString *club_id;
// 俱乐部名称
@property (nonatomic, copy) NSString *club_title;
// 创建时间
@property (nonatomic, copy) NSString *createtime;
// 头像
@property (nonatomic, copy) NSString *headicon;
// 赞
@property (nonatomic, copy) NSString *likeNum;
// 点赞的用户
@property (nonatomic, copy) NSArray *likeuserlist;
// 昵称
@property (nonatomic, copy) NSString *nickname;
// 标题
@property (nonatomic, copy) NSString *title;
// 详情列表
@property (nonatomic, copy) NSArray *topicsdetaillist;
// 评论列表
@property (nonatomic, copy) NSArray *topicsreplylist;
// 分享标题
@property (nonatomic, copy) NSString *sharetxt;
// 分享链接
@property (nonatomic, copy) NSString *shareurl;
// id
@property (nonatomic, copy) NSString *topic_id;
// 发布者的user_id
@property (nonatomic, copy) NSString *user_id;



@end
