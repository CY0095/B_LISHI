//
//  MoreListViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "MoreListViewController.h"
#import "CommunityRequest.h"
#import "CommunityCustomCell.h"
#import "CommunityCoCellModel.h"
#import "AllListViewController.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface MoreListViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableDictionary *allDataDic;
@property (nonatomic, strong) NSMutableArray *djclublistArray;
@property (nonatomic, strong) NSMutableArray *tsclublistArray;
@property (nonatomic, strong) NSMutableArray *ppclublistArray;

@end

static NSString *const headerID = @"headerCellReuseIdentifier";
@implementation MoreListViewController
//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
//        [self requestCollectionViewData];
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    // 设置每个item的大小
    flowLayout.itemSize = CGSizeMake((kScreenWidth - 40)/ 2, ((kScreenWidth - 40)/ 2) / 190 * 70);
    // 设置最小行间距
    flowLayout.minimumLineSpacing = 20;
    // 设置最小列间距
    flowLayout.minimumInteritemSpacing = 20;
    // 设置单个分区距离上下左右的位置
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    // 设置滑动方向(垂直)
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 设置增补视图尺寸
//    flowLayout.footerReferenceSize = CGSizeMake(0, 50);
    flowLayout.headerReferenceSize = CGSizeMake(0, 20);
    
    // 初始化collectionView
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49 - 64 - 44) collectionViewLayout:flowLayout];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CommunityCustomCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:CommunityCustomCell_Identify];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
    
    self.collectionView.dataSource =self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
    self.allDataDic = [NSMutableDictionary dictionary];
    self.djclublistArray = [NSMutableArray array];
    self.tsclublistArray = [NSMutableArray array];
    self.ppclublistArray = [NSMutableArray array];
    
    [self requestCollectionViewData];
}

- (void)requestCollectionViewData {
    
    
    __weak typeof(self) weakSelf = self;
    CommunityRequest *request = [[CommunityRequest alloc] init];
    [request CollectionViewCellRequestWithParameter:nil success:^(NSDictionary *dic) {
        // 三个分组
        self.allDataDic = [dic objectForKey:@"data"];
        NSArray *djlistArray = [self.allDataDic objectForKey:@"djclublist"];
        for (NSDictionary *tempDic in djlistArray) {
            CommunityCoCellModel *model = [CommunityCoCellModel new];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakSelf.djclublistArray addObject:model];
        }
        NSLog(@"djclublistArray%@",self.djclublistArray);
        
        NSArray *tslistArray = [self.allDataDic objectForKey:@"tsclublist"];
        for (NSDictionary *tempDic in tslistArray) {
            CommunityCoCellModel *model = [CommunityCoCellModel new];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakSelf.tsclublistArray addObject:model];
        }
        NSLog(@"tsclublistArray%@",self.tsclublistArray);
        
        NSArray *pplistArray = [self.allDataDic objectForKey:@"ppclublist"];
        for (NSDictionary *tempDic in pplistArray) {
            CommunityCoCellModel *model = [CommunityCoCellModel new];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakSelf.ppclublistArray addObject:model];
        }
        NSLog(@"ppclublistArray%@",self.ppclublistArray);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.djclublistArray.count;
    }else if (section == 1) {
        return self.tsclublistArray.count;
    }else {
        return self.ppclublistArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CommunityCustomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CommunityCustomCell_Identify forIndexPath:indexPath];
    cell.backgroundColor = [UIColor cyanColor];
    if (indexPath.section == 0) {
        CommunityCoCellModel *model = self.djclublistArray[indexPath.row];
        cell.model = model;
        return cell;
    }else if (indexPath.section == 1) {
        CommunityCoCellModel *model = self.tsclublistArray[indexPath.row];
        cell.model = model;
        return cell;
    }else {
        CommunityCoCellModel *model = self.ppclublistArray[indexPath.row];
        cell.model = model;
        return cell;
    }
    
}
// 头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reuseableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        
        headerView.backgroundColor = [UIColor whiteColor];
        
        reuseableView = headerView;
    }
    return reuseableView;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        CommunityCoCellModel *model = self.djclublistArray[indexPath.row];
        NSLog(@"id == %@ title == %@",model.club_id,model.club_title);
        AllListViewController *allListVC = [AllListViewController new];
        allListVC.tempStr = model.club_id;
        allListVC.title = model.club_title;
        NSLog(@"bbbbbbbbbb%@",allListVC.tempStr);
        [self.navigationController pushViewController:allListVC animated:YES];
    }else if (indexPath.section == 1) {
        CommunityCoCellModel *model = self.tsclublistArray[indexPath.row];
        NSLog(@"id == %@ title == %@",model.club_id,model.club_title);
        AllListViewController *allListVC = [AllListViewController new];
        allListVC.tempStr = model.club_id;
        allListVC.title = model.club_title;
        [self.navigationController pushViewController:allListVC animated:YES];
    }else {
        CommunityCoCellModel *model = self.ppclublistArray[indexPath.row];
        NSLog(@"id == %@ title == %@",model.club_id,model.club_title);
        AllListViewController *allListVC = [AllListViewController new];
        allListVC.tempStr = model.club_id;
        allListVC.title = model.club_title;
        [self.navigationController pushViewController:allListVC animated:YES];
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
