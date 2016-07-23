//
//  CommunityViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "CommunityViewController.h"
#import "CommunityTableViewCell.h"
#import "CommunityRequest.h"
#import "CommunityListModel.h"
#import "CommunityDetailViewController.h"


#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface CommunityViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *communityTableView;

@property (nonatomic, strong) NSMutableArray *communityListArray;

@end

@implementation CommunityViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
        
//        self.communityTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            // 进入刷新状态后会自动回调这个block
//        }];
//        // 设置回调（一旦进入刷新状态，就会调用target的action，也就是调用self的loadNewData方法）
//        self.communityTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestCommunityListData)];
//        // 马上进入刷新状态
//        [self.communityTableView.mj_header beginRefreshing];
        
        [self requestCommunityListData];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.communityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49 - 64 - 44)];
    
    
    // 注册
    [self.communityTableView registerNib:[UINib nibWithNibName:@"CommunityTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CommunityTableViewCell_Identify];
    self.communityTableView.dataSource = self;
    self.communityTableView.delegate = self;
    
    
    [self.view addSubview:self.communityTableView];
    
}

- (void)requestCommunityListData {
    
    self.communityListArray = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    CommunityRequest *request = [[CommunityRequest alloc] init];
    
    [request CommunityListRequestWithParameter:nil success:^(NSDictionary *dic) {
        NSDictionary *tempEvents = [dic objectForKey:@"data"];
        NSArray *tempArray = [tempEvents objectForKey:@"omnibuslist"];
        for (NSDictionary *tempDic in tempArray) {
            CommunityListModel *model = [CommunityListModel new];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakSelf.communityListArray addObject:model];
        }
        NSLog(@"communityListArray == %@",weakSelf.communityListArray);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.communityTableView reloadData];
        });
    } failure:^(NSError *error) {
        
    }];
    // 当视图加载出来的时候结束刷新
    // [self.communityTableView.mj_header endRefreshing];
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 315;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // NSLog(@"%ld",self.communityListArray.count);
    return self.communityListArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommunityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CommunityTableViewCell_Identify];
    CommunityListModel *model = self.communityListArray[indexPath.row];
    cell.model = model;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CommunityListModel *model = self.communityListArray[indexPath.row];
    
    NSLog(@"CommunityTableViewCell %@",model.topic_id);
    
    CommunityDetailViewController *detailVC = [CommunityDetailViewController new];
    
    detailVC.topics_id = model.topic_id;
    
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
    
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
