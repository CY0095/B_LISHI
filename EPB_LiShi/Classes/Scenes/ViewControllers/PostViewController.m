//
//  PostViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/25.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "PostViewController.h"
#import "PostHeadModel.h"
#import "PostHeadViewCell.h"
#import "PostRequest.h"
#import "PostReplyModel.h"
#import "PostReplyViewCell.h"
#import "ReplyViewController.h"
@interface PostViewController ()
<
            UITableViewDataSource,
            UITableViewDelegate,
            PostReplyTableViewCellDelegate// postReplycell的代理
>
@property(strong,nonatomic)UITableView *postTableView;// tableView

@property(strong,nonatomic)PostHeadModel *model;

@property(strong,nonatomic)NSMutableArray *dataArray;// 存储数据的数组
@property(assign,nonatomic)int page;
@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 0;
    self.postTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WindownWidth, WindowHeight - 64 ) style:(UITableViewStylePlain)];
    self.postTableView.delegate = self;
    self.postTableView.dataSource = self;
    [self.view addSubview:self.postTableView];
    // 注册cell
    [self.postTableView registerNib:[UINib nibWithNibName:@"PostHeadViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:PostHeadViewCell_Identify];
    [self.postTableView registerNib:[UINib nibWithNibName:@"PostReplyViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:PostReplyViewCell_Identify];
    
    // 请求数据
    self.dataArray = [NSMutableArray array];// 初始化数组
    [self postHeadRequest];
    [self postReplyRequest];
    
    // 上拉加载
    self.postTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
    }];
    self.postTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(addPage)];
    [self.postTableView.mj_footer beginRefreshing];// 开始加载
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rootVC.LSTabBar.hidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.rootVC.LSTabBar.hidden = YES;
}
// 请求数据
-(void)postHeadRequest{
    
    self.model = [[PostHeadModel alloc] init];
    __weak typeof(self) weakSelf = self;
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    if ( !user_id) {
        user_id = @"0";
    }
    [[PostRequest sharePostRequest] postHeadViewRequestWithTopic_id:self.topic_id user_id:user_id success:^(NSDictionary *dic) {
        NSDictionary *tempDic = [dic objectForKey:@"data"];
        [weakSelf.model setValuesForKeysWithDictionary:tempDic];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.postTableView reloadData];
        });
    } failure:^(NSError *error) {
        
    }];
    
}
// 上拉加载的辅助方法
-(void)addPage{
    self.page ++;
    [self postReplyRequest];
}

// 评论列表请求
-(void)postReplyRequest{
    
    __weak typeof(self) weakSelf = self;
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    if ( !user_id) {
        user_id = @"0";
    }
    
    
    [[PostRequest sharePostRequest] postReplyRequestWithTopic_id:self.topic_id  user_id:user_id page:[NSString stringWithFormat:@"%d",self.page] success:^(NSDictionary *dic) {
        NSArray *topiclist = [[dic objectForKey:@"data"] objectForKey:@"topiclist"];
        for (NSDictionary *tempDic in topiclist) {
            PostReplyModel *model = [[PostReplyModel alloc] init];
            [model setValuesForKeysWithDictionary:tempDic];
            [weakSelf.dataArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.postTableView reloadData];
        });
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
    
    [self.postTableView.mj_footer endRefreshing];// 结束加载
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count + 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        PostHeadViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PostHeadViewCell_Identify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.model;
        return cell;
    }else{
        PostReplyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PostReplyViewCell_Identify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.model = self.dataArray[indexPath.row - 1];
        cell.delegate = self;
    return cell;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        return [PostHeadViewCell cellHeight:self.model];
    }else{
        PostReplyModel *model = self.dataArray[indexPath.row - 1];
        return [PostReplyViewCell cellHeight:model];
    }
}
#pragma mark ------ cell 的代理方法
// cell的代理方法
-(void)PostReplyTableViewReplyBtnClicked:(PostReplyViewCell *)cell{
    ReplyViewController *replyVC = [[ReplyViewController alloc] init];
    replyVC.titleStr = [NSString stringWithFormat:@"回复%@",cell.nicknameLabel.text];
    replyVC.club_id = cell.club_id;
    replyVC.replytopic_id = cell.replytopic_id;
    replyVC.topic_id = self.topic_id;
    [self.navigationController pushViewController:replyVC animated:YES];
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
