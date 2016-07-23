//
//  TopicDetailViewController.m
//  EPB_LiShi
//
//  Created by lanou3g on 16/7/22.
//  Copyright © 2016年 张鹏. All rights reserved.
//

#import "TopicDetailViewController.h"
#import "TopicDetailRequest.h"
#import "TopicDetailTableViewCell.h"
#import "TopicsDetailModel.h"
#import "ReplyModel.h"
#import "ReplyTableViewCell.h"
@interface TopicDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *topicTableView;
@property (strong, nonatomic) UIView *headView;
@property (strong, nonatomic) UIImageView *userHeadImg;
@property (strong, nonatomic) UILabel *nicknameLabel;
@property (strong, nonatomic) UIButton *attentionBtn;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *creatDateLabel;
// 存储详情的数组
@property (strong, nonatomic) NSMutableArray *dataArray;
// 存储评论的数组
@property (strong, nonatomic) NSMutableArray *replyArray;
// 底部评论输入框
@property (strong, nonatomic) UIView *putInView;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIButton *publishBtn;
@end

@implementation TopicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawView];
    // 注册cell
    [self.topicTableView registerClass:[TopicDetailTableViewCell class] forCellReuseIdentifier:TopicDetailTableViewCell_Identify];
    [self.topicTableView registerNib:[UINib nibWithNibName:@"ReplyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ReplyTableViewCell_Identify];
    // 初始化数组
    self.dataArray = [NSMutableArray array];
    self.replyArray = [NSMutableArray array];
    [self topicsRequest];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.rootVC.LSTabBar.hidden = YES;
    [self drawPutinView];
    
    // 添加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
}
// 绘制底部输入框
-(void)drawPutinView{
    self.putInView = [[UIView alloc] initWithFrame:CGRectMake(0, WindowHeight - 50, WindownWidth, 50)];
    self.putInView.backgroundColor = [UIColor clearColor];
    // 创建模糊View
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:(UIBlurEffectStyleLight)]];
    // 设定模糊View的尺寸
    effectView.frame = self.putInView.bounds;
    [self.putInView addSubview:effectView];
    
    [self.view addSubview:self.putInView];
    // 添加发送按钮
    self.publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.publishBtn.frame = CGRectMake(WindownWidth - 100 + 15, 10, 60, 40);
    [self.publishBtn setTitle:@"发表" forState:(UIControlStateNormal)];
    [self.publishBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [self.putInView addSubview:self.publishBtn];
    [self.publishBtn addTarget:self action:@selector(publishReolyAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    // 添加输入框
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, WindownWidth - 100, 40)];
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.layer.cornerRadius = 10;
    self.textField.layer.masksToBounds = 10;
    self.textField.placeholder = @"发表评论......";
    [self.putInView addSubview:self.textField];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.rootVC.LSTabBar.hidden = NO;
    [self.putInView removeFromSuperview];// 视图消失后移除输入框
    // 移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}
// 发表评论方法
-(void)publishReolyAction:(UIButton *)button{
    if (self.textField.text.length != 0) {
        NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
        [[TopicDetailRequest shareTopicDetailRequest] commentRequestWithContent:self.textField.text topics_id:self.topics_id user_id:user_id success:^(NSDictionary *dic) {
            NSString *error = [[dic objectForKey:@"data"] objectForKey:@"error"];
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:error preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *okaction = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    self.textField.text = @"";
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.topicTableView reloadData];
                    });
                }];
                [alertC addAction:okaction];
                [self presentViewController:alertC animated:YES completion:nil];
            });
        } failure:^(NSError *error) {
            
        }];
    }
    
}
// 观察者方法
-(void)keyboardWillShow:(NSNotification *)notification{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame = value.CGRectValue;
    
    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    // 添加移动动画，使视图跟随键盘移动
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        CGFloat bottom = WindowHeight-frame.size.height;
        //1.修改输入框View的位置
        CGRect rect = self.putInView.frame;
        rect.origin.y = bottom - self.putInView.frame.size.height;
        self.putInView.frame = rect;
        //2.修改tableView的高度
        // _tableView.height = _bottomView.top;
    } completion:^(BOOL finished) {
        // [self tableViewScrollToBottom];
    }];
    
    
}

