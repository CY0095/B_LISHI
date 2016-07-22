//
//  SportClothModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface SportClothModel : BaseModel

//衣服详情的描述
@property (strong, nonatomic) NSString *ID;
//衣服de名称
@property (strong, nonatomic) NSString *title;
//衣服的照片
@property (strong, nonatomic) NSString *thumb;

@end
