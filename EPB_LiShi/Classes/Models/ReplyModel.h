//
//  ReplyModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface ReplyModel : BaseModel
@property (strong, nonatomic)NSString *nickname;
@property (strong, nonatomic)NSString *headicon;
@property (strong, nonatomic)NSString *reply_content;// 回复某某某的内容
@property (strong, nonatomic)NSString *content;// 评论内容
@property (strong, nonatomic)NSString *floor;
@property (strong, nonatomic)NSString *createtime;

@end
