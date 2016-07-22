//
//  FLClothModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface FLClothModel : BaseModel

//来自的俱乐部
@property (strong, nonatomic) NSString *club_title;
//俱乐部的头像
@property (strong, nonatomic) NSString *club_images;

//发帖人头像
@property (strong, nonatomic) NSString *headicon;
//发帖人
@property (strong, nonatomic) NSString *nickname;
//服装的标题
@property (strong, nonatomic) NSString *title;
//测评的衣服(数组中的属性 image)
@property (strong, nonatomic) NSArray *topic_image;
//创建帖子时间
@property (strong, nonatomic) NSString *createdate;
//活动的状态（是否还在进行,数值为，-1）
@property (assign, nonatomic) NSInteger is_jion;
//浏览的人数
@property (assign, nonatomic) NSInteger visits;

//点赞的人数
@property (strong, nonatomic) NSString *likeNum;


@end
