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

@interface EquipDetailViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSMutableArray *detailArr;

@property (strong, nonatomic) UICollectionView *equipDetailView;

@end

//重用标识符
static NSString *const cellResueID = @"111";

@implementation EquipDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.model.catname;
    
    self.detailArr = [NSMutableArray array];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置距离四边的距离
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    //初始化collection
    self.equipDetailView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, WindownWidth, self.view.bounds.size.height - 113) collectionViewLayout:flowLayout];

    //注册自定义cell
    [self.equipDetailView registerNib:[UINib nibWithNibName:@"EquipDetailCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:EquipDetailViewCell_Identify];
    
    //设置代理
    self.equipDetailView.delegate = self;
    self.equipDetailView.dataSource = self;
    
    [self DataRequest];
    [self.view addSubview:self.equipDetailView];
    self.equipDetailView.backgroundColor = [UIColor grayColor];
    self.view.backgroundColor = [UIColor purpleColor];
}

#pragma mark --- 请求数据 ---
- (void)DataRequest
{
    __weak typeof(self) weakself = self;
    EquipDetailRequest *request = [[EquipDetailRequest alloc] init];
    [request equipDetailRequestWithParameter:@{@"id":self.model.ID} sucess:^(NSDictionary *dic) {
        
        NSArray *event = [dic objectForKey:@"data"];
        for (NSDictionary *tempDic in event) {
            EquipDetailModel *model = [[EquipDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakself.detailArr addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakself.equipDetailView reloadData];
        });
        
//        NSLog(@"detail == %@",weakself.detailArr);
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
    return CGSizeMake((WindownWidth - 20) / 2, 283);
}

#pragma mark --- 设置item ---
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EquipDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:EquipDetailViewCell_Identify forIndexPath:indexPath];
    
    EquipDetailModel *Emodel = self.detailArr[indexPath.row];
    cell.model = Emodel;
    
    return cell;
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
