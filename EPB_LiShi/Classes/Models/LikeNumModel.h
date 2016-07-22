//
//  LikeNumModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/21.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface LikeNumModel : BaseModel

//点赞的人数
@property (assign, nonatomic) NSInteger likeNum;
//点赞的数组
@property (strong, nonatomic) NSArray *lists;

@end
