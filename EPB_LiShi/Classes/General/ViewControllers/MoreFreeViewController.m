//
//  MoreFreeViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/23.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "MoreFreeViewController.h"
#import "MoreFreeModel.h"
#import "MoreFreeRequest.h"
#import "MoreFreeTableViewCell.h"
#import "MoreFreeDetailModel.h"
#import "TopicImagelistModel.h"
#import "MoreFreeDetailTableViewCell.h"

@interface MoreFreeViewController ()<UITableViewDataSource,UITableViewDelegate,freeDelegate>

@property (strong, nonatomic) UITableView *moreFreeTableView;
//存放头视图的数组
@property (strong, nonatomic) NSMutableArray *firstArr;
//存放解析详情的数组
@property (strong, nonatomic) NSMutableArray *secondArr;
//存储三张照片的数组
@property (strong, nonatomic) NSMutableDictionary *thirdDic;

@end

@implementation MoreFreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数组
    self.firstArr = [NSMutableArray array];
    self.secondArr = [NSMutableArray array];
    self.thirdDic = [NSMutableDictionary dictionary];
    
    //初始化TableView
    self.moreFreeTableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 0, WindownWidth, WindowHeight))];
    //设置代理
    self.moreFreeTableView.delegate = self;
    self.moreFreeTableView.dataSource = self;
    
    
    //注册cell
    [self.moreFreeTableView registerNib:[UINib nibWithNibName:@"MoreFreeTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:moreFreeViewCell_Identify];
    [self.moreFreeTableView registerNib:[UINib nibWithNibName:@"MoreFreeDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:moreFreeClothDetailRequest_Url];
    
    //添加视图
    [self.view addSubview:self.moreFreeTableView];
    
    [self DataRequest];
    
    self.view.backgroundColor = [UIColor grayColor];
}

- (void)freeClickButton:(MoreFreeTableViewCell *)cell
{
    NSLog(@"111");
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark --- 请求数据 --- 
- (void)DataRequest
{
    __weak typeof(self) weakself = self;
    MoreFreeRequest *request = [[MoreFreeRequest alloc] init];
    
    [request moreFreeRequestWithTagID:@"6" sucess:^(NSDictionary *dic) {
        
        //将解析的model存入数组中
        MoreFreeModel *model = [[MoreFreeModel alloc] init];
        NSDictionary *dict = [[dic objectForKey:@"data"] objectForKey:@"taginfo"];
        [model setValuesForKeysWithDictionary:dict];
        [weakself.firstArr addObject:model];
        
        NSArray *event = [[dic objectForKey:@"data"] objectForKey:@"topiclist"];
        for (NSDictionary *tempDic in event) {
            MoreFreeDetailModel *model = [[MoreFreeDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakself.secondArr addObject:model];
        }
        
        //刷新数据，加载视图
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.moreFreeTableView reloadData];
        });
        
    } failure:^(NSError *error) {
       
        NSLog(@"failure == %@",error);
    }];
}

#pragma mark --- 设置分区数 ---
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

#pragma mark --- 设置行数 ---
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.firstArr.count;
    }else
    {
        return self.secondArr.count;
    }
    
}

#pragma mark --- 设置cell ---
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        MoreFreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moreFreeViewCell_Identify];
        
        MoreFreeModel *model = self.firstArr[indexPath.row];
        cell.model = model;
        
        //设置代理
        cell.delegate = self;
        
        //取消点击cell的变色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        
        MoreFreeDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:moreFreeClothDetailRequest_Url];
        
        MoreFreeDetailModel *model = self.secondArr[indexPath.row];
        cell.model = model;
        //取消点击cell的变色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSMutableArray *array1 = [NSMutableArray array];
        for (NSDictionary *tempDic in model.topicimagelist) {
            TopicImagelistModel *model = [[TopicImagelistModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            
            [array1 addObject:model.images];
           
        }
        
        [cell.img1 setImageWithURL:[NSURL URLWithString:array1[0]]];
        [cell.img2 setImageWithURL:[NSURL URLWithString:array1[1]]];
        [cell.img3 setImageWithURL:[NSURL URLWithString:array1[2]]];
        
        return cell;
    }
    
}

#pragma mark --- 设置cell的高度 ---
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 250;
    }else
    {
        return 205;
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
