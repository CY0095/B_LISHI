//
//  BuySportTabBar.m
//  LessonDouBan
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import "BuySportTabBar.h"

@implementation BuySportTabBar

#pragma mark --- 设置自定义的TabBar ---
-(id)initWithItems:(NSArray *)items frame:(CGRect)frame
{
    self = [super init];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor brownColor];
        for (int i = 0; i < items.count; i++) {
            UIButton *btn = (UIButton *)items[i];
            CGFloat width = self.bounds.size.width / items.count;
            CGFloat height = self.bounds.size.height;
            btn.frame = CGRectMake(i * width + 40, 3, 40, height - 30);
            [self addSubview:btn];
            
            //字体的大小
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            //字体居中
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            //未被选中时的情况
            [btn setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
            //设置title在button上的位置（上top，左left，下bottom，右right
            btn.titleEdgeInsets = UIEdgeInsetsMake(45, -btn.titleLabel.bounds.size.width, 0, 0);
            //设置button的内容横向居中。。设置content是title和image一起变化
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            
        }
        self.currentSelected = 0;
        self.currentSelectedItem = items[0];
        self.allItems = items;
    }
    return self;
}

@end
