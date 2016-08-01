//
//  ActivityDetailModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface ActivityDetailModel : BaseModel


// 标题
@property(strong,nonatomic) NSString *title;
// 活动id
@property(strong,nonatomic) NSString *activity_id;
// 活动批次
@property(assign,nonatomic) NSInteger batch_total;
// 活动经费
@property(strong,nonatomic) NSString *consts;
// 活动亮点
@property(strong,nonatomic) NSArray *activelightspot;
// 组织者id
@property(strong,nonatomic) NSString *leader_userid;
// 组织者姓名
@property(strong,nonatomic) NSString *leadernickname;
// 组织者头像
@property(strong,nonatomic) NSString *leaderheadicon;
// 组织标签
@property(strong,nonatomic) NSArray *leaderdesc;
// 下面照片存在的数组(具体行程)
@property(strong,nonatomic) NSArray *tripdetail;
// 起止时间到结束时间
@property(strong,nonatomic) NSString *activitytimes;
// 俱乐部
@property(strong,nonatomic) NSString *club_title;
// 俱乐部id
@property(strong,nonatomic) NSString *club_id;

@property(strong,nonatomic) NSArray *activitydetail;


// 具体行程页面
// 集合时间
@property(strong,nonatomic) NSString *settime;
// 集合地点
@property(strong,nonatomic) NSString *setaddress;
// 联系方式
@property(strong,nonatomic) NSString *leadermobile;
// 具体行程

// 建议装备
@property(strong,nonatomic) NSString *equipadvise;
// 费用说明
@property(strong,nonatomic) NSString *constdesc;
// 免责声明
@property(strong,nonatomic) NSString *disclaimer;
// 注意事项
@property(strong,nonatomic) NSString *catematter;


// 地图
@property(strong,nonatomic) NSString *gaodlongitude;
@property(strong,nonatomic) NSString *gaodelatitude;




@end
