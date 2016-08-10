//
//  OutDoorShopViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/27.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "OutDoorShopViewController.h"
#import "ShopModel.h"
#import "OutDoorShopRequest.h"
#import "ShopTableViewCell.h"
#import "ShopDetailViewController.h"

@interface OutDoorShopViewController ()<UITableViewDelegate,UITableViewDataSource>

//存放商店的数组
@property (strong, nonatomic) NSMutableArray *shopDetailArr;
//商店的TableView
@property (strong, nonatomic) UITableView *shopTableView;

@end

@implementation OutDoorShopViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.rootVC.LSTabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.rootVC.LSTabBar.hidden = NO;

    [GiFHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"店铺详情";
    
    //初始化数组
    self.shopDetailArr = [NSMutableArray array];
    
    //初始化TableView
    self.shopTableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 64, WindownWidth, WindowHeight - 64))];
    //设置代理
    self.shopTableView.delegate = self;
    self.shopTableView.dataSource = self;
    //注册cell
    [self.shopTableView registerNib:[UINib nibWithNibName:@"ShopTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:shopViewCell_Identify];
    //添加视图
    [self.view addSubview:self.shopTableView];
    
    [self DataRequest];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *like = [[NSUserDefaults standardUserDefaults] objectForKey:@"like"];
    
    NSLog(@"打印我的收藏 %@",like);
    
    //加载缓冲效果
    [GiFHUD setGifWithImageName:@"loading.gif"];
    [GiFHUD show];
}

#pragma mark --- 请求数据 ---
- (void)DataRequest
{
    __weak typeof(self) weakself = self;
    OutDoorShopRequest *request = [[OutDoorShopRequest alloc] init];
    [request outDoorShopRequestWithParameter:nil success:^(NSDictionary *dic) {
        
        NSArray *event = [[dic objectForKey:@"data"] objectForKey:@"shop"];
        for (NSDictionary *tempDic in event) {
            
            ShopModel *model = [[ShopModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakself.shopDetailArr addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.shopTableView reloadData];
            
            //取消效果
            [GiFHUD dismiss];
        });
        
        //        NSLog(@" === %@",weakself.shopDetailArr);
    } failure:^(NSError *error) {
        
        NSLog(@"failure == %@",error);
    }];
    
}

#pragma mark --- 设置cell的行数 ---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shopDetailArr.count;
}

#pragma mark --- 设置cell ---
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shopViewCell_Identify];
    //取消点击cell的变色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ShopModel *model = self.shopDetailArr[indexPath.row];
    cell.model = model;
    //显示距离
    CGFloat dis = model.distance / 1000;
    cell.distanceLabel.text = [NSString stringWithFormat:@"%.1fkm",dis];
    //显示星级
    if (model.star < 5) {
        cell.img5.image = [UIImage imageNamed:@"star1"];
    }else if (model.star < 4)
    {
        cell.img5.image = [UIImage imageNamed:@"star1"];
        cell.img4.image = [UIImage imageNamed:@"star1"];
    }else if (model.star < 3)
    {
        cell.img5.image = [UIImage imageNamed:@"star1"];
        cell.img4.image = [UIImage imageNamed:@"star1"];
        cell.img3.image = [UIImage imageNamed:@"star1"];
    }
    
    return cell;
}

#pragma mark --- 返回cell的高度 ---
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 102;
}

#pragma mark --- 点击cell跳转界面 ---
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopDetailViewController *shopVC = [[ShopDetailViewController alloc] init];
    
    ShopModel *model = self.shopDetailArr[indexPath.row];
    shopVC.model = model;
    
    [self.navigationController pushViewController:shopVC animated:YES];
    
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
