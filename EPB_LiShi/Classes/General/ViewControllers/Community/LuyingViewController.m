//
//  LuyingViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "LuyingViewController.h"
#import "CommunityRequest.h"
#import "CommunityLuyingCell.h"
#import "CommunityLuyingVideoCell.h"
#import "CommunityListModel.h"
#import "CommunityHeaderCell.h"
#import "TopicDetailViewController.h"
#import "ComTopicDetailViewController.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface LuyingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *communityLuyingListView;

@property (nonatomic, strong) NSMutableArray *luyingListArray;

@property (nonatomic, strong) NSMutableDictionary *headerDataDic;

@end

@implementation LuyingViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self requestCommunityHeaderViewData];
        [self requestCommunityLuyingListData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.communityLuyingListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49 - 64 - 44)];
    
    // 注册
    [self.communityLuyingListView registerNib:[UINib nibWithNibName:@"CommunityHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CommunityHeaderCell_Identify];
    [self.communityLuyingListView registerNib:[UINib nibWithNibName:@"CommunityLuyingCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CommunityLuyingCell_Identify];
    [self.communityLuyingListView registerNib:[UINib nibWithNibName:@"CommunityLuyingVideoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CommunityLuyingVideoCell_Identify];
    
    self.communityLuyingListView.dataSource = self;
    self.communityLuyingListView.delegate = self;
    
    [self.view addSubview:self.communityLuyingListView];
    
    
}

- (void)requestCommunityLuyingListData {
    self.luyingListArray = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    CommunityRequest *request = [[CommunityRequest alloc] init];
    [request CommunityLuyingListRequestWithParameter:nil success:^(NSDictionary *dic) {
        NSDictionary *tempEvents = [dic objectForKey:@"data"];
        NSArray *tempArray = [tempEvents objectForKey:@"topiclist"];
        for (NSDictionary *tempDic in tempArray) {
            LuyingListModel *model = [LuyingListModel new];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakSelf.luyingListArray addObject:model];
        }
        // NSLog(@"weakSelf.luyingListArray=========%@",weakSelf.luyingListArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.communityLuyingListView reloadData];
        });
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
}
- (void)requestCommunityHeaderViewData {
    self.headerDataDic = [NSMutableDictionary dictionary];
    __weak typeof(self) weakSelf = self;
    CommunityRequest *request = [[CommunityRequest alloc] init];
    [request CommunityHeaderViewRequestWithParameter:nil success:^(NSDictionary *dic) {
        
        weakSelf.headerDataDic = [dic objectForKey:@"data"];
        CommunityHeaderModel *model = [CommunityHeaderModel new];
        [model setValuesForKeysWithDictionary:weakSelf.headerDataDic];
        
        // NSLog(@"headerDataDic == %@",weakSelf.headerDataDic);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.communityLuyingListView reloadData];
        });
        
    } failure:^(NSError *error) {
        
    }];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 153;
    }else {
        return 420;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.luyingListArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        CommunityHeaderModel *model = [CommunityHeaderModel new];
        [model setValuesForKeysWithDictionary:self.headerDataDic];
        CommunityHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:CommunityHeaderCell_Identify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        [cell.backImage setImage:[UIImage imageNamed:@"tubu.jpg"]];
        return cell;
    }else {
        
        LuyingListModel *model = self.luyingListArray[indexPath.row];
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
    }
    else {
        LuyingListModel *model = self.luyingListArray[indexPath.row];
    
        if (model.images.count == 0) {
        
            NSLog(@"luyingVideoID == %ld",model.videoid);
            TopicDetailViewController *detailVC = [TopicDetailViewController new];
            detailVC.topics_id = model.list_id;
            [self.navigationController pushViewController:detailVC animated:YES];
        }else {
        
            NSLog(@"luyingImageID == %@",model.list_id);
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
