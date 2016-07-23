//
//  ActivityModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface ActivityModel : BaseModel

// 图片
@property(strong,nonatomic) NSString *images;
// 地址
@property(strong,nonatomic) NSString *harddesc;
// 地址后面的字
@property(strong,nonatomic) NSString *catename;
// 标题
@property(strong,nonatomic) NSString *title;

@property(strong,nonatomic) NSString *ID;



@end
