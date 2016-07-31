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
#import "LikeNumCollectionViewCell.h"
#import "LikeListModel.h"
#import "AttentionDetailViewController.h"

@interface ClothDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic)UITableView *ClothDetailView;
@property (strong, nonatomic) NSMutableArray *clothArr;
//存放照片的字符串
@property (strong, nonatomic) NSString *pictureStr;
//存放活动的model
@property (strong, nonatomic) NSMutableArray *activityArr;
//添加点赞视图
@property (strong, nonatomic) UICollectionView *likeNumCollectionView;
//存放头像的数组
@property (strong, nonatomic) NSMutableArray *headImgArr;
//存放喜欢的人数
@property (strong, nonatomic) NSString *likeStr;

@end

@implementation ClothDetailViewController

- (void)viewDidLoad {
[super viewDidLoad];

    self.clothArr = [NSMutableArray array];
    self.pictureStr = [NSString string];
    self.activityArr = [NSMutableArray array];
    self.headImgArr = [NSMutableArray array];
    self.likeStr = [NSString string];

    //初始化TableView
    self.ClothDetailView = [[UITableView alloc] initWithFrame:(CGRectMake(0, 64, WindownWidth, WindowHeight - 110))];
    
    //设置代理
    self.ClothDetailView.delegate = self;
    self.ClothDetailView.dataSource = self;
    
    //注册cell
    [self.ClothDetailView registerNib:[UINib nibWithNibName:@"ClothDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ClothDetailViewCell_Identify];
    //注册抽奖的cell
    [self.ClothDetailView registerNib:[UINib nibWithNibName:@"JoinStyleTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:joinStyleViewCell_Identify];
    
    [self DataRequest];
    [self addCollectionView];
    [self.view addSubview:self.ClothDetailView];
    self.view.backgroundColor = [UIColor cyanColor];
    
}

#pragma mark --- 添加collectionView ---
- (void)addCollectionView
{
    //设置flowlayout
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置距离四边的距离
    flowLayout.sectionInset = UIEdgeInsetsMake(27, 68, 0, 0);
    //设置最小行间距
    flowLayout.minimumLineSpacing = 30;
    
    //初始化collectionView
    self.likeNumCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    //设置collectionView的背景颜色
    self.likeNumCollectionView.backgroundColor = [UIColor clearColor];
    
    //设置代理
    self.likeNumCollectionView.delegate = self;
    self.likeNumCollectionView.dataSource = self;
    
    //注册点赞的cell
    [self.likeNumCollectionView registerNib:[UINib nibWithNibName:@"LikeNumCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:likeNumViewCell_Identify];
    
    //设置视图
    UIView *v1 = [[UIView alloc] initWithFrame:(CGRectMake(0, 0, WindownWidth, 58))];
    UILabel *label = [[UILabel alloc] initWithFrame:(CGRectMake(8, 8, 61, 16))];
    label.text = [NSString stringWithFormat:@"%@人赞过",self.likeStr];
    label.textColor = [UIColor grayColor];
    label.font = [UIFont systemFontOfSize:13];
    
    UIImageView *img1 = [[UIImageView alloc] initWithFrame:(CGRectMake(14, 27, 23, 22))];
    img1.image = [UIImage imageNamed:@"点赞"];
    
    UIImageView *img2 = [[UIImageView alloc] initWithFrame:(CGRectMake(275, 27, 23, 22))];
    img2.image = [UIImage imageNamed:@"省略"];
    
    self.ClothDetailView.tableFooterView = v1;
    
    [v1 addSubview:img1];
    [v1 addSubview:img2];
    [v1 addSubview:label];
    [v1 addSubview:self.likeNumCollectionView];
}

#pragma mark --- 请求数据 ---
- (void)DataRequest
{
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    
    if (user_id.length == 0) {
        user_id = @"0";
    }
    __weak typeof(self) weakself = self;
    FlClothRequest *request = [[FlClothRequest alloc] init];
    [request flClothRequestWithTopID:self.model.topicid userID:user_id sucess:^(NSDictionary *dic) {
        
        //发布帖子的model
        NSDictionary *event = [dic objectForKey:@"data"];
        
        FLClothModel *model = [[FLClothModel alloc] init];
        [model setValuesForKeysWithDictionary:event];
        [weakself.clothArr addObject:model];
        
        //解析照片的数组
        NSArray *event1 = [[dic objectForKey:@"data"] objectForKey:@"topic_image"];
        for (NSDictionary *tempDic in event1) {
            
            //取出数组中的照片
            weakself.pictureStr = [tempDic objectForKey:@"image"];
        }
        
        //解析点赞头像的照片
        NSArray *event2 = [[dic objectForKey:@"data"] objectForKey:@"lists"];
        for (NSDictionary *tempDic in event2) {
            //取出头像图片
            LikeListModel *model = [[LikeListModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakself.headImgArr addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakself.likeNumCollectionView reloadData];
        });
        
        //参与活动的model
        NSDictionary *dict = [dic objectForKey:@"data"];
        JoinStyleModel *activityModel = [[JoinStyleModel alloc] init];
        [activityModel setValuesForKeysWithDictionary:dict];
        [weakself.activityArr addObject:activityModel];
    
        //刷新界面
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakself.ClothDetailView reloadData];
        });
        
    } failure:^(NSError *error) {
        
        NSLog(@"failure == %@",error);
    }];
}

#pragma mark --- 设置item分区数 ---
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark --- 设置item个数 ---
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.headImgArr.count - 5;
}

#pragma mark --- 设置每个item的大小 ---
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(22,23);
}

#pragma mark --- 设置item ---
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LikeNumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:likeNumViewCell_Identify forIndexPath:indexPath];
    
    LikeListModel *Emodel = self.headImgArr[indexPath.row];
    cell.model = Emodel;
    
    return cell;
}

#pragma mark --- 设置item之间的间距 ---
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 25;
}

#pragma mark --- 设置item的点击方法 ---
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AttentionDetailViewController *attenVC = [AttentionDetailViewController new];
    LikeListModel *model = self.headImgArr[indexPath.row];
    
    attenVC.uid = model.userID;
    
    [self.navigationController pushViewController:attenVC animated:YES];
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
        //取消点击cell变色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else
    {
        JoinStyleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:joinStyleViewCell_Identify];
        
        cell.model = self.activityArr[indexPath.row];
        //取消点击cell变色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
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
