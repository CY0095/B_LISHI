//
//  BuySportTabBar.h
//  LessonDouBan
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

//定义一个代理方法
//@class BuySportTabBar;
//@protocol BuySportTabBarDelegate <NSObject>
//
//-(void)buySportItemDidClickde:(BuySportTabBar *)tabBar;
//
//@end

#import <UIKit/UIKit.h>

@interface BuySportTabBar : UITabBar

//当前选中的的tabBar的下标
@property(nonatomic, assign)int currentSelected;
//当前选中的item
@property(nonatomic, strong)UIButton *currentSelectedItem;
//tabBar上面所有的item
@property(nonatomic, strong)NSArray *allItems;

//定义一个初始化方法：根据items初始化items
-(id)initWithItems:(NSArray *)items frame:(CGRect)frame;

@end
