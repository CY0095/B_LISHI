//
//  activitySingle.h
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/29.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ActivityDetailModel.h"

@interface activitySingle : NSObject

@property (strong, nonatomic) NSMutableArray *activityArray;

+(instancetype)shareSingle;




// 打开数据库
-(void)openDataBase;
// 建表
-(void)creatTable;
// 关闭数据库
-(void)closeDataBase;
// 增

// 删除
-(void)deleteActivityWithUserID:(NSString *)UserID;
// 全查
-(NSArray *)selectFromStudent;
// 根据id查
-(NSMutableArray *)selectFromActivityWithID:(NSString *)userID;

-(void)insertActivityDEtailWithID:(NSString *)activityID title:(NSString *)title imagesString:(NSString *)imagesString user_id:(NSString *)user_id;


@end
