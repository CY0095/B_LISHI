//
//  SportClothViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "SportClothViewController.h"
#import "EquipDetailCollectionViewCell.h"
#import "sportClothRequest.h"
#import "SportClothModel.h"

@interface SportClothViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *sportTableView;
@property (strong, nonatomic) NSMutableArray *detailArr;

@end

//重用标识符
static NSString *const cellResueID = @"111";

@implementation SportClothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.model.title;
    
    self.detailArr = [NSMutableArray array];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //设置距离四边的距离
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    //初始化collection
    self.sportTableView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, WindownWidth, self.view.bounds.size.height - 113) collectionViewLayout:flowLayout];
    
    //注册自定义cell
    [self.sportTableView registerNib:[UINib nibWithNibName:@"EquipDetailCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:EquipDetailViewCell_Identify];
    
    //设置代理
    self.sportTableView.delegate = self;
    self.sportTableView.dataSource = self;
    
    [self DataRequest];
    [self.view addSubview:self.sportTableView];
    self.sportTableView.backgroundColor = [UIColor grayColor];
    self.view.backgroundColor = [UIColor purpleColor];
}

- (void)DataRequest
{
    __weak typeof(self) weakself = self;
    SportClothRequest *request = [[SportClothRequest alloc] init];
    [request sportClothDetailRequestWithParameter:@{@"id":self.model.ID} sucess:^(NSDictionary *dic) {

        
        NSArray *event = [dic objectForKey:@"data"];
        for (NSDictionary *tempDic in event) {
            SportClothModel *model = [[SportClothModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakself.detailArr addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [weakself.sportTableView reloadData];
        });
        
//                NSLog(@"detail == %@",weakself.detailArr);
    } failure:^(NSError *error) {
        
        NSLog(@"failure == %@",error);
    }];
}

//分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.detailArr.count;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((WindownWidth - 20) / 2, 283);
}

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
