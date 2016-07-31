//
//  AllListViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/25.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "AllListViewController.h"
#import "CommunityRequest.h"
#import "CommunityLuyingCell.h"
#import "CommunityLuyingVideoCell.h"
#import "CommunityListModel.h"
#import "CommunityHeaderCell.h"
#import "TopicDetailViewController.h"
#import "ComTopicDetailViewController.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface AllListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *communityAllListView;

@property (nonatomic, strong) NSMutableArray *allListArray;

@property (nonatomic, strong) NSMutableDictionary *headerDataDic;

@end

@implementation AllListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    self.communityAllListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    // 注册
    [self.communityAllListView registerNib:[UINib nibWithNibName:@"CommunityHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CommunityHeaderCell_Identify];
    [self.communityAllListView registerNib:[UINib nibWithNibName:@"CommunityLuyingCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CommunityLuyingCell_Identify];
    [self.communityAllListView registerNib:[UINib nibWithNibName:@"CommunityLuyingVideoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CommunityLuyingVideoCell_Identify];
    
    self.communityAllListView.dataSource = self;
    self.communityAllListView.delegate = self;
    
    [self.view addSubview:self.communityAllListView];
    
    [self requestCommunityAllListData];
    [self requestCommunityHeaderViewData];
    [GiFHUD setGifWithImageName:@"loading.gif"];
    [GiFHUD show];
}

- (void)requestCommunityAllListData{
    NSLog(@"aaaaa%@",self.tempStr);
    self.club_id = self.tempStr;
    self.user_id = @"451316";
    self.allListArray = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    CommunityRequest *request = [[CommunityRequest alloc] init];
    [request CommunityAllListViewRequestWithParameter:[NSDictionary dictionaryWithObjectsAndKeys:self.club_id,@"club_id",self.user_id,@"user_id", nil] success:^(NSDictionary *dic) {
        NSDictionary *tempEvents = [dic objectForKey:@"data"];
        NSArray *tempArray = [tempEvents objectForKey:@"topiclist"];
        for (NSDictionary *tempDic in tempArray) {
            LuyingListModel *model = [LuyingListModel new];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakSelf.allListArray addObject:model];
        }
        
        // NSLog(@"LuyingListArray == %@",weakSelf.luyingListArray);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.communityAllListView reloadData];
            [GiFHUD dismiss];
        });
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
}
- (void)requestCommunityHeaderViewData{
    self.club_id = self.tempStr;
    NSLog(@"cccccc%@",self.tempStr);
    self.user_id = @"451316";
    self.headerDataDic = [NSMutableDictionary dictionary];
    __weak typeof(self) weakSelf = self;
    CommunityRequest *request = [[CommunityRequest alloc] init];
    
    [request CommunityAllListHeaderViewRequestWithParameter:[NSDictionary dictionaryWithObjectsAndKeys:self.club_id,@"club_id",self.user_id,@"user_id", nil] success:^(NSDictionary *dic) {
    
        weakSelf.headerDataDic = [dic objectForKey:@"data"];
        CommunityHeaderModel *model = [CommunityHeaderModel new];
        [model setValuesForKeysWithDictionary:weakSelf.headerDataDic];
        
        NSLog(@"headerDataDic == %@",weakSelf.headerDataDic);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.communityAllListView reloadData];
        });
        
    } failure:^(NSError *error) {
        
    }];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 153;
    }else {
        LuyingListModel *model = self.allListArray[indexPath.row - 1];
        return [CommunityLuyingCell cellHeight:model];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.allListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        CommunityHeaderModel *model = [CommunityHeaderModel new];
        [model setValuesForKeysWithDictionary:self.headerDataDic];
        CommunityHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:CommunityHeaderCell_Identify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        [cell.backImage setImage:[UIImage imageNamed:@"pandeng.jpg"]];
        return cell;
    }else {
        LuyingListModel *model = self.allListArray[indexPath.row];
        if (model.images.count == 0) {
            CommunityLuyingVideoCell *videoCell = [tableView dequeueReusableCellWithIdentifier:CommunityLuyingVideoCell_Identify];
            videoCell.model = model;
            videoCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return videoCell;
        }
        
        CommunityLuyingCell *imgCell = [tableView dequeueReusableCellWithIdentifier:CommunityLuyingCell_Identify];
        imgCell.selectionStyle = UITableViewCellSelectionStyleNone;
        imgCell.model = model;
        
        return imgCell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        CommunityHeaderModel *model = [CommunityHeaderModel new];
        [model setValuesForKeysWithDictionary:self.headerDataDic];
        NSLog(@"model.club_id == %@",model.club_id);
        
        ComTopicDetailViewController *detailVC = [ComTopicDetailViewController new];
        detailVC.model = model;
        [self.navigationController pushViewController:detailVC animated:YES];
        
    }else {
        LuyingListModel *model = self.allListArray[indexPath.row];
        
        if (model.images.count == 0) {
            
            NSLog(@"PandengVideoID == %ld",model.videoid);
            TopicDetailViewController *detailVC = [TopicDetailViewController new];
            detailVC.topics_id = model.list_id;
            [self.navigationController pushViewController:detailVC animated:YES];
        }else {
            
            NSLog(@"PandengImageID == %@",model.list_id);
            TopicDetailViewController *detailVC = [TopicDetailViewController new];
            detailVC.topics_id = model.list_id;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
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