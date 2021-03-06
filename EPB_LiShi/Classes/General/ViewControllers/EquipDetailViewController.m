//
//  EquipDetailViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "EquipDetailViewController.h"
#import "EquipDetailRequest.h"
#import "EquipDetailModel.h"
#import "EquipDetailCollectionViewCell.h"
#import "BuyEquipViewController.h"
#import "MJRefresh.h"

@interface EquipDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSMutableArray *detailArr;

@property (strong, nonatomic) UICollectionView *equipDetailView;

@property (assign, nonatomic) NSInteger number;

@end

//重用标识符
static NSString *const cellResueID = @"111";

@implementation EquipDetailViewController

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
    
    self.number = 0;
    
    self.title = self.model.catname;
    
    self.detailArr = [NSMutableArray array];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置距离四边的距离
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    //初始化collection
    self.equipDetailView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, WindownWidth, self.view.bounds.size.height - 64) collectionViewLayout:flowLayout];

    //注册自定义cell
    [self.equipDetailView registerNib:[UINib nibWithNibName:@"EquipDetailCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:EquipDetailViewCell_Identify];
    
    //设置代理
    self.equipDetailView.delegate = self;
    self.equipDetailView.dataSource = self;
    
    [self DataRequest];
    [self.view addSubview:self.equipDetailView];
    self.equipDetailView.backgroundColor = [UIColor grayColor];
    self.view.backgroundColor = [UIColor purpleColor];
    
    //加载效果
    [GiFHUD setGifWithImageName:@"loading.gif"];
    [GiFHUD show];
    
    //创建下拉刷新
    MJRefreshNormalHeader* header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self performSelector:@selector(headRefresh)withObject:nil afterDelay:2.0f];
        
    }];
    
    //设置自定义文字，因为默认是英文的
    [header setTitle:@"下拉刷新"forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开加载更多"forState:MJRefreshStatePulling];
    
    [header setTitle:@"正在刷新中"forState:MJRefreshStateRefreshing];
    
    
    self.equipDetailView.mj_header= header;
    
    //创建上拉刷新
    MJRefreshBackNormalFooter * foot =[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self performSelector:@selector(footRefresh)withObject:nil afterDelay:2.0f];
        
    }];
    self.equipDetailView.mj_footer= foot;
    
    [foot setTitle:@"上拉刷新"forState:MJRefreshStateIdle];
    
    [foot setTitle:@"松开加载更多"forState:MJRefreshStatePulling];
    
    [foot setTitle:@"正在刷新中"forState:MJRefreshStateRefreshing];
    
    
}

#pragma mark --- 下拉刷新 ---
- (void)headRefresh {
    NSLog(@"下拉,加载数据");
    self.number ++;
    [self.equipDetailView.mj_header endRefreshing];
}

#pragma mark --- 上拉刷新 ---
- (void)footRefresh {
    NSLog(@"上拉，加载数据");
    self.number ++;
    [self DataRequest];
    [self.equipDetailView.mj_footer endRefreshing];
}

#pragma mark --- 请求数据 ---
- (void)DataRequest
{
    __weak typeof(self) weakself = self;
    EquipDetailRequest *request = [[EquipDetailRequest alloc] init];
    [request equipDetailRequestWithNumber:[NSString stringWithFormat:@"%ld",(long)self.number] Parameter:@{@"id":self.model.ID} sucess:^(NSDictionary *dic) {
        
        NSArray *event = [dic objectForKey:@"data"];
        for (NSDictionary *tempDic in event) {
            EquipDetailModel *model = [[EquipDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakself.detailArr addObject:model];
        }
        
        //        NSLog(@"请求装备的ID == %@",self.detailArr);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakself.equipDetailView reloadData];
            
            //取消效果
            [GiFHUD dismiss];
        });
        
    } failure:^(NSError *error) {
        NSLog(@"failure == %@",error);
    }];
}

#pragma mark --- 设置分区个数 ---
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

#pragma mark --- 设置item的个数 ---
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.detailArr.count;
}

#pragma mark --- 设置item的大小 ---
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((WindownWidth - 20) / 2, 228);
}

#pragma mark --- 设置item ---
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EquipDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:EquipDetailViewCell_Identify forIndexPath:indexPath];
    
    EquipDetailModel *Emodel = self.detailArr[indexPath.row];
    cell.model = Emodel;
    
    return cell;
}

#pragma mark --- 设置item的点击方法 ---
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BuyEquipViewController *buyVC = [[BuyEquipViewController alloc] init];
    EquipDetailModel *model = self.detailArr[indexPath.row];
    buyVC.model = model;
    
    UINavigationController *thirdNC = [[UINavigationController alloc]initWithRootViewController:buyVC];
    
    [self presentViewController:thirdNC animated:YES completion:nil];
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
