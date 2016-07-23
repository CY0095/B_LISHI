//
//  TopicsDetailModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface TopicsDetailModel : BaseModel
@property (strong, nonatomic) NSString *content;// 内容
@property (strong, nonatomic) NSString *images;// 图片
@property (assign, nonatomic) NSInteger images_height;
@property (assign, nonatomic) NSInteger images_width;
@property (strong, nonatomic) NSString *videoid;
@property (strong, nonatomic) NSString *videoimg;
@property (assign, nonatomic) NSInteger videoimg_height;
@property (assign, nonatomic) NSInteger videoimg_width;
@end
