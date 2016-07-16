//
//  RootViewController.m
//  Lesson项目A_豆瓣
//
//  Created by lanou3g on 16/6/28.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "RootViewController.h"



@interface RootViewController ()<DouBanTabBarDelegate>

@end


@implementation RootViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    // 隐藏系统的tabBar
    self.tabBar.hidden = YES;
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setImage:[UIImage imageNamed:@"community_Select"] forState:UIControlStateSelected];
    [btn1 setImage:[UIImage imageNamed:@"community"] forState:UIControlStateNormal];
    [btn1 setImageEdgeInsets:(UIEdgeInsetsMake(0, 10, 15, 0))];
    [btn1 setTitleEdgeInsets:UIEdgeInsetsMake(30, -49, 0, 0)];
    [btn1 setTitle:@"社区" forState:(UIControlStateNormal)];
    [btn1 setTitleColor:[UIColor colorWithRed:38.0/255 green:217.0/255 blue:165.0/255 alpha:1] forState:UIControlStateSelected];
    btn1.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn1 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [btn1 setSelected:YES];

    

    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setImage:[UIImage imageNamed:@"activity"] forState:UIControlStateSelected];
    [btn2 setImage:[UIImage imageNamed:@"activity_Select"] forState:UIControlStateNormal];
    [btn2 setImageEdgeInsets:(UIEdgeInsetsMake(0, 10, 15, 0))];
    [btn2 setTitleEdgeInsets:UIEdgeInsetsMake(30, -49, 0, 0)];
    [btn2 setTitle:@"活动" forState:(UIControlStateNormal)];
    [btn2 setTitleColor:[UIColor colorWithRed:38.0/255 green:217.0/255 blue:165.0/255 alpha:1] forState:UIControlStateSelected];
    btn2.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn2 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];



    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setImage:[UIImage imageNamed:@"equip_Select"] forState:UIControlStateSelected];
    [btn3 setImage:[UIImage imageNamed:@"equip"] forState:UIControlStateNormal];
    [btn3 setImageEdgeInsets:(UIEdgeInsetsMake(0, 10, 15, 0))];
    [btn3 setTitleEdgeInsets:UIEdgeInsetsMake(30, -49, 0, 0)];
    [btn3 setTitle:@"装备" forState:(UIControlStateNormal)];
    [btn3 setTitleColor:[UIColor colorWithRed:38.0/255 green:217.0/255 blue:165.0/255 alpha:1] forState:UIControlStateSelected];
    btn3.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn3 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];


    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn4 setImage:[UIImage imageNamed:@"My_Select"] forState:UIControlStateSelected];
    [btn4 setImage:[UIImage imageNamed:@"My"] forState:UIControlStateNormal];
    [btn4 setImageEdgeInsets:(UIEdgeInsetsMake(0, 10, 15, 0))];
    [btn4 setTitleEdgeInsets:UIEdgeInsetsMake(30, -49, 0, 0)];
    [btn4 setTitle:@"我的" forState:(UIControlStateNormal)];
    [btn4 setTitleColor:[UIColor colorWithRed:38.0/255 green:217.0/255 blue:165.0/255 alpha:1] forState:UIControlStateSelected];
    btn4.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn4 setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];


    
    self.LSTabBar = [[LiShiTabBar alloc] initWithItems:@[btn1,btn2,btn3,btn4] frame:CGRectMake(0,WindowHeight - 49, WindownWidth, 49)];
    [self.view addSubview:self.LSTabBar];
    self.LSTabBar.douBanDelegate = self;
}
-(void)DouBanItemDidClicked:(LiShiTabBar *)tabBar{
    self.selectedIndex = tabBar.currentSelected;
    
}

@end
