//
//  EquipTypeViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/15.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "EquipTypeViewController.h"
#import "ToolsRequest.h"
#import "CatnameModel.h"
#import "ListModel.h"
#import "Sports_catesModel.h"
#import "SportList.h"
#import "EquipDetailViewController.h"
#import "SportClothViewController.h"

@interface EquipTypeViewController ()<UITableViewDataSource,UITableViewDelegate>

//设置装备类型View
@property (strong, nonatomic) UITableView *EquipTableView;
//设置运动方式View
@property (strong, nonatomic) UITableView *SportTableView;

//存储装备的的分类
@property (strong, nonatomic) NSMutableArray *CatNameArr;
//存储装备的种类
@property (strong, nonatomic) NSMutableArray *ListIdArr;
//存储装备名称
@property (strong, nonatomic) NSMutableDictionary *ListNameDic;
//存储运动的分类
@property (strong, nonatomic) NSMutableArray *SportNameArr;
//存储运动的种类
@property (strong, nonatomic) NSMutableArray *SportListArr;
//存储运动装备的名称
@property (strong, nonatomic) NSMutableDictionary *SportListNameDic;
//存储解析list的字典的数组
@property (strong, nonatomic) NSMutableArray *tempArray;

//设置两个视图
@property (strong, nonatomic)UIView *firstView;
@property (strong, nonatomic)UIView *secondView;

@end

//设置cell
static NSString *const cellReuseIdentifier = @"11";

@implementation EquipTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"装备分类";
    self.automaticallyAdjustsScrollViewInsets = YES;
    
    //初始化数组
    self.CatNameArr = [NSMutableArray array];
    self.ListIdArr = [NSMutableArray array];
    self.ListNameDic = [[NSMutableDictionary alloc] init];
    //初始化运动的数组
    self.SportNameArr = [NSMutableArray array];
    self.SportListNameDic = [[NSMutableDictionary alloc] init];
    self.SportListArr = [NSMutableArray array];
    self.tempArray = [NSMutableArray array];
    
    //设置TableView
    self.EquipTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 60, WindownWidth, WindowHeight - 60)];
    //设置sportView
    self.SportTableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 120, WindownWidth, WindowHeight - 169))];
    
    //设置代理
    self.EquipTableView.dataSource = self;
    self.EquipTableView.delegate = self;
    //设置sportView代理
    self.SportTableView.dataSource = self;
    self.SportTableView.delegate = self;
    
    //注册cell
    [self.EquipTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellReuseIdentifier];
    //注册SportViewCell
    [self.SportTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellReuseIdentifier];

    //请求数据调用的方法
    [self DataRequest];
    [self addView];
    
}

#pragma mark --- 设置头部视图及UISegmentedControl页面 ---
- (void)addView
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WindownWidth, 60)];
    headView.backgroundColor = [UIColor whiteColor];
    
    NSArray *array = @[@"装备类型",@"运动方式"];
    //初始化UISegmentedControl
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:array];
    seg.frame = CGRectMake(0,0,WindownWidth,60);
    
    //去掉颜色,现在整个segment都看不见(去掉边框颜色)
    seg.tintColor = [UIColor clearColor];
    
    //选择后的字体颜色（在NSDictionary中 可以添加背景颜色和字体的背景颜色）
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor greenColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:16],NSFontAttributeName,nil];
    [seg setTitleTextAttributes:dic forState:UIControlStateSelected];

    //未选择的字体颜色
    NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont boldSystemFontOfSize:16],NSFontAttributeName,nil];
    [seg setTitleTextAttributes:dic1 forState:UIControlStateNormal];
    
    //为分段控制器添加方法
    [seg addTarget:self action:@selector(changePage:) forControlEvents:(UIControlEventValueChanged)];
    
    //初始化视图
    self.firstView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.firstView.backgroundColor = [UIColor redColor];
    //默认添加第一个视图，并且显示在分段控制器的下面（第0个元素）
    [self.view insertSubview:self.firstView atIndex:0];
    
    self.secondView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.secondView.backgroundColor = [UIColor greenColor];
    
    //设置初始选择的界面
    seg.selectedSegmentIndex = 0;
    
    [headView addSubview:seg];
    [self.view addSubview:headView];
    //添加TableView到视图上
    [self.firstView addSubview:self.EquipTableView];
    [self.secondView addSubview:self.SportTableView];
}

