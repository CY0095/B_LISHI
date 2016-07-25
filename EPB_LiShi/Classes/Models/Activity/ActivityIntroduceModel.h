//
//  ActivityIntroduceModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface ActivityIntroduceModel : BaseModel


@property(strong,nonatomic) NSString *content;

@property(strong,nonatomic) NSString *images;

// 集合时间
@property(strong,nonatomic) NSString *settime;
// 集合地点
@property(strong,nonatomic) NSString *setaddress;
// 联系方式
@property(strong,nonatomic) NSString *leadermobile;
// 建议装备
@property(strong,nonatomic) NSString *equipadvise;
// 费用说明
@property(strong,nonatomic) NSString *constdesc;
// 免责声明
@property(strong,nonatomic) NSString *disclaimer;
// 注意事项
@property(strong,nonatomic) NSString *catematter;


@end
