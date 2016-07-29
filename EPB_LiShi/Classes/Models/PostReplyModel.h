//
//  PostReplyModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/26.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface PostReplyModel : BaseModel
@property (assign, nonatomic) BOOL is_image;// 是否附有image
@property (strong, nonatomic) NSString *replytopic_id;
@property (strong, nonatomic) NSString *user_id;
@property (strong, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSString *headicon;
@property (strong, nonatomic) NSArray *topic_image;
@property (strong, nonatomic) NSString *reply_id;
@property (strong, nonatomic) NSString *reply_floor;
@property (strong, nonatomic) NSString *reply_content;
@property (strong, nonatomic) NSString *reply_nickname;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *floor;
@property (strong, nonatomic) NSString *createdate;
@property (strong, nonatomic) NSString *club_id;

@end