#pragma mark --- 设置UISegmentedControl页面的跳转 ---
- (void)changePage:(UISegmentedControl *)seg
{
    //如果选择第二个界面
    if (seg.selectedSegmentIndex == 1) {
        //移除第一个界面
        [self.firstView removeFromSuperview];
        //插入第二个界面（下标为0，防止覆盖分段控制器）
        [self.view insertSubview:self.secondView atIndex:0];
    }else{
        //移除第二个界面
        [self.secondView removeFromSuperview];
        //插入第一个界面
        [self.view insertSubview:self.firstView atIndex:0];
    }
}

#pragma mark --- 请求服装类型数据 ---
- (void)DataRequest
{
    __weak typeof(self) weakself = self;
    ToolsRequest *request = [[ToolsRequest alloc] init];
    [request ToolsRequestWithParameter:nil success:^(NSDictionary *dic) {

        //请求运动方服装
        NSArray *event = [[dic objectForKey:@"data"] objectForKey:@"sports_cates"];
        for (NSDictionary *tempDic in event) {
            Sports_catesModel *model = [[Sports_catesModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakself.SportNameArr addObject:model.title];
            
            self.tempArray = @[].mutableCopy;
            for (NSDictionary *tempDic in model.list) {
                SportList *model = [[SportList alloc] init];
                [model setValuesForKeysWithDictionary:tempDic];
                [self.tempArray addObject:model];
            }
            
            [weakself.SportListNameDic setObject:self.tempArray forKey:model.title];
        }
        
        //请求普通装备类型
        NSArray *event1 = [[dic objectForKey:@"data"] objectForKey:@"cateList"];
        for (NSDictionary *tempDic in event1) {
            
            CatnameModel *model = [[CatnameModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakself.CatNameArr addObject:model.catname];
            
            NSMutableArray *tempArray = @[].mutableCopy;
            for (NSDictionary *tempDic in model.list) {
                ListModel *model = [ListModel new];
                [model setValuesForKeysWithDictionary:tempDic];
                [tempArray addObject:model];
            }
            [self.ListNameDic setObject:tempArray forKey:model.catname];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakself.EquipTableView reloadData];
            [weakself.SportTableView reloadData];
        });
        
//        NSLog(@"sportName == %@",weakself.SportNameArr);
    } failure:^(NSError *error) {
        
        NSLog(@"failure == %@",error);
    }];
    
}

#pragma mark --- 设置区数 ---
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.EquipTableView) {
        return self.CatNameArr.count;
    }else{
        
        return self.SportNameArr.count;
    }
    
}

#pragma mark --- 设置分区标题 ---
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView == self.EquipTableView) {
        
       return self.CatNameArr[section];
    }else{
        
        return self.SportNameArr[section];
    }
    
}

#pragma mark --- 设置行数 ---
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.EquipTableView) {
        
       return [self.ListNameDic[self.CatNameArr[section]] count];
    }else{
        
        return [self.SportListNameDic[self.SportNameArr[section]] count];
    }
    
}

#pragma mark --- 设置cell ---
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.EquipTableView) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
        
        ListModel *model = self.ListNameDic[self.CatNameArr[indexPath.section]][indexPath.row];
        cell.textLabel.text = model.catname;
        
        //设置cell上的箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //取消点击cell变色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
        
        Sports_catesModel *model = self.SportListNameDic[self.SportNameArr[indexPath.section]][indexPath.row];
        cell.textLabel.text = model.title;
        
        //设置cell上的箭头
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //取消点击cell变色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
}

#pragma mark --- 设置cell的点击方法 ---
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.EquipTableView) {
        
        EquipDetailViewController *detailVC = [[EquipDetailViewController alloc] init];
        
        ListModel *model = self.ListNameDic[self.CatNameArr[indexPath.section]][indexPath.row];
        
        detailVC.model = model;
        
        [self.navigationController pushViewController:detailVC animated:YES];
    }
    else if (tableView == self.SportTableView){
        
        SportClothViewController *sportVC = [[SportClothViewController alloc] init];
        
        SportList *model = self.SportListNameDic[self.SportNameArr[indexPath.section]][indexPath.row];
        
        sportVC.model = model;
        
        [self.navigationController pushViewController:sportVC animated:YES];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
