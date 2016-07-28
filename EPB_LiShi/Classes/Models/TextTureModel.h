//
//  TextTureModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/25.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface TextTureModel : BaseModel

//国家
@property (strong, nonatomic) NSString *country_title;
//型号
@property (strong, nonatomic) NSString *model;
//面料
@property (strong, nonatomic) NSString *textturename;

//装备的面料
//@property (strong, nonatomic) NSString *textturename;

@end
