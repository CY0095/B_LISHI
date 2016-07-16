//
//  DouBanTabBar.h
//  Lesson项目A_豆瓣
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 张鹏. All rights reserved.
//


#import <UIKit/UIKit.h>

@class LiShiTabBar;
@protocol DouBanTabBarDelegate <NSObject>

-(void)DouBanItemDidClicked:(LiShiTabBar *)tabBar;

@end

@interface LiShiTabBar : UITabBar
// 当前选中的tabbar的下标
@property(assign,nonatomic)int currentSelected;

// 当前选中的item
@property(strong,nonatomic)UIButton *currentSelectedItem;
// tabbat上面所有的item
@property(strong,nonatomic)NSArray *allItems;

@property(weak,nonatomic) id<DouBanTabBarDelegate>douBanDelegate;
// 初始化方法:根据items初始化items
-(id)initWithItems:(NSArray *)items frame:(CGRect)frame;

@end
