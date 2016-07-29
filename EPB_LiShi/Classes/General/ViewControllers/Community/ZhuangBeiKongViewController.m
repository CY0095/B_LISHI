//
//  ZhuangBeiKongViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/16.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ZhuangBeiKongViewController.h"
#import "CommunityRequest.h"
#import "CommunityLuyingCell.h"
#import "CommunityLuyingVideoCell.h"
#import "CommunityListModel.h"
#import "CommunityHeaderCell.h"
#import "TopicDetailViewController.h"
#import "ComTopicDetailViewController.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface  ZhuangBeiKongViewController()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *communityzhuangbeifanListView;

@property (nonatomic, strong) NSMutableArray *ZhuangbeiListArray;

@property (nonatomic, strong) NSMutableDictionary *headerDataDic;

@end

@implementation ZhuangBeiKongViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.communityzhuangbeifanListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49 - 64 - 44)];
    
    // 注册
    [self.communityzhuangbeifanListView registerNib:[UINib nibWithNibName:@"CommunityHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CommunityHeaderCell_Identify];
    [self.communityzhuangbeifanListView registerNib:[UINib nibWithNibName:@"CommunityLuyingCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CommunityLuyingCell_Identify];
    [self.communityzhuangbeifanListView registerNib:[UINib nibWithNibName:@"CommunityLuyingVideoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CommunityLuyingVideoCell_Identify];
    
    self.communityzhuangbeifanListView.dataSource = self;
    self.communityzhuangbeifanListView.delegate = self;
    
    [self.view addSubview:self.communityzhuangbeifanListView];
    
    
    
    
    [self requestCommunityLuyingListData];
    [self requestCommunityHeaderViewData];
    [GiFHUD setGifWithImageName:@"loading.gif"];
    [GiFHUD show];
}

- (void)requestCommunityLuyingListData {
    self.ZhuangbeiListArray = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    CommunityRequest *request = [[CommunityRequest alloc] init];
    [request CommunityZhuangbeikongListRequestWithParameter:nil success:^(NSDictionary *dic) {
        NSDictionary *tempEvents = [dic objectForKey:@"data"];
        NSArray *tempArray = [tempEvents objectForKey:@"topiclist"];
        for (NSDictionary *tempDic in tempArray) {
            LuyingListModel *model = [LuyingListModel new];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakSelf.ZhuangbeiListArray addObject:model];
        }
        
        // NSLog(@"SheyingListArray == %@",weakSelf.SheyingListArray);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.communityzhuangbeifanListView reloadData];
            [GiFHUD dismiss];
        });
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
}
- (void)requestCommunityHeaderViewData {
    self.headerDataDic = [NSMutableDictionary dictionary];
    __weak typeof(self) weakSelf = self;
    CommunityRequest *request = [[CommunityRequest alloc] init];
    [request ZhuangbeikongHeaderViewRequestWithParameter:nil success:^(NSDictionary *dic) {
        
        weakSelf.headerDataDic = [dic objectForKey:@"data"];
        CommunityHeaderModel *model = [CommunityHeaderModel new];
        [model setValuesForKeysWithDictionary:weakSelf.headerDataDic];
        
        // NSLog(@"headerDataDic == %@",weakSelf.headerDataDic);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.communityzhuangbeifanListView reloadData];
        });
        
    } failure:^(NSError *error) {
        
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 153;
    }else {
        LuyingListModel *model = self.ZhuangbeiListArray[indexPath.row - 1];
        return [CommunityLuyingCell cellHeight:model];
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ZhuangbeiListArray.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        CommunityHeaderModel *model = [CommunityHeaderModel new];
        [model setValuesForKeysWithDictionary:self.headerDataDic];
        CommunityHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:CommunityHeaderCell_Identify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = model;
        [cell.backImage setImage:[UIImage imageNamed:@"zhuangbei.jpg"]];
        return cell;
    }else {
        LuyingListModel *model = self.ZhuangbeiListArray[indexPath.row - 1];
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
        LuyingListModel *model = self.ZhuangbeiListArray[indexPath.row - 1];
        
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
