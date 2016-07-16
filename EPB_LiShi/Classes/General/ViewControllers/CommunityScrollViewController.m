//
//  CommunityScrollViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "CommunityScrollViewController.h"

#import "CommunityViewController.h"
#import "LuyingViewController.h"
#import "SheyingViewController.h"
#import "PandengViewController.h"
#import "ZhuangBeiKongViewController.h"
#import "HuwaifanViewController.h"


static CGFloat const labelW = 100;
static CGFloat const radio = 1.3;
#define WLScreenW [UIScreen mainScreen].bounds.size.width

@interface CommunityScrollViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UILabel *selLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *titleScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

@property (nonatomic, strong) NSMutableArray *titleLabels;


@end

@implementation CommunityScrollViewController

- (NSMutableArray *)titleLabels
{
    if (_titleLabels == nil) {
        _titleLabels = [NSMutableArray array];
    }
    return _titleLabels;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加所有子控制器
    [self setUpChildViewController];
    
    // iOS7会给导航控制器下所有的UIScrollView顶部添加额外滚动区域
    // 不想要添加
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    // 添加所有子控制器对应标题
    [self setUpTitleLabel];
    
    [self setUpScrollView];
}

// 初始化UIScrollView
- (void)setUpScrollView
{
    NSUInteger count = self.childViewControllers.count;
    self.titleScrollView.contentSize = CGSizeMake(count * labelW, 0);
    self.titleScrollView.showsHorizontalScrollIndicator = NO;
    
    // 设置内容滚动条
    self.contentScrollView.contentSize = CGSizeMake(count * WLScreenW, 0);
    // 开启分页
    self.contentScrollView.pagingEnabled = YES;
    // 没有弹簧效果
    self.contentScrollView.bounces = NO;
    // 隐藏水平滚动条
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
    
    self.contentScrollView.delegate = self;
}

-(void)setUpTitleLabel
{
    NSUInteger count = self.childViewControllers.count;
    
    CGFloat labelX = 0;
    CGFloat labelY = 0;
    CGFloat labelH = 44;
    
    
    for (int i = 0; i < count; i++) {
        // 获取对应子控制器
        UIViewController *vc = self.childViewControllers[i];
        
        // 创建label
        UILabel *label = [[UILabel alloc] init];
        
        
        labelX = i * labelW;
        
        // 设置尺寸
        label.frame = CGRectMake(labelX, labelY, labelW, labelH);
        
        // 设置label文字
        label.text = vc.title;
        
//        label.textColor = [UIColor grayColor];
        
        // 设置高亮文字颜色
        label.highlightedTextColor = [UIColor redColor];
        
        // 设置label的tag
        label.tag = i;
        
        
        // 设置用户的交互
        label.userInteractionEnabled = YES;
        
        // 文字居中
        label.textAlignment = NSTextAlignmentCenter;
        
        
        // 添加到titleLabels数组
        [self.titleLabels addObject:label];
        
        // 添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleClick:)];
        [label addGestureRecognizer:tap];
        
        // 默认选中第0个label
        if (i == 0) {
            [self titleClick:tap];
        }
        
        // 添加label到标题滚动条上
        [self.titleScrollView addSubview:label];
    }
}

// 点击标题的时候就会调用
- (void)titleClick:(UITapGestureRecognizer *)tap
{
    UILabel *label = (UILabel *)tap.view;
    
    [self selectView:label];
    
    
    NSInteger index = tap.view.tag;
    
    
    CGFloat offsetX = index * WLScreenW;
    self.contentScrollView.contentOffset = CGPointMake(offsetX, 0);
    
    [self showVc:index];
    
    [self setupTitleCenter:label];
}


-(void)showVc:(NSInteger)index
{
    CGFloat offsetX = index*WLScreenW;
    
    UIViewController *vc = self.childViewControllers[index];
    
    
    if (vc.isViewLoaded) {
        return;
    }
    
    vc.view.frame = CGRectMake(offsetX, 0, self.contentScrollView.bounds.size.width, self.contentScrollView.bounds.size.height);
    [self.contentScrollView addSubview:vc.view];
}


-(void)selectView:(UILabel *)label
{
    _selLabel.highlighted = NO;
    
    // 取消形变
    _selLabel.transform = CGAffineTransformIdentity;
    label.highlighted = YES;
    
    // 高大
    label.transform = CGAffineTransformMakeScale(radio, radio);
    // 颜色恢复
    _selLabel.textColor = [UIColor blackColor];
    _selLabel = label;
}

// 添加所有子控制器
- (void)setUpChildViewController
{
    CommunityViewController *TopVC = [[CommunityViewController alloc] init];
    TopVC.title = @"精选";
    [self addChildViewController:TopVC];
    
    LuyingViewController *LuyingVC = [[LuyingViewController alloc] init];
    LuyingVC.title = @"徒步露营";
    [self addChildViewController:LuyingVC];
    
    SheyingViewController *SheyingVC = [[SheyingViewController alloc] init];
    SheyingVC.title = @"户外摄影";
    [self addChildViewController:SheyingVC];
    
    PandengViewController *PandengVC = [[PandengViewController alloc] init];
    PandengVC.title = @"极限攀登";
    [self addChildViewController:PandengVC];
    
    ZhuangBeiKongViewController *zhuangbeiVC = [[ZhuangBeiKongViewController alloc] init];
    zhuangbeiVC.title = @"装备控";
    [self addChildViewController:zhuangbeiVC];
    
    HuwaifanViewController *HuwaiVC = [[HuwaifanViewController alloc] init];
    HuwaiVC.title = @"户外范";
    [self addChildViewController:HuwaiVC];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat curPage = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    // 左边label角标
    NSInteger leftIndex = curPage;
    // 右边的label角标
    NSInteger rightIndex = leftIndex + 1;
    
    
    // 获取左边的label
    UILabel *leftLabel = self.titleLabels[leftIndex];
    
    // 获取右边的label
    UILabel *rightLabel;
    if (rightIndex < self.titleLabels.count-1) {
        rightLabel = self.titleLabels[rightIndex];
    }
    
    CGFloat rightScale = curPage - leftIndex;
    CGFloat leftScale = 1- rightScale;
    
    // 左边缩放
    leftLabel.transform = CGAffineTransformMakeScale(leftScale * 0.3 + 1, leftScale * 0.3+ 1);
    
    // 右边缩放
    rightLabel.transform = CGAffineTransformMakeScale(rightScale * 0.3 + 1, rightScale * 0.3+ 1);
    
    
    // 设置文字颜色渐变
    /*
     R G B
     黑色 0 0 0
     红色 1 0 0
     */
    leftLabel.textColor = [UIColor colorWithRed:leftScale green:0 blue:0 alpha:1];
    rightLabel.textColor = [UIColor colorWithRed:rightScale green:0 blue:0 alpha:1];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    [self showVc:index];
    
    UILabel *selLabel = self.titleLabels[index];
    
    [self selectView:selLabel];
    
    [self setupTitleCenter:selLabel];
    
}

-(void)setupTitleCenter:(UILabel *)label
{
    CGFloat offsetX = label.center.x - WLScreenW * 0.5;
    if (offsetX<0) {
        offsetX = 0;
    }
    CGFloat maxOffsetX = self.titleScrollView.contentSize.width - WLScreenW;
    if (offsetX>maxOffsetX) {
        offsetX = maxOffsetX;
    }
    
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

@end
