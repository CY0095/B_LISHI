//
//  AttentionDetailViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/20.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "AttentionDetailViewController.h"
#import "PostMessageModel.h"
#import "AttentionDetailTableViewCell.h"
#import "UserDetailRequest.h"
#import "TopicDetailViewController.h"
#import "PostViewController.h"
#import "ActivityDetailViewController.h"
@interface AttentionDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic)UITableView *attentionDetailTableView;
@property(strong,nonatomic)UIView *headView;// tableView的头视图
@property(strong,nonatomic)UIImageView *headImg;//

@property(strong,nonatomic)UIImageView *userImg;// 用户头像
@property(strong,nonatomic)UILabel *nickNameLabel;// 昵称
@property(strong,nonatomic)UILabel *fanceNumLabel;// 粉丝数
@property(strong,nonatomic)UILabel *noteLabel;// 简介
@property(strong,nonatomic)UILabel *messageLabel;// 发布的帖子

@property(strong,nonatomic)NSMutableArray *dataArray;// 存储model的数组
@end

@implementation AttentionDetailViewController
-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        
    }
    return self;
}
// 绘制界面
-(void)drawView{
    
    self.attentionDetailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WindownWidth, WindowHeight - 64)];
    self.attentionDetailTableView.delegate = self;
    self.attentionDetailTableView.dataSource = self;
    self.attentionDetailTableView.backgroundColor = [UIColor colorWithRed:220/255.0 green:219/255.0 blue:195/255.0 alpha:1];
    
    // 头视图
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindownWidth, WindowHeight / 3)];
    self.headImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WindownWidth, self.headView.bounds.size.height*2/3)];
    self.headImg.image = [UIImage imageNamed:@"yekong.jpg"];
    [self.headView addSubview:self.headImg];
    // 用户头像
    self.userImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.userImg.image = [UIImage imageNamed:@"boy_default"];
    self.userImg.center = CGPointMake(self.headImg.center.x, self.headImg.center.y - 10);
    self.userImg.layer.cornerRadius = 10;// 切圆角
    self.userImg.layer.masksToBounds = YES;
    [self.headImg addSubview:self.userImg];
    
    self.nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    self.nickNameLabel.center = CGPointMake(self.userImg.center.x, self.userImg.center.y + 40);
    self.nickNameLabel.textAlignment = NSTextAlignmentCenter;
    self.nickNameLabel.text = @"可可西里carlisle";
    self.nickNameLabel.textColor = [UIColor whiteColor];
    [self.headImg addSubview:self.nickNameLabel];// 添加昵称视图
    
    self.fanceNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    self.fanceNumLabel.center = CGPointMake(self.nickNameLabel.center.x, self.nickNameLabel.center.y + 18);
    self.fanceNumLabel.textAlignment = NSTextAlignmentCenter;
    self.fanceNumLabel.text = @"999位粉丝";
    self.fanceNumLabel.textColor = [UIColor whiteColor];
    self.fanceNumLabel.font = [UIFont systemFontOfSize:13.0];
    [self.headImg addSubview:self.fanceNumLabel];// 添加粉丝数视图
    
    self.noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.headImg.bounds.size.height + 5, WindownWidth - 20, 40)];
    self.noteLabel.numberOfLines = 0;
    self.noteLabel.alpha = 0.7;
    self.noteLabel.font = [UIFont systemFontOfSize:13];
    self.noteLabel.text = @"哎呦,简介没写哦......";
    
    [self.headView addSubview:self.noteLabel];// 添加简介视图
    
    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    self.messageLabel.text = @"发布的帖子";
    self.messageLabel.textColor = [UIColor greenColor];
    self.messageLabel.center = CGPointMake(self.fanceNumLabel.center.x, self.headView.bounds.size.height - 12);
    self.messageLabel.font = [UIFont systemFontOfSize:16];
    [self.headView addSubview:self.messageLabel];
    self.attentionDetailTableView.tableHeaderView = self.headView;
    
    
    [self.view addSubview:self.attentionDetailTableView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self drawView];// 绘制界面
    // 初始化数组
    self.dataArray = [NSMutableArray array];
    // 注册cell
    [self.attentionDetailTableView registerNib:[UINib nibWithNibName:@"AttentionDetailTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:AttentionDetailTableViewCell_Identify];
    // 数据解析
    [self userDetailRequest];
    

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rootVC.LSTabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.rootVC.LSTabBar.hidden = NO;
}


// 请求数据
-(void)userDetailRequest{
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    if (!user_id) {
        user_id = @"0";
    }
    NSLog(@"uid ====== %@",self.uid);
    [[UserDetailRequest shareUserDetailRequest] UserDetailRequestWithUid:self.uid user_id:user_id success:^(NSDictionary *dic) {
        NSArray *topiclist = [[dic objectForKey:@"data"] objectForKey:@"topiclist"];
        for (NSDictionary *tempDic in topiclist) {
            PostMessageModel *model = [PostMessageModel new];
            [model setValuesForKeysWithDictionary:tempDic];
            [self.dataArray addObject:model];
        }
        NSLog(@"self.dataArray = %@",self.dataArray);
        NSDictionary *userinfo = [[dic objectForKey:@"data"] objectForKey:@"userinfo"];
        NSString *headicon = [userinfo objectForKey:@"headicon"];
        NSString *nickname = [userinfo objectForKey:@"nickname"];
        NSString *note = [userinfo objectForKey:@"note"];
        NSString *follows = [userinfo objectForKey:@"follows"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.attentionDetailTableView reloadData];
            [self.userImg setImageWithURL:[NSURL URLWithString:headicon]];
            self.nickNameLabel.text = nickname;
            if (note.length != 0) {
                self.noteLabel.text = note;
            }
            self.fanceNumLabel.text = [NSString stringWithFormat:@"%@位粉丝数",follows];
        });
    } failure:^(NSError *error) {
        NSLog(@"error = %@",error);
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AttentionDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AttentionDetailTableViewCell_Identify];
    cell.model = self.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
// cell的点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TopicDetailViewController *topicVC = [TopicDetailViewController new];
    PostMessageModel *model = self.dataArray[indexPath.row];
    
    if (model.category == 3) {
        topicVC.topics_id = model.topic_id;
        NSLog(@"topics_id = %@",topicVC.topics_id);
        [self.navigationController pushViewController:topicVC animated:YES];
    }else if(model.category == 0){
        PostViewController *postVC = [[PostViewController alloc] init];
        postVC.topic_id = model.topic_id;
        [self.navigationController pushViewController:postVC animated:YES];
        NSLog(@"topics_id = %@",postVC.topic_id);
    }else{
        NSLog(@"model.category = %ld",model.category);
        ActivityDetailViewController *actiDetailVC = [[ActivityDetailViewController alloc] init];
        actiDetailVC.DetailIDString = model.topic_id;
        [self.navigationController pushViewController:actiDetailVC animated:YES];
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
