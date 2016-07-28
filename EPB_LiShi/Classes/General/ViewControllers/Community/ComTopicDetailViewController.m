//
//  ComTopicDetailViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/26.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "ComTopicDetailViewController.h"
#import "CommunityRequest.h"
#import "ComHeaderDetailCell.h"
#import "ComMiddleDetailCell.h"


@interface ComTopicDetailViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSString *club_id;
@property (nonatomic, strong) NSString *user_id;

@property (nonatomic, strong) NSMutableDictionary *allDataDic;

@end

@implementation ComTopicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rootVC = (RootViewController *)[[[UIApplication sharedApplication] windows] objectAtIndex:1].rootViewController;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ComHeaderDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ComHeaderDetailCell_Identify];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ComMiddleDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ComMiddleDetailCell_Identify];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    [self requestClubDetailData];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.rootVC.LSTabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.rootVC.LSTabBar.hidden = NO;
}

- (void)requestClubDetailData {
    
    self.allDataDic = [NSMutableDictionary dictionary];
    
    CommunityRequest *request = [[CommunityRequest alloc] init];
    self.club_id = self.model.club_id;
    self.user_id = @"451316";
    __weak typeof(self) weakSelf = self;
    [request CommunityHeaderDetailViewRequestWithParameter:[NSDictionary dictionaryWithObjectsAndKeys:self.club_id,@"club_id",self.user_id,@"user_id", nil] success:^(NSDictionary *dic) {
        weakSelf.allDataDic = [dic objectForKey:@"data"];
        NSLog(@"LLLLLLL%@",weakSelf.allDataDic);
        CommunityHeaderModel *model = [CommunityHeaderModel new];
        [model setValuesForKeysWithDictionary:weakSelf.allDataDic];
        NSLog(@"CommunityHeaderModel == %@",model);
    } failure:^(NSError *error) {
        
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 160;
    }else {
        return [ComMiddleDetailCell cellHeight:self.model];
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        ComHeaderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ComHeaderDetailCell_Identify forIndexPath:indexPath];
        //[self.model setValuesForKeysWithDictionary:self.allDataDic];
        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        ComMiddleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ComMiddleDetailCell_Identify forIndexPath:indexPath];
        //[self.model setValuesForKeysWithDictionary:self.allDataDic];
        cell.model = self.model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
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
