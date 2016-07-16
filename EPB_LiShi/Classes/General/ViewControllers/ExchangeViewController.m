//
//  ExchangeViewController.m
//  tools
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 杨旭东. All rights reserved.
//

#import "ExchangeViewController.h"
#import "ToolsTableViewCell.h"
#import "ExchangeRequest.h"

@interface ExchangeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *FLView;
@property (strong, nonatomic) IBOutlet UITableView *JFView;

@property (strong, nonatomic) NSMutableArray *JFArray;
@property (strong, nonatomic) NSMutableArray *FLArray;
@end

@implementation ExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.JFArray = [[NSMutableArray alloc] init];
    self.FLArray = [NSMutableArray array];
    
    //注册cell
    [self.FLView registerNib:[UINib nibWithNibName:@"ToolsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ToolsTableViewCell_Identify];
    [self.JFView registerNib:[UINib nibWithNibName:@"ToolsTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ToolsTableViewCell_Identify];
    
    [self setHeader];
    [self JFDataRequest];
    [self FLDataRequest];
    
}

#pragma mark --- 设置更多的点击事件 ---
- (void)btnClick:(UIButton *)btn
{
    NSLog(@"111111");
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

#pragma mark --- 请求积分商品 ---
- (void)JFDataRequest
{
    __weak typeof(self) weakself = self;
    ExchangeRequest *request = [[ExchangeRequest alloc] init];
    [request ExchangeRequestWithParameter:nil success:^(NSDictionary *dic) {
        
        NSArray *jf = [[dic objectForKey:@"data"] objectForKey:@"jfgoods"];
        for (NSDictionary *tempDic in jf) {
            //重组字典
            JFModel *model = [[JFModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakself.JFArray addObject:model];
        }
        
        NSArray *fl = [[dic objectForKey:@"data"] objectForKey:@"freegoods"];
        for (NSDictionary *tempDic in fl) {
            //重组字典
            FLModel *model = [[FLModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakself.FLArray addObject:model];
        }
        
//        NSLog(@"JFGoods == %@",weakself.JFArray);
        NSLog(@"JFGoods == %@",weakself.FLArray);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //刷新视图，显示数据
            [weakself.JFView reloadData];
            [weakself.FLView reloadData];
        });
        
    } failure:^(NSError *error) {
        
        NSLog(@"failure == %@",error);
    }];
}

- (void)FLDataRequest
{
    
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
        
        return cell;
    }else
    {
        ToolsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ToolsTableViewCell_Identify];
        
        JFModel *model = self.JFArray[indexPath.row];
        
        cell.jfmodel = model;
        
        return cell;
    }
}

#pragma mark --- 设置cell的高度 ---
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 126;
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
