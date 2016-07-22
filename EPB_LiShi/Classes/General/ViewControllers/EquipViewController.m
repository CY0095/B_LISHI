//
//  EquipViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "EquipViewController.h"
#import "ToolsTableViewCell.h"
#import "ExchangeRequest.h"
#import "EquipTypeViewController.h"
#import "ClothDetailViewController.h"

@interface EquipViewController ()<UITableViewDelegate,UITableViewDataSource,toolDelegate>

@property (strong, nonatomic) UITableView *FLView;
@property (strong, nonatomic) UITableView *JFView;
@property (strong, nonatomic) UIScrollView *exchangeScrollView;
@property (strong, nonatomic) UIView *equipView;
@property (strong, nonatomic) UIView *shopView;

@property (strong, nonatomic) NSMutableArray *JFArray;
@property (strong, nonatomic) NSMutableArray *FLArray;

@end

@implementation EquipViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.JFArray = [[NSMutableArray alloc] init];
    self.FLArray = [NSMutableArray array];
    
    //要先初始化，再设置代理
    self.FLView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 153, WindownWidth, 490))];
    self.JFView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 653, WindownWidth, 365))];
    
    //设置代理
    self.FLView.delegate = self;
    self.FLView.dataSource = self;
    self.JFView.delegate = self;
    self.JFView.dataSource = self;
    
    //注册cell
    [self.FLView registerNib:[UINib nibWithNibName:@"ToolsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ToolsTableViewCell_Identify];
    [self.JFView registerNib:[UINib nibWithNibName:@"ToolsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ToolsTableViewCell_Identify];
    
    [self addView];
    [self setHeader];
    [self DataRequest];
    
    
}

#pragma mark --- 布局视图 ---
- (void)addView
{
    //头部视图
    self.equipView = [[UIView alloc] initWithFrame:CGRectMake(10, 74, (WindownWidth - 30) / 2, 65)];
    self.equipView.backgroundColor = [UIColor whiteColor];
    self.shopView = [[UIView alloc] initWithFrame:CGRectMake(20 + (WindownWidth - 30) / 2, 74, (WindownWidth - 30) / 2, 65)];
    self.shopView.backgroundColor = [UIColor whiteColor];
    //添加头部视图的内容
    //添加装备库
    UIImageView *img = [[UIImageView alloc] initWithFrame:(CGRectMake(8, 12, 41, 42))];
    img.image = [UIImage imageNamed:@"bag"];
    UILabel *label1 = [[UILabel alloc] initWithFrame:(CGRectMake(57, 8, self.equipView.bounds.size.width - 65, 32))];
    label1.text = @"装备库";
    label1.font = [UIFont systemFontOfSize:15];
    label1.textAlignment = NSTextAlignmentCenter;
    UILabel *label2 = [[UILabel alloc] initWithFrame:(CGRectMake(53, 39, self.equipView.bounds.size.width - 53, 25))];
    label2.text = @"性价比最高推荐";
    label2.font = [UIFont systemFontOfSize:12];
    label2.textAlignment = NSTextAlignmentCenter;
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(10, 74, (WindownWidth - 30) / 2, 65);
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.equipView addSubview:img];
    [self.equipView addSubview:label1];
    [self.equipView addSubview:label2];
    //添加户外商店
    UIImageView *img1 = [[UIImageView alloc] initWithFrame:(CGRectMake(8, 12, 41, 42))];
    img1.image = [UIImage imageNamed:@"32"];
    UILabel *label3 = [[UILabel alloc] initWithFrame:(CGRectMake(57, 8, self.shopView.bounds.size.width - 65, 32))];
    label3.text = @"户外店";
    label3.font = [UIFont systemFontOfSize:15];
    label3.textAlignment = NSTextAlignmentCenter;
    UILabel *label4 = [[UILabel alloc] initWithFrame:(CGRectMake(53, 39, self.shopView.bounds.size.width - 53, 25))];
    label4.text = @"你身边的户外店";
    label4.font = [UIFont systemFontOfSize:12];
    label4.textAlignment = NSTextAlignmentCenter;
    UIButton *btn1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn1.frame = CGRectMake(20 + (WindownWidth - 30) / 2, 74, (WindownWidth - 30) / 2, 65);
    btn1.backgroundColor = [UIColor clearColor];
    [btn1 addTarget:self action:@selector(btn1Click:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.shopView addSubview:img1];
    [self.shopView addSubview:label3];
    [self.shopView addSubview:label4];
    
    //添加scrollview
    self.exchangeScrollView = [[UIScrollView alloc] initWithFrame:(CGRectMake(0, 0, WindownWidth, WindowHeight))];
    self.exchangeScrollView.backgroundColor = [UIColor clearColor];
    self.exchangeScrollView.contentSize = CGSizeMake(WindownWidth, CGRectGetMaxY(self.JFView.frame) + 50);
    
    //添加视图
    
    [self.exchangeScrollView addSubview:self.shopView];
    [self.exchangeScrollView addSubview:self.equipView];
    [self.exchangeScrollView addSubview:self.FLView];
    [self.exchangeScrollView addSubview:self.JFView];
    [self.exchangeScrollView addSubview:btn];
    [self.exchangeScrollView addSubview:btn1];
    [self.view addSubview:self.exchangeScrollView];
}

#pragma mark --- 设置装备库的点击事件 ---
- (void)btnClick:(UIButton *)btn
{
    EquipTypeViewController *equipVC = [[EquipTypeViewController alloc] init];
    
    [self.navigationController pushViewController:equipVC animated:YES];
}

#pragma mark --- 设置户外店的点击事件 ---
- (void)btn1Click:(UIButton *)btn
{
    NSLog(@"222");
}

#pragma mark --- 设置头尾视图 ---
- (void)setHeader
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindownWidth, 60)];
    UIImageView *i = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    i.center = headView.center;
    i.image = [UIImage imageNamed:@"1"];
    [headView addSubview:i];
    self.FLView.tableHeaderView = headView;
    
    UIView *footView = [[UIView alloc] initWithFrame:(CGRectMake(0, 10, WindownWidth, 40))];
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(0, 0, 150, 30);
    [btn setTitle:@"更多免费装备" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor greenColor] forState:(UIControlStateNormal)];
    btn.center = footView.center;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIImageView *add = [[UIImageView alloc] initWithFrame:(CGRectMake((WindownWidth + btn.bounds.size.width) / 2, 22, 15, 15))];
    add.image = [UIImage imageNamed:@"箭头"];
    [footView addSubview:btn];
    [footView addSubview:add];
    self.FLView.tableFooterView = footView;
    
    UIView *headView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindownWidth, 50)];
    UIImageView *i1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    i1.center = headView1.center;
    i1.image = [UIImage imageNamed:@"2"];
    [headView1 addSubview:i1];
    self.JFView.tableHeaderView = headView1;
    
    UIView *footView1 = [[UIView alloc] initWithFrame:(CGRectMake(0, 10, WindownWidth, 60))];
    UIButton *btn1 = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn1.frame = CGRectMake(0, 0, 150, 30);
    [btn1 setTitle:@"更多换购装备" forState:(UIControlStateNormal)];
    [btn1 setTitleColor:[UIColor greenColor] forState:(UIControlStateNormal)];
    btn1.center = footView1.center;
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIImageView *add1 = [[UIImageView alloc] initWithFrame:(CGRectMake((WindownWidth + btn.bounds.size.width) / 2, 33, 15, 15))];
    add1.image = [UIImage imageNamed:@"箭头"];
    
    [footView1 addSubview:add1];
    [footView1 addSubview:btn1];
    self.JFView.tableFooterView = footView1;
}