// 界面绘制
-(void)drawView{
    self.topicTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 56, WindownWidth, WindowHeight - 51) style:(UITableViewStylePlain)];
    self.topicTableView.backgroundColor = [UIColor colorWithRed:220 /255.0 green:219 / 255.0 blue:195 / 255.0 alpha:1];
    self.topicTableView.delegate = self;
    self.topicTableView.dataSource = self;
    // 绘制头视图
    UIView *tableHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindownWidth, WindowHeight / 9 *2)];// tableView的头部视图
    tableHeadView.backgroundColor = [UIColor whiteColor];
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindownWidth, WindowHeight / 9)];
    self.headView.backgroundColor = [UIColor whiteColor];
    // 头视图底部线条
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WindownWidth - 10, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    lineView.center = CGPointMake(self.headView.center.x, self.headView.bounds.size.height - 1);
    lineView.alpha = 0.3;
    [self.headView addSubview:lineView];
    // 用户头像
    self.userHeadImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WindowHeight / 18, WindowHeight / 18)];
    self.userHeadImg.image = [UIImage imageNamed:@"boy_default"];
    self.userHeadImg.center = CGPointMake(self.userHeadImg.bounds.size.width / 2 + 10, self.headView.center.y);
    [self.headView addSubview:self.userHeadImg];
    // 用户昵称
    self.nicknameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WindowHeight / 9, WindowHeight / 36)];
    self.nicknameLabel.alpha = 0.7;
    self.nicknameLabel.center = CGPointMake(WindowHeight / 9 + 15 , self.headView.center.y - WindowHeight / 72);
    self.nicknameLabel.font = [UIFont systemFontOfSize:12.0];
    self.nicknameLabel.text = @"加载中";
    [self.headView addSubview:self.nicknameLabel];
    // 楼主图片
    UIImageView *louzhuImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    louzhuImg.center = CGPointMake(WindowHeight / 18 + 20 + 10 , self.headView.center.y + WindowHeight / 72);
    louzhuImg.image = [UIImage imageNamed:@"louzhu.jpg"];
    [self.headView addSubview:louzhuImg];
    // 关注按钮
    self.attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.attentionBtn.frame = CGRectMake(0, 0, WindowHeight / 12, WindowHeight / 24);
    self.attentionBtn.center = CGPointMake(WindownWidth - WindowHeight / 18 - 20, self.headView.center.y);
    [self.attentionBtn setTitle:@"+关注" forState:(UIControlStateNormal)];
    [self.attentionBtn setTitleColor:[UIColor greenColor] forState:(UIControlStateNormal)];
    // 设置账号标签的边框宽度为1
    self.attentionBtn.layer.borderWidth = 1;
    // 设置账号标签边框的弧度为5
    self.attentionBtn.layer.cornerRadius = 15;
    self.attentionBtn.layer.borderColor = [UIColor greenColor].CGColor;
    
    // 标题label
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.headView.bounds.size.height + 10, WindownWidth - 20, WindowHeight / 9 * 3 / 4)];
    self.titleLabel.text = @"师徒三人结组70年代担惊受恐阿萨德就按时间段里阿卡洛杉矶";
    self.titleLabel.font = [UIFont systemFontOfSize:21.0];
    self.titleLabel.numberOfLines = 0;
    // 创建时间label
    self.creatDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(WindownWidth - WindowHeight / 6 - 20, tableHeadView.bounds.size.height - WindowHeight / 36, WindowHeight / 6, WindowHeight / 36)];
    self.creatDateLabel.alpha = 0.9;
    self.creatDateLabel.font = [UIFont systemFontOfSize:15.0];
    self.creatDateLabel.text = @"加载中";
    
    [tableHeadView addSubview:self.creatDateLabel];
    [tableHeadView addSubview:self.titleLabel];
    [tableHeadView addSubview:self.headView];
    self.topicTableView.tableHeaderView = tableHeadView;
    [self.headView addSubview:self.attentionBtn];
    [self.view addSubview:self.topicTableView];
}
// 请求数据
-(void)topicsRequest{
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    [[TopicDetailRequest shareTopicDetailRequest] topicDetailRequestWithTopics_id:self.topics_id user_id:user_id success:^(NSDictionary *dic) {
        NSDictionary *data = [dic objectForKey:@"data"];
        NSString *title = [data objectForKey:@"title"];
        NSString *nickname = [data objectForKey:@"nickname"];
        NSString *headicon = [data objectForKey:@"headicon"];
        NSString *createtime = [data objectForKey:@"createtime"];
        NSArray *topicsdetaillist = [data objectForKey:@"topicsdetaillist"];
        NSArray *topicsreplylist = [data objectForKey:@"topicsreplylist"];
        for (NSDictionary *tempDic in topicsdetaillist) {
            TopicsDetailModel *model = [TopicsDetailModel new];
            [model setValuesForKeysWithDictionary:tempDic];
            [self.dataArray addObject:model];
        }
        for (NSDictionary *tempDic in topicsreplylist) {
            ReplyModel *model = [ReplyModel new];
            [model setValuesForKeysWithDictionary:tempDic];
            [self.replyArray addObject:model];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.titleLabel.text = title;
            [self.userHeadImg setImageWithURL:[NSURL URLWithString:headicon]];
            self.nicknameLabel.text = nickname;
            self.creatDateLabel.text = createtime;
            [self.topicTableView reloadData];
        });
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark ------ UITableView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.dataArray.count;
    }else{
        return self.replyArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TopicDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TopicDetailTableViewCell_Identify];
        cell.model = self.dataArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        ReplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReplyTableViewCell_Identify];
        cell.model = self.replyArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TopicsDetailModel *model = self.dataArray[indexPath.row];
        return [TopicDetailTableViewCell cellHeight:model];
    }else{
        return 126;
    }
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return @"精彩评论";
    }else{
        return @"---";
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.textField resignFirstResponder];
    CGRect frame = self.putInView.frame;
    frame.origin.y = WindowHeight - 50;
    self.putInView.frame = frame;
}
// 释放键盘响应
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

#pragma mark ------ 使tableView滑到底部
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
