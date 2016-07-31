//
//  BuySportViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/25.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "BuySportViewController.h"
#import "BuySportModel.h"
#import "BuySportRequest.h"
#import "BuySportTableViewCell.h"
#import "BuySportPicTableViewCell.h"
#import "TextTureModel.h"
#import "zhuangBeiPicModel.h"
#import "BuySportTabBar.h"
#import "ShopViewController.h"
#import "SportClothViewController.h"
#import "SportPicTableViewCell.h"

@interface BuySportViewController ()<UITableViewDataSource,UITableViewDelegate,buySportDelegate,shareSportDelegate>

@property (strong, nonatomic) UITableView *buySportTableView;
//存放购买衣服的详情
@property (strong, nonatomic) NSMutableArray *buySportArr;
//存放衣服简介数组
@property (strong, nonatomic) NSMutableArray *buySportBriefArr;
//存放简介照片的数组
@property (strong, nonatomic) NSMutableArray *buySportPicArr;
//设置自定的tabBar
@property (strong, nonatomic) BuySportTabBar *sportTabBar;
//取出解析的字典
@property (strong, nonatomic) NSMutableDictionary *sportDic;
//照片的数组
@property (strong, nonatomic) NSMutableArray *sportPicArr;

@end

@implementation BuySportViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.rootVC.LSTabBar.hidden = YES;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.rootVC.LSTabBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化数组
    self.buySportArr = [NSMutableArray array];
    self.buySportBriefArr = [NSMutableArray array];
    self.buySportPicArr = [NSMutableArray array];
    self.sportDic = [NSMutableDictionary dictionary];
    self.sportPicArr = [NSMutableArray array];
    
    //初始化TableView
    self.buySportTableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, WindownWidth, WindowHeight - 40))];
    //设置代理
    self.buySportTableView.delegate = self;
    self.buySportTableView.dataSource = self;
    
    //注册cell
    [self.buySportTableView registerNib:[UINib nibWithNibName:@"BuySportTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:buySportViewCell_Identify];
    [self.buySportTableView registerNib:[UINib nibWithNibName:@"BuySportPicTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:buySportPicViewCell_Identify];
    [self.buySportTableView registerNib:[UINib nibWithNibName:@"SportPicTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:sportPicViewCell_Identify];
    
    //添加视图
    [self.view addSubview:self.buySportTableView];
    
    [self DataRequest];
    [self AddTabBar];
    
}

#pragma mark --- 设置TabBar ---
- (void)AddTabBar
{
    //设置button1
    UIButton *btn1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //普通状态下的图片
    [btn1 setBackgroundImage:[UIImage imageNamed:@"购物车"] forState:(UIControlStateNormal)];
    //设置btn的标题
    [btn1 setTitle:@"在哪买" forState:(UIControlStateNormal)];
    //设置默认
    btn1.selected = YES;
    //添加btn的点击方法
    [btn1 addTarget:self action:@selector(btn1Click:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    //设置button2
    UIButton *btn2 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //普通状态下的图片
    [btn2 setBackgroundImage:[UIImage imageNamed:@"回复"] forState:(UIControlStateNormal)];
    //设置btn的标题
    [btn2 setTitle:@"评论" forState:(UIControlStateNormal)];
    
    
    //设置button3
    UIButton *btn3 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //普通状态下的图片
    [btn3 setBackgroundImage:[UIImage imageNamed:@"喜欢"] forState:(UIControlStateNormal)];
    //设置btn的标题
    [btn3 setTitle:@"收藏" forState:(UIControlStateNormal)];
    //设置btn的点击事件
    [btn3 addTarget:self action:@selector(btn3Click:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.sportTabBar = [[BuySportTabBar alloc] initWithItems:@[btn1,btn2,btn3] frame:(CGRectMake(0, WindowHeight - 49, self.view.bounds.size.width, 57))];
    
    [self.view addSubview:self.sportTabBar];
    
}

#pragma mark --- btn1的点击方法 ---
- (void)btn1Click:(UIButton *)btn
{
    ShopViewController *shopVC = [[ShopViewController alloc] init];
    
    shopVC.model = self.buySportArr[0];

    [self.navigationController pushViewController:shopVC animated:YES];
}

#pragma mark --- btn3的点击方法 ---
- (void)btn3Click:(UIButton *)btn
{
    [btn setBackgroundImage:[UIImage imageNamed:@"喜欢1"] forState:(UIControlStateNormal)];
}

#pragma mark --- 请求数据 ---
- (void)DataRequest
{
    __weak typeof(self) weakself = self;
    BuySportRequest *request = [[BuySportRequest alloc] init];
    [request buySportClothRequestWithParameter:@{@"id":self.model.ID} sucess:^(NSDictionary *dic) {
        
        //获取第一个cell的model
        NSDictionary *dict = [[dic objectForKey:@"data"] objectForKey:@"info"];
        BuySportModel *model = [[BuySportModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [weakself.buySportArr addObject:model];
        [weakself.sportDic setValuesForKeysWithDictionary:dict];
        
        NSLog(@" == %@",weakself.buySportArr);
        
        //获取第二个cell的model
        NSDictionary *dict1 = [[[dic objectForKey:@"data"] objectForKey:@"info"] objectForKey:@"texture"];
        TextTureModel *model1 = [[TextTureModel alloc] init];
        [model1 setValuesForKeysWithDictionary:dict1];
        [weakself.buySportBriefArr addObject:model1];
        
        //取出照片的cell
        NSArray *event = [[[dic objectForKey:@"data"] objectForKey:@"info"] objectForKey:@"zhuangbeiimg"];
        for (NSDictionary *tempDic in event) {
            
           zhuangBeiPicModel *model2 = [[zhuangBeiPicModel alloc] init];
            [model2 setValuesForKeysWithDictionary:tempDic];
            [weakself.sportPicArr addObject:model2];
        }

        //刷新数据
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakself.buySportTableView reloadData];
        });
        
    } failure:^(NSError *error) {
        
        NSLog(@"failure == %@",error);
    }];
}

#pragma mark --- 设置分区数 ---
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
#pragma mark --- 设置行数 ---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
       return self.buySportArr.count;
    }else if (section == 1)
    {
        return self.buySportBriefArr.count;
    }else
    {
        return self.sportPicArr.count;
    }
}

#pragma mark --- 设置cell ---
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        BuySportTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:buySportViewCell_Identify];
        
        BuySportModel *model = self.buySportArr[indexPath.row];
        cell.model = model;
        //设置点击button的代理
        cell.delegate = self;
        cell.shareDelegate = self;
        //取消点击cell变色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.section == 1)
    {
        BuySportPicTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:buySportPicViewCell_Identify];
        
        TextTureModel *model = self.buySportBriefArr[indexPath.row];
        cell.countryLabel.text = model.country_title;
        cell.clothLabel.text = model.textturename;
        cell.typeLabel.text = model.model;
        
        //取消点击cell变色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else{
        
        SportPicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sportPicViewCell_Identify];
        
        zhuangBeiPicModel *model = self.sportPicArr[indexPath.row];
        
        cell.model = model;
        
        //取消点击cell变色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    

    
}

#pragma mark --- 设置点击代理返回button的方法 ---
- (void)backButtonClick:(BuySportTableViewCell *)cell
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --- 设置点击代理分享button的方法 ---
- (void)shareButtonClick:(BuySportTableViewCell *)cell
{
    NSLog(@"分享的点击");
}

#pragma mark --- 返回高度 ---
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 400;
    }else if (indexPath.section == 1)
    {
        return 166;
    }else{
//        zhuangBeiPicModel *model = self.sportPicArr[indexPath.row];
//        return model.height;
        
        return 350;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
