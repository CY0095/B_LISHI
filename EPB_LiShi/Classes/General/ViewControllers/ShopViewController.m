//
//  ShopViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/26.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ShopViewController.h"
#import "ShopModel.h"
#import "ShopRequest.h"
#import "ShopTableViewCell.h"

@interface ShopViewController ()<UITableViewDelegate,UITableViewDataSource>

//存放商店的数组
@property (strong, nonatomic) NSMutableArray *shopDetailArr;
//商店的TableView
@property (strong, nonatomic) UITableView *shopTableView;

@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"店铺详情";
    
    //初始化数组
    self.shopDetailArr = [NSMutableArray array];
    
    //初始化TableView
    self.shopTableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 64, WindownWidth, WindowHeight))];
    //设置代理
    self.shopTableView.delegate = self;
    self.shopTableView.dataSource = self;
    //注册cell
    [self.shopTableView registerNib:[UINib nibWithNibName:@"ShopTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:shopRequest_Url];
    //添加视图
    [self.view addSubview:self.shopTableView];
    
    [self DataRequest];
    self.view.backgroundColor = [UIColor cyanColor];    
}

#pragma mark --- 请求数据 ---
- (void)DataRequest
{
    __weak typeof(self) weakself = self;
    ShopRequest *request = [[ShopRequest alloc] init];
    [request shopRequestWithBrand_id:self.model.brand_id sucess:^(NSDictionary *dic) {
        
        NSArray *event = [[dic objectForKey:@"data"] objectForKey:@"shoplist"];
        
        for (NSDictionary *tempDic in event) {
            
            ShopModel *model = [[ShopModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakself.shopDetailArr addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.shopTableView reloadData];
        });
        
//        NSLog(@"=== %@",weakself.shopDetailArr);
    } failure:^(NSError *error) {
        
        NSLog(@"fialure == %@",error);
    }];
}

#pragma mark --- 设置cell的行数 ---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"=== %lu",(unsigned long)self.shopDetailArr.count);
    return self.shopDetailArr.count;
}

#pragma mark --- 设置cell ---
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:shopRequest_Url];
    //取消点击cell的变色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ShopModel *model = self.shopDetailArr[indexPath.row];
    cell.model = model;
    NSLog(@"=== %@",cell.model);
    
    return cell;
}

#pragma mark --- 返回cell的高度 ---
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 102;
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
