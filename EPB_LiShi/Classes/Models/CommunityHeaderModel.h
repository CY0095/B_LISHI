//
//  CommunityHeaderModel.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BaseModel.h"

@interface CommunityHeaderModel : BaseModel
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  俱乐部id
 */
@property (nonatomic, copy) NSString *club_id;
/**
 *  俱乐部头像
 */
@property (nonatomic, copy) NSString *images;
/**
 *  版规
 */
@property (nonatomic, copy) NSString *descript;
/**
 *  成员数
 */
@property (nonatomic, assign) NSInteger members;
/**
 *  城市
 */
@property (nonatomic, copy) NSString *cityname;
/**
 *  类型
 */
@property (nonatomic, copy) NSString *catename;
/**
 *  创建时间
 */
@property (nonatomic, copy) NSString *createdate;
/**
 *  版主列表
 */
@property (nonatomic, copy) NSArray *moderator_list;
/**
 *  管理员列表
 */
@property (nonatomic, copy) NSArray *adminlist;


@end
