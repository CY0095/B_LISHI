//
//  ClothDetailViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ClothDetailViewController.h"
#import "ClothDetailTableViewCell.h"
#import "flClothRequest.h"
#import "FLClothModel.h"
#import "JoinStyleTableViewCell.h"
#import "JoinStyleModel.h"

@interface ClothDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic)UITableView *ClothDetailView;
@property (strong, nonatomic) NSMutableArray *clothArr;
//存放照片的字符串
@property (strong, nonatomic) NSString *pictureStr;
//存放活动的model
@property (strong, nonatomic) NSMutableArray *activityArr;
//添加点赞视图
@property (strong, nonatomic) UICollectionView *likeNumCollectionView;

@end

@implementation ClothDetailViewController

- (void)viewDidLoad {
[super viewDidLoad];

    self.clothArr = [NSMutableArray array];
    self.pictureStr = [NSString string];
    self.activityArr = [NSMutableArray array];

    //初始化TableView
    self.ClothDetailView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 64, WindownWidth, WindowHeight - 110))];
//    self.likeNumCollectionView = [[UICollectionView alloc] initWithFrame:(CGRectMake(0, self.ClothDetailView.bounds.size.height, WindownWidth, 80))];
    
    //设置代理
    self.ClothDetailView.delegate = self;
    self.ClothDetailView.dataSource = self;
//    self.likeNumCollectionView.delegate = self;
//    self.likeNumCollectionView.dataSource = self;
    
    //注册cell
    [self.ClothDetailView registerNib:[UINib nibWithNibName:@"ClothDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ClothDetailViewCell_Identify];
    //注册抽奖的cell
    [self.ClothDetailView registerNib:[UINib nibWithNibName:@"JoinStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:joinStyleViewCell_Identify];
    
    [self DataRequest];
    [self.view addSubview:self.ClothDetailView];
    self.view.backgroundColor = [UIColor cyanColor];
    
}

- (void)DataRequest
{
    FlClothRequest *request = [[FlClothRequest alloc] init];
    [request flClothRequestWithTopID:self.model.topicid userID:@"451724" sucess:^(NSDictionary *dic) {
        
        //发布帖子的model
        NSDictionary *event = [dic objectForKey:@"data"];
        
        FLClothModel *model = [[FLClothModel alloc] init];
        [model setValuesForKeysWithDictionary:event];
        [self.clothArr addObject:model];
        
        //解析照片的数组
        NSArray *event1 = [[dic objectForKey:@"data"] objectForKey:@"topic_image"];
        for (NSDictionary *tempDic in event1) {
            
            //取出数组中的照片
            self.pictureStr = [tempDic objectForKey:@"image"];
        }
        
        //参与活动的model
        NSDictionary *dict = [dic objectForKey:@"data"];
        JoinStyleModel *activityModel = [[JoinStyleModel alloc] init];
        [activityModel setValuesForKeysWithDictionary:dict];
        [self.activityArr addObject:activityModel];
    
        //刷新界面
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.ClothDetailView reloadData];
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.clothArr.count;
    }else{
        return self.activityArr.count;
    }
    
}

#pragma mark --- 设置cell ---
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        ClothDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ClothDetailViewCell_Identify];
        
        cell.model = self.clothArr[indexPath.row];
        [cell.clothImage setImageWithURL:[NSURL URLWithString:self.pictureStr]];
        
        return cell;
    }else
    {
        JoinStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:joinStyleViewCell_Identify];
        
        cell.model = self.activityArr[indexPath.row];
        
        return cell;
    }
    
}

#pragma mark --- 设置cell的高度 ---
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 451;
    }else{
        return 1583;
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
