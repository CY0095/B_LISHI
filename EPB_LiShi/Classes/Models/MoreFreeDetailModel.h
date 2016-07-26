//
//  MoreFreeDetailModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/23.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface MoreFreeDetailModel : BaseModel

//发布人的头像
@property (strong, nonatomic) NSString *headicon;
//发布人
@property (strong, nonatomic) NSString *nickname;
//回复的数量
@property (assign, nonatomic) NSInteger replytotal;
//发布的ID(界面的传值ID)
@property (strong, nonatomic) NSString *topic_id;
//发布的标题
@property (strong, nonatomic) NSString *topic_title;
//发布的配图
@property (strong, nonatomic) NSArray *topicimagelist;


@end