#pragma mark --- 请求商品数据 ---
- (void)DataRequest
{
    __weak typeof(self) weakself = self;
    ExchangeRequest *request = [[ExchangeRequest alloc] init];
    [request ExchangeRequestWithParameter:nil success:^(NSDictionary *dic) {
        
        //请求积分商品
        NSArray *jf = [[dic objectForKey:@"data"] objectForKey:@"jfgoods"];
        for (NSDictionary *tempDic in jf) {
            //重组字典
            JFModel *model = [[JFModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakself.JFArray addObject:model];
        }
        
        //请求福利商品
        NSArray *fl = [[dic objectForKey:@"data"] objectForKey:@"freegoods"];
        for (NSDictionary *tempDic in fl) {
            //重组字典
            FLModel *model = [[FLModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakself.FLArray addObject:model];
        }
        
        //        NSLog(@"JFGoods == %@",weakself.JFArray);
        //        NSLog(@"JFGoods == %@",weakself.FLArray);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //刷新视图，显示数据
            [weakself.JFView reloadData];
            [weakself.FLView reloadData];
        });
        
    } failure:^(NSError *error) {
        
        NSLog(@"failure == %@",error);
    }];
}

#pragma mark --- 设置分区数 ---
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

#pragma mark --- 设置cell的行数 ---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.FLView) {
        return self.FLArray.count;
    }else {
        return self.JFArray.count;
    }
}

#pragma mark --- 设置cell ---
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.FLView) {
        ToolsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ToolsTableViewCell_Identify];
        
        FLModel *model1 = self.FLArray[indexPath.row];
        
        cell.flmodel = model1;
        //遵循点击button的代理
        cell.delegate = self;
        
        return cell;
    }else
    {
        ToolsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ToolsTableViewCell_Identify];
        
        JFModel *model = self.JFArray[indexPath.row];
        
        cell.jfmodel = model;
        //遵循点击button的代理
        cell.delegate = self;
        
        return cell;
    }
}

- (void)toolClickButton:(ToolsTableViewCell *)cell
{
    ClothDetailViewController *spVC = [ClothDetailViewController new];
    
    FLModel *model = cell.flmodel;
    spVC.model = model;
    
    [self.navigationController pushViewController:spVC animated:YES];
}

#pragma mark --- 设置cell的高度 ---
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 126;
}

#pragma mark --- 点击cell进行界面跳转 ---
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClothDetailViewController *clothVC = [[ClothDetailViewController alloc] init];
    
    FLModel *model = self.FLArray[indexPath.row];
    
    clothVC.model = model;
    
    [self.navigationController pushViewController:clothVC animated:YES];
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
