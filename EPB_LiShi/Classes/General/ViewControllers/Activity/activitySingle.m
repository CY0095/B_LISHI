//
//  activitySingle.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/29.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "activitySingle.h"
#import "ActivityApplyModel.h"
static activitySingle *activity = nil;
@implementation activitySingle

+(instancetype)shareSingle{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        activity = [[self alloc] init];
        activity.activityArray = [NSMutableArray array];
    });
    
    return activity;
}


// 创建唯一的数据库指针
static sqlite3 *db = nil;


-(void)openDataBase{
    // 如果数据库指针有值，即数据可已经被打开，那么不做任何操作。
    if (db) {
        return;// return以后的代码不执行
    }
    // 获取DocumentDirectory文件夹
    NSString *dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    // 写入文件
    dbPath = [dbPath stringByAppendingPathComponent:@"activity.sqlite"];
    // 打开数据库
    // 此操作不仅仅是打开数据库，同时也会判断数据库文件是否存在，如果不存在那么会创建一个文件并打开
    int result = sqlite3_open(dbPath.UTF8String, &db);
    
    if (result == SQLITE_OK) {// 这个OK代表上句代码实现成功
        NSLog(@"打开数据库成功");
    }else{
        NSLog(@"打开数据库失败，错误代码为%d",result);
    }
}

// 建表
-(void)creatTable{
    
    NSString *creatTableSQLWord = @"CREATE TABLE IF NOT EXISTS 'activity' ('id' TEXT PRIMARY KEY NOT NULL, 'title' TEXT NOT NULL, 'imageString' TEXT NOT NULL,'user_id' TEXT NOT NULL)";
    
    // 执行语句
    int result = sqlite3_exec(db, creatTableSQLWord.UTF8String, NULL, NULL, NULL);
    if (result == SQLITE_OK) {
        NSLog(@"建表成功");
    }else{
        NSLog(@"建表失败");
    }
}

// 关闭数据库
-(void)closeDataBase{
    
    if (!db) {
        return;
    }
    
    int result = sqlite3_close(db);
    
    if (result == SQLITE_OK) {
        NSLog(@"关闭数据库成功");
        db = nil; // 成功后将数据库指针置为nil
    }else{
        
        NSLog(@"关闭数据库失败，错误代码为%d",result);
    }
}

#pragma 增

-(void)insertActivityDEtailWithID:(NSString *)activityID title:(NSString *)title imagesString:(NSString *)imagesString user_id:(NSString *)user_id{
    
    // 准备SQL语句
    NSString *insertSQLWord = [NSString stringWithFormat:@"insert into 'activity' ('id','title','imageString','user_id') values ('%@','%@','%@','%@')",activityID,title,imagesString,user_id];
    
    int result = sqlite3_exec(db, insertSQLWord.UTF8String, NULL, NULL, NULL);
    
    if (result == SQLITE_OK) {
        NSLog(@"插入数据成功");
    }else{
        NSLog(@"插入数据失败，失败代码为%d",result);
    }
    
    
    
    
}




#pragma 删
-(void)deleteActivityWithUserID:(NSString *)UserID{
    
    NSString *deleteSQLWord = [NSString stringWithFormat:@"delete from activity where id = %@",UserID];
    int result = sqlite3_exec(db, deleteSQLWord.UTF8String, NULL, NULL, NULL);
    
    if (result == SQLITE_OK) {
        NSLog(@"删除数据成功");
    }else{
        NSLog(@"删除数据失败，错误代码为%d",result);
    }
}

#pragma 查

-(NSArray *)selectFromStudent{
    
    NSMutableArray *array = nil;
    
    sqlite3_stmt *stmt = nil;
    
    NSString *selectSQLWord = @"select *from activity";
    
    int result = sqlite3_prepare(db, selectSQLWord.UTF8String, -1, &stmt, NULL);
    
    if (result == SQLITE_OK) {
        array = [NSMutableArray new];
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            ActivityApplyModel *model = [ActivityApplyModel new];
            model.activityID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            model.activityTitle = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            
            model.imageStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            model.user_id = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
            [array addObject:model];
        }
    }
    sqlite3_finalize(stmt);
    return array;
}


-(NSMutableArray *)selectFromActivityWithID:(NSString *)userID{
    
    NSMutableArray *array = nil;
    
    sqlite3_stmt *stmt = nil;
    
    NSString *selectSQLWord = [NSString stringWithFormat:@"select *from activity where user_id = '%@'",userID];
    
    int result = sqlite3_prepare(db, selectSQLWord.UTF8String, -1, &stmt, NULL);
    
    if (result == SQLITE_OK) {
        array = [NSMutableArray new];
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            ActivityApplyModel *model = [ActivityApplyModel new];
            model.activityID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
            model.activityTitle = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            model.imageStr = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
            model.user_id = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 3)];
             [array addObject:model];
        }
    }
    sqlite3_finalize(stmt);
    return array;
    
    
    
}


















@end
