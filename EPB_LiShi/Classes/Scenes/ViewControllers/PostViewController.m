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
@interface PostViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)UITableView *postTableView;// tableView

@property(strong,nonatomic)PostHeadModel *model;

@property(strong,nonatomic)NSMutableArray *dataArray;// 存储数据的数组
@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.postTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WindownWidth, WindowHeight - 64 ) style:(UITableViewStylePlain)];
    self.postTableView.delegate = self;
    self.postTableView.dataSource = self;
    [self.view addSubview:self.postTableView];
    // 注册cell
    [self.postTableView registerNib:[UINib nibWithNibName:@"PostHeadViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:PostHeadViewCell_Identify];
    [self.postTableView registerNib:[UINib nibWithNibName:@"PostReplyViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:PostReplyViewCell_Identify];
    
    // 请求数据
    [self postHeadRequest];
    [self postReplyRequest];
    
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

-(void)postReplyRequest{
    self.dataArray = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    if ( !user_id) {
        user_id = @"0";
    }
    [[PostRequest sharePostRequest] postReplyRequestWithTopic_id:self.topic_id  user_id:user_id success:^(NSDictionary *dic) {
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
