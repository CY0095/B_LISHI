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

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface AllListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *communityLuyingListView;

@property (nonatomic, strong) NSMutableArray *luyingListArray;

@property (nonatomic, strong) NSMutableDictionary *headerDataDic;

@end

@implementation AllListViewController

//- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
//        [self requestCommunityAllListData];
//        [self requestCommunityHeaderViewData];
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    self.communityLuyingListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    // 注册
    [self.communityLuyingListView registerNib:[UINib nibWithNibName:@"CommunityHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CommunityHeaderCell_Identify];
    [self.communityLuyingListView registerNib:[UINib nibWithNibName:@"CommunityLuyingCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CommunityLuyingCell_Identify];
    [self.communityLuyingListView registerNib:[UINib nibWithNibName:@"CommunityLuyingVideoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:CommunityLuyingVideoCell_Identify];
    
    self.communityLuyingListView.dataSource = self;
    self.communityLuyingListView.delegate = self;
    
    [self.view addSubview:self.communityLuyingListView];
    
    [self requestCommunityAllListData];
    [self requestCommunityHeaderViewData];
    
}

- (void)requestCommunityAllListData{
    NSLog(@"aaaaa%@",self.tempStr);
    self.club_id = self.tempStr;
    self.user_id = @"451316";
    self.luyingListArray = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    CommunityRequest *request = [[CommunityRequest alloc] init];
    [request CommunityAllListViewRequestWithParameter:[NSDictionary dictionaryWithObjectsAndKeys:self.club_id,@"club_id",self.user_id,@"user_id", nil] success:^(NSDictionary *dic) {
        NSDictionary *tempEvents = [dic objectForKey:@"data"];
        NSArray *tempArray = [tempEvents objectForKey:@"topiclist"];
        for (NSDictionary *tempDic in tempArray) {
            LuyingListModel *model = [LuyingListModel new];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakSelf.luyingListArray addObject:model];
        }
        
        // NSLog(@"LuyingListArray == %@",weakSelf.luyingListArray);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.communityLuyingListView reloadData];
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
        [cell.backImage setImage:[UIImage imageNamed:@"pandeng.jpg"]];
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
    }else {
        LuyingListModel *model = self.luyingListArray[indexPath.row];
        
        if (model.images.count == 0) {
            
            NSLog(@"PandengVideoID == %ld",model.videoid);
        }else {
            
            NSLog(@"PandengImageID == %@",model.list_id);
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